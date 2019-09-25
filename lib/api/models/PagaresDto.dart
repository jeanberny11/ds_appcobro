class PagaresDto {
  int idpagare;
  String prestamoid;
  DateTime fechav;
  int pagare;
  double monto;
  double capital;
  double interes;
  double comision;
  double mora;
  double balance;

  PagaresDto._(
      this.idpagare,
      this.prestamoid,
      this.fechav,
      this.pagare,
      this.monto,
      this.capital,
      this.interes,
      this.comision,
      this.mora,
      this.balance);

  factory PagaresDto.fromJsom(Map<String, dynamic> json) {
    return PagaresDto._(
        json['idpagare'],
        json['prestamoid'],
        DateTime.parse(json['fechav']),
        json['pagare'],
        json['monto'],
        json['capital'],
        json['interes'],
        json['comision'],
        json['mora'],
        json['balance']);
  }
}
