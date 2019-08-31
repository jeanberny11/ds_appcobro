class Empresa {
  int id;
  String nombre;
  String direccion;
  String rnc;
  String telefono;
  String slogan;
  bool listadocompleto;
  bool primeromora;

  Empresa._(this.id, this.nombre, this.direccion, this.rnc, this.telefono,
      this.slogan, this.listadocompleto,this.primeromora);

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa._(json['id'], json['nombre'], json['direccion'], json['rnc'],
        json['telefono'], json['slogan'], json['listadocompleto'],json['primeromora']);
  }
}
