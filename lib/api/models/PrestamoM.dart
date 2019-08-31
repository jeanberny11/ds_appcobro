class PrestamoM {
  Header header;
  List<Detail> detalle;
  PrestamoM._(this.header, this.detalle);

  factory PrestamoM.fromJson(Map<String, dynamic> json) {
    var h = Header.fromJson(json['prestamo']);
    var d = json['pagares'].map<Detail>((map) => Detail.fromJson(map)).toList();
    return PrestamoM._(h, d);
  }
}

class Header {
  String prestamoid;
  int idprestamo;
  int idcliente;
  String nombre;
  String direccion;
  int cobradorid;
  double monto;
  double balance;
  int duracion;
  double cuota;
  int cuotasvenc;
  double montovencido;
  int ultimacuota;
  double balancecuota;
  double mora;
  bool ladob;

  Header._(
      this.prestamoid,
      this.idprestamo,
      this.idcliente,
      this.nombre,
      this.direccion,
      this.cobradorid,
      this.monto,
      this.balance,
      this.duracion,
      this.cuota,
      this.cuotasvenc,
      this.montovencido,
      this.ultimacuota,
      this.balancecuota,
      this.mora,
      this.ladob);

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header._(
        json['prestamoid'],
        json['idprestamo'],
        json['idcliente'],
        json['nombre'],
        json['direccion'],
        json['cobradorid'],
        json['monto'],
        json['balance'],
        json['duracion'],
        json['cuota'],
        json['cuotasvenc'],
        json['montovencido'],
        json['ultimacuota'],
        json['balancecuota'],
        json['mora'],
        json['ladob']);
  }
}

class Detail {
  int idpagare;
  String prestamoid;
  DateTime fechav;
  int pagare;
  double cuota;
  double capital;
  double interes;
  double comision;
  double mora;
  double balance;

  Detail._(this.idpagare, this.prestamoid,this.fechav, this.pagare, this.cuota,
      this.capital, this.interes, this.comision, this.mora, this.balance);

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail._(
        json['idpagare'],
        json['prestamoid'],
        DateTime.parse(json['fechav']),
        json['pagare'],
        json['cuota'],
        json['capital'],
        json['interes'],
        json['comision'],
        json['mora'],
        json['balance']);
  }
}
