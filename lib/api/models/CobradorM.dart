class CobradorM {
  int cobradorid;
  String nombre;
  String direccion;
  String telefono;

  CobradorM._(this.cobradorid,this.nombre,this.direccion,this.telefono);

  factory CobradorM.fromJson(Map<String,dynamic> json){
    return CobradorM._(json['cobradorid'], json['nombre'], json['direccion'], json['telefono']);
  }
}
