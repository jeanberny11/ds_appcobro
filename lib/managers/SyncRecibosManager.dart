import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/exception/DsException.dart';
import 'package:ds_appcobro/api/models/RecibosM.dart';
import 'package:ds_appcobro/api/models/RecibosResult.dart';
import 'package:ds_appcobro/api/services/RecibosServices.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

class SyncRecibosManager {
  final RecibosServices _services;
  final RecibosDao _recibosDao;
  final CobradorDao _cobradorDao;
  final PrestamosDao _prestamosDao;
  final SystemSettingDao _systemSettingDao;
  BehaviorSubject<SyncState> _sincsubject;
  bool _isexecuting;
  SyncRecibosManager(this._services, this._recibosDao, this._cobradorDao,
      this._prestamosDao, this._systemSettingDao);

  void init() {
    _sincsubject = BehaviorSubject();
    _sincsubject.add(InitState());
  }

  void dispose() {
    _sincsubject.close();
  }

  BehaviorSubject<SyncState> get sincsubject => this._sincsubject;
  bool get isexecuting => this._isexecuting;

  void verificar() async {
    _isexecuting = true;

    // Verificando la fecha de operacion
    _sincsubject.add(LoadingState("Verificando la fecha de operacion"));
    var systemsetting = await _systemSettingDao.getSystemSetting();
    var osdate = dtos(DateTime.now());
    if (systemsetting==null || systemsetting.fechaop.isBefore(stod(osdate))) {
      _sincsubject
          .add(ErrorState("Fecha de operaciones obsoleta, favor actualize!"));
      _isexecuting = false;
      return;
    }

    //verificando los parametros del sistema
    _sincsubject.add(LoadingState("Verificando los parametros del sistema"));
    if (System().empresa == null) {
      _sincsubject.add(ErrorState(
          "No hay empresa configurada en los parametros del sistema"));
      _isexecuting = false;
      return;
    }

    if (System().setting == null || System().setting.printeraddres.isEmpty) {
      _sincsubject.add(ErrorState(
          "No hay impresora configurada en los parametros del sistema"));
      _isexecuting = false;
      return;
    }

    if (System().currentcobrador == null) {
      _sincsubject.add(ErrorState(
          "No hay cobrador configurada en los parametros del sistema"));
      _isexecuting = false;
      return;
    }

    if (!System().setting.online) {
      _sincsubject.add(DoneState("Verificacion finalizada"));
      _isexecuting = false;
      return;
    }

    _sincsubject.add(LoadingState("Buscando recibos sin sincronizar"));
    var cantrec = await _recibosDao.getCountRecNoSinc();
    if (cantrec <= 0) {
      _sincsubject.add(DoneState("No hay recibos sin sincronizar"));
      _isexecuting = false;
      return;
    }
    _sincsubject.add(LoadingState("Enviando recibos..."));
    var listrecibos = await _recibosDao.getReciboNoSincronizados();
    List<RecibosResult> errorresult = List();
    for (var recibo in listrecibos) {
      var prestamo = await _prestamosDao.getPrestamo(recibo.prestamoid);
      var cobrador = await _cobradorDao.getCobrador(recibo.idcobrador);
      var recibom = RecibosM(
          serial: recibo.serial,
          documento: recibo.documento,
          prestamoid: recibo.prestamoid,
          idcliente: prestamo.idcliente,
          fecha: dtos(recibo.fecha),
          monto: recibo.monto,
          telcob: cobrador.telefono,
          concepto: recibo.concepto,
          efectivo: recibo.efectivo,
          requesttag: this.runtimeType.toString());
      _sincsubject.add(LoadingState("Enviando recibo no. ${recibo.documento}"));
      try {
        var result = await _services.enviarRecibo(recibom);
        if (result.insertado) {
          _recibosDao.setReciboSincronizado(result.serial);
        } else {
          errorresult.add(result);
        }
      } on DsException catch (ex) {
        _sincsubject.add(ErrorState("Error: ${ex.code} \n ${ex.message}"));
        _isexecuting = false;
        return;
      } on Exception catch (ex) {
        _sincsubject.add(ErrorState(ex.toString()));
        _isexecuting = false;
        return;
      }
    }
    if (errorresult.length > 0) {
      var err = '';
      for (var error in errorresult) {
        err += '${error.serial} \n';
      }
      _sincsubject.add(ErrorState('Los recibos $err no se pudieron enviar'));
      _isexecuting = false;
      return;
    } else {
      _sincsubject.add(DoneState("Recibos sincronizados con exito"));
    }
  }
}

class SyncState extends Equatable {}

class InitState extends SyncState {}

class LoadingState extends SyncState {
  String mensaje;
  LoadingState(this.mensaje);
}

class ErrorState extends SyncState {
  String error;
  ErrorState(this.error);
}

class DoneState extends SyncState {
  String mensaje;
  DoneState(this.mensaje);
}
