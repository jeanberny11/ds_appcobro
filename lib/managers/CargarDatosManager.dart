import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/exception/DsException.dart';
import 'package:ds_appcobro/api/services/PrestamosServices.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:flutter/foundation.dart';
import 'package:screen/screen.dart';

class CargarDatosManager extends ChangeNotifier {
  final PrestamosServices _services;
  final PrestamosDao _dao;
  final SystemSettingDao _systemSettingDao;
  CargaState _currentstate;
  DsException _error;
  String _mensaje;
  CargarDatosManager(this._services, this._dao, this._systemSettingDao) {
    _currentstate = CargaState.initstate;
    _mensaje = '';
  }

  void downloadData() async {
    _currentstate = CargaState.loadingstate;
    _mensaje = 'Verificando los parametros';
    notifyListeners();
    var empresa = System().empresa;
    if (empresa == null) {
      _error = DsException(0,
          "No se ha Configurado la empresa en el mobil no se puede proceder a la descarga de datos!");
      _currentstate = CargaState.errorstate;
      notifyListeners();
      return;
    }
    var cobrador = System().currentcobrador;
    if (cobrador == null) {
      _error = DsException(0,
          "No cobrador configurado para este usuario no se puede proceder a la descarga de datos!");
      _currentstate = CargaState.errorstate;
      notifyListeners();
      return;
    }
    Screen.keepOn(true);
    _mensaje = 'Limpiando las tablas...';
    notifyListeners();

    await _dao.deleteAllPrestamos();
    await _dao.deleteAllPagares();
    //await _dao.deleteAllClientes();

    _mensaje = 'Descargando los prestamos...';
    notifyListeners();
    try {
      var prestamoslist = empresa.listadocompleto
          ? await _services.getAllPrestamos()
          : await _services.getAllPrestamosxCobrador(cobrador.cobradorid);

      _mensaje = 'Insertando los prestamos...';
      notifyListeners();
      var index = 1;
      for (var p in prestamoslist) {
        _mensaje = 'Insertando $index de ${prestamoslist.length}...';
        notifyListeners();
        var pres=p.prestamo;
        var pag=p.pagares;
        var prestamo = Prestamo(
            prestamoid: pres.prestamoid,
            idprestamo: pres.idprestamo,
            idcliente: pres.idcliente,
            monto: pres.monto,
            balance: pres.balance,
            duracion: pres.duracion,
            cuota: pres.cuota,
            formapago: pres.formapago,
            nombre: pres.nombre,
            direccion: pres.direccion,
            cedula: pres.cedula,
            telefono: pres.telefono,
            sexo: pres.sexo,
            cobradorid: pres.cobradorid,
            fecha: pres.fecha,
            cuotasvenc: pres.cuotasvenc,
            montovencido: pres.montovencido,
            ultimacuota: pres.ultimacuota,
            balancecuota: pres.balancecuota,
            mora: pres.mora,
            ladob: pres.ladob,
            cobrado: false);
        var pagareslist = pag.map<Pagare>((detalle) => Pagare(
                prestamoid: detalle.prestamoid,
                fechavenc: detalle.fechav,
                idpagare: detalle.idpagare,
                monto: detalle.monto,
                capital: detalle.capital,
                interes: detalle.interes,
                comision: detalle.comision,
                mora: detalle.mora,
                balance: detalle.balance,
                pagare: detalle.pagare))
            .toList();
        await _dao.createPrestamo(prestamo);
        //await _dao.createCliente(cliente);
        await _dao.createAllPagares(pagareslist);
        index++;
      }
      _mensaje = 'Actualizando la fecha de proceso';
      notifyListeners();
      var fechaop = await _services.getServerDate();
      var systemsetting =
          SystemSetting(fechaop: fechaop, fechasinc: DateTime.now(), id: 1);
      await _systemSettingDao.create(systemsetting);
      Screen.keepOn(false);
      _mensaje = 'Proceso de descarga de datos completado con exito!';
      _currentstate = CargaState.donestate;
      notifyListeners();
    } on DsException catch (ex) {
      Screen.keepOn(false);
      _error = ex;
      _currentstate = CargaState.errorstate;
      notifyListeners();
    } on Exception catch (ex) {
      Screen.keepOn(false);
      _error = DsException(0, ex.toString());
      _currentstate = CargaState.errorstate;
      notifyListeners();
    }
  }

  void reset() {
    _currentstate = CargaState.initstate;
    _error = null;
    _mensaje = '';
    notifyListeners();
  }

  CargaState get currentstate => this._currentstate;
  DsException get error => this._error;
  String get mensaje => this._mensaje;
}

enum CargaState { initstate, loadingstate, errorstate, donestate }
