import 'dart:convert';

import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/models/ImpresionReciboData.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/models/PrestamoDto.dart';
import 'package:flutter/services.dart';

class PrinterManager{
  static const printerchannel = const MethodChannel('com.dreamapp.ds_appcobro/printer');
  final PrestamosDao _prestamosDao;
  final RecibosDao _recibosDao;

  PrinterManager(this._prestamosDao, this._recibosDao);

  Future<String> printRecibo(String serial)async{
    var recibo=await _recibosDao.getRecibo(serial);
    var setting=System().setting;
    var cobrador=System().currentcobrador;
    var empresa=System().empresa;
    var prestamo=await _prestamosDao.getPrestamo(recibo.prestamoid);
    var impresionReciboData=ImpresionReciboData(empresa, setting, cobrador,PrestamoDto.fromEntity(prestamo), recibo);
    var res=await  printerchannel.invokeMethod<String>('printRecibo',jsonEncode(impresionReciboData.toJson()));
    return res;
  }
}
