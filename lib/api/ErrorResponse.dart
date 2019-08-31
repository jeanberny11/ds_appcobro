class ErrorResponse{
  int status;
  int code;
  String message;
  String type;
 
  ErrorResponse.fromjson(Map<String, dynamic> json) {
    this.status=json["status"];
    this.code=json["code"];
    this.message=json["message"];
    this.type=json["type"];
  }

  Map<String,dynamic > toJson()=>{
    "status":status,
    "code":code,
    "message":message,
    "type":type
  };
}