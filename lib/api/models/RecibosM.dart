import 'package:flutter/material.dart';

class RecibosM {
  String _serial;
  String _documento;
  String _prestamoid;
  double _monto;
  int _idcliente;
  String _fecha;
  String _telcob;
  String _concepto;
  bool _efectivo;
  String _requesttag;

  RecibosM(
      {@required String serial,
      @required String documento,
      @required String prestamoid,
      @required double monto,
      @required int idcliente,
      @required String fecha,
      @required String telcob,
      @required String concepto,
      @required bool efectivo,
      @required requesttag}) {
    _serial = serial;
    _documento = documento;
    _prestamoid = prestamoid;
    _monto = monto;
    _idcliente = idcliente;
    _fecha = fecha;
    _telcob = telcob;
    _concepto = concepto;
    _efectivo = efectivo;
    _requesttag = requesttag;
  }

  Map<String, dynamic> toJson() {
    return {
      'serial': _serial,
      'documento': _documento,
      'prestamoid': _prestamoid,
      'monto': _monto,
      'fecha': _fecha,
      'idcliente': _idcliente,      
      'telcob': _telcob,
      'concepto': _concepto,
      'efectivo': _efectivo,
      'requesttag': _requesttag
    };
  }
}
