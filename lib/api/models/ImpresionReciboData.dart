import 'package:ds_appcobro/database/AppDatabase.dart';

class ImpresionReciboData {
  final Empresa _empresa;
  final Setting _setting;
  final Cobrador _cobrador;
  final Prestamo _prestamo;
  final Recibo _recibo;

  ImpresionReciboData(this._empresa, this._setting,this._cobrador,
      this._prestamo, this._recibo);

  Map<String, dynamic> toJson() {
    return {
      'empresa': _empresa.toJson(),
      'setting': _setting.toJson(),
      'cobrador':_cobrador,      
      'prestamo': _prestamo.toJson(),
      'recibo': _recibo.toJson()
    };
  }
}
