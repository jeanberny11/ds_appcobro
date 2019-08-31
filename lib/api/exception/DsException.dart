class DsException implements Exception{
  final int code;
  final String message;
  DsException(this.code,this.message);

  @override
  String toString() {
    var error=code>0?'$code':'Unknow';
    return "Error: $error\n$message";
  }
}