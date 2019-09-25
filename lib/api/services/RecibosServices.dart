import 'dart:convert';
import 'package:ds_appcobro/api/ApiClient.dart';
import 'package:ds_appcobro/api/ErrorResponse.dart';
import 'package:ds_appcobro/api/exception/DsException.dart';
import 'package:ds_appcobro/api/models/RecibosM.dart';
import 'package:ds_appcobro/api/models/RecibosResult.dart';

class RecibosServices {
  final ApiClient _client;
  final String _basepath = '/jomasysapi/v1/jomasys/recibos';
  RecibosServices(this._client);

  Future<RecibosResult> enviarRecibo(RecibosM recibo)async{
    var servicepath = _basepath + "/create";
    var post=jsonEncode(recibo.toJson());
    print(post);
    var response = await _client.postRequest(servicepath, post);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return RecibosResult.fromJson(json);
    } else {
      if (response.body != null) {
        ErrorResponse errresponse;
        try {
          var errjson = jsonDecode(response.body);
          errresponse = ErrorResponse.fromjson(errjson);
        } catch (ex) {
          throw DsException(0, response.body.toString());
        }
        if(errresponse.code==null){
          throw DsException(0, response.body.toString());
        }
        throw DsException(errresponse.code, errresponse.type='\n'+errresponse.message);
      } else {
        throw DsException(0, 'Unknow api error!');
      }
    }
  }

}
