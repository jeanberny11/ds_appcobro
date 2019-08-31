class RecibosResult{
  String serial;
  bool insertado;
  RecibosResult._(this.serial,this.insertado);

  factory RecibosResult.fromJson(Map<String,dynamic> json){
    return RecibosResult._(json['serial'],json['insertado']);
  }
}