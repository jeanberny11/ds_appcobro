import 'package:ds_appcobro/database/AppDatabase.dart';

class PrestamoDto {
  String prestamoid;
  int idprestamo;
  int idcliente;
  DateTime fecha;
  double monto;
  double balance;
  int duracion;
  double cuota;
  String formapago;
  String nombre;
  String direccion;
  String cedula;
  String telefono;
  String sexo;
  int cobradorid;
  int cuotasvenc;
  double montovencido;
  int ultimacuota;
  double balancecuota;
  double mora;
  bool ladob;

  PrestamoDto._(
      this.prestamoid,
      this.idprestamo,
      this.idcliente,
      this.fecha,
      this.monto,
      this.balance,
      this.duracion,
      this.cuota,
      this.formapago,
      this.nombre,
      this.direccion,
      this.cedula,
      this.telefono,
      this.sexo,
      this.cobradorid,
      this.cuotasvenc,
      this.montovencido,
      this.ultimacuota,
      this.balancecuota,
      this.mora,
      this.ladob);

  factory PrestamoDto.fromEntity(Prestamo p) {
    return PrestamoDto._(
        p.prestamoid,
        p.idprestamo,
        p.idcliente,
        p.fecha,
        p.monto,
        p.balance,
        p.duracion,
        p.cuota,
        p.formapago,
        p.nombre,
        p.direccion,
        p.cedula,
        p.telefono,
        p.sexo,
        p.cobradorid,
        p.cuotasvenc,
        p.montovencido,
        p.ultimacuota,
        p.balancecuota,
        p.mora,
        p.ladob);
  }

  factory PrestamoDto.fromJson(Map<String, dynamic> json) {
    return PrestamoDto._(
        json['prestamoid'],
        json['idprestamo'],
        json['idcliente'],
        DateTime.parse(json['fecha']),
        json['monto'],
        json['balance'],
        json['duracion'],
        json['cuota'],
        json['formapago'],
        json['nombre'],
        json['direccion'],
        json['cedula'],
        json['telefono'],
        json['sexo'],
        json['cobradorid'],
        json['cuotasvenc'],
        json['montovencido'],
        json['ultimacuota'],
        json['balancecuota'],
        json['mora'],
        json['ladob']);
  }

  Map<String, dynamic> toJson() {
    return {
      'prestamoid': prestamoid,
      'idprestamo': idprestamo,
      'idcliente': idcliente,
      'nombre': nombre,
      'direccion': direccion,
      'cedula': cedula,
      'monto': monto,
      'duracion': duracion,
      'cuota': cuota,
      'formapago': formapago,
      'cuotasvenc': cuotasvenc,
      'montovencido': montovencido,
      'ultimacuota': ultimacuota,
      'balancecuota': balancecuota,
      'mora': mora,
      'ladob': ladob
    };
  }
}
