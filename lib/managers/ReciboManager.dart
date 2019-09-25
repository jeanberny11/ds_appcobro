import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/models/RecibosM.dart';
import 'package:ds_appcobro/api/services/RecibosServices.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/database/dao/SecuenciasDao.dart';
import 'package:intl/intl.dart';

class ReciboManager {
  final RecibosServices _services;
  final RecibosDao _recibosDao;
  final PrestamosDao _prestamosDao;
  final SecuenciasDao _secuenciasDao;

  ReciboManager(this._services, this._recibosDao,this._prestamosDao,this._secuenciasDao);
  
  Future<int> createRecibo(Recibo recibo)=>_recibosDao.create(recibo);

  Future<List<Recibo>> getReciboNoSincronizados()=>_recibosDao.getReciboNoSincronizados();

  Future<Recibo> getRecibo(String serial)=>_recibosDao.getRecibo(serial);

  Future<int> setReciboSincronizado(String serial)=>_recibosDao.setReciboSincronizado(serial);

  Future<List<Pagare>> getPagaresPrestamo(String prestamoid)=>_prestamosDao.getPrestamoPagaresConBalance(prestamoid);

  Future<int> getSecuencia(String tipodoc,bool create)=>_secuenciasDao.getSecuencia(tipodoc, create);

  Future<int> setPrestamoCobrado(String prestamoid)=>_prestamosDao.setPrestamoCobrado(prestamoid);

  Future<Null> enviarRecibo(String serial) async {
    var recibo=await getRecibo(serial);
    var prestamo=await _prestamosDao.getPrestamo(recibo.prestamoid);
    var recibom = RecibosM(
        serial: recibo.serial,
        documento: recibo.documento,
        monto: recibo.monto,
        idcliente: prestamo.idcliente,
        concepto: recibo.concepto,
        efectivo: recibo.efectivo,
        fecha: DateFormat("yyyy-MM-dd").format(recibo.fecha),
        prestamoid: prestamo.prestamoid,
        requesttag: this.runtimeType.toString() + DateTime.now().toString(),
        telcob: System().currentcobrador.telefono,
        ladob: recibo.ladob);
    var reciboresult = await _services.enviarRecibo(recibom);
    if (reciboresult.insertado) {
      await _recibosDao.setReciboSincronizado(reciboresult.serial);
    } else {
      throw Exception("No se pudo sincronizar el recibo");
    }
  }
}