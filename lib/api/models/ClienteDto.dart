class ClienteDto {
  int idcliente;
  String nombre;
  String direccion;
  String cedula;
  String telefono;
  String sexo;
  bool lado;

  ClienteDto._(this.idcliente, this.nombre, this.direccion, this.cedula,
      this.telefono, this.sexo,this.lado);

  factory ClienteDto.fromJson(Map<String, dynamic> json) {
    return ClienteDto._(json['idcliente'], json['nombre'], json['direccion'],
        json['cedula'], json['telefono'], json['sexo'],json['lado']);
  }
}
