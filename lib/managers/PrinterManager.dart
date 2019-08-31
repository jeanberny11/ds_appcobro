import 'dart:convert';

import 'package:ds_appcobro/api/models/ImpresionReciboData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PrinterManager extends ChangeNotifier{
  static const printerchannel = const MethodChannel('com.dreamapp.ds_appcobro/printer');

  Future<String> printRecibo(ImpresionReciboData impresionReciboData){    
    return  printerchannel.invokeMethod<String>('printRecibo',jsonEncode(impresionReciboData.toJson()));
  }
}
