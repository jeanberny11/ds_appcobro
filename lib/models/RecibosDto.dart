import 'package:ds_appcobro/database/AppDatabase.dart';

class RecibosDto {
  String serial;
  String documento;
  String prestamoid;
  int idcliente;
  DateTime fecha;
  int idcobrador;
  double monto;
  int cuotasatrasadas;
  String concepto;
  bool sincronizado;
  bool ladob;

  RecibosDto._(
      this.serial,
      this.documento,
      this.prestamoid,
      this.idcliente,
      this.fecha,
      this.idcobrador,
      this.monto,
      this.cuotasatrasadas,
      this.concepto,
      this.sincronizado,
      this.ladob);

  factory RecibosDto(Recibo recibo) {
    return RecibosDto._(
        recibo.serial,
        recibo.documento,
        recibo.prestamoid,
        recibo.idcliente,
        recibo.fecha,
        recibo.idcobrador,
        recibo.monto,
        recibo.cuotasatrasadas,
        recibo.concepto,
        recibo.sincronizado,
        recibo.ladob);
  }
}
