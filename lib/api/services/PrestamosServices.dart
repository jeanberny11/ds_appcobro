import 'dart:convert';

import 'package:ds_appcobro/api/ApiClient.dart';
import 'package:ds_appcobro/api/ErrorResponse.dart';
import 'package:ds_appcobro/api/exception/DsException.dart';
import 'package:ds_appcobro/api/models/PrestamoM.dart';

class PrestamosServices{
  final ApiClient _client;
  final String _basepath = '/jomasysapi/v1/jomasys/prestamos';
  PrestamosServices(this._client);

  Future<List<PrestamoM>> getAllPrestamos() async{
    var servicepath = _basepath + "/completo";
    var response = await _client.getRequest(servicepath);
    if (response.statusCode == 200) {
      var jsonlist = jsonDecode(response.body);
      return jsonlist
          .map<PrestamoM>((json) => PrestamoM.fromJson(json))
          .toList();
    } else {
      if (response.body != null) {
        ErrorResponse errresponse;
        try {
          var errjson = jsonDecode(response.body);
          errresponse = ErrorResponse.fromjson(errjson);
        } catch (ex) {
          throw DsException(0, ex.toString());
        }
        throw DsException(errresponse.code, errresponse.type='\n'+errresponse.message);
      } else {
        throw DsException(0, 'Unknow api error!');
      }
    }
  }

  Future<List<PrestamoM>> getAllPrestamosxCobrador(int cobradorid) async{
    var servicepath = _basepath + "/xcobrador";
    var header={'cobradorid':cobradorid.toString()};
    var response = await _client.getRequest(servicepath,headers: header);
    if (response.statusCode == 200) {
      var jsonlist = jsonDecode(response.body);
      return jsonlist
          .map<PrestamoM>((json) => PrestamoM.fromJson(json))
          .toList();
    } else {
      if (response.body != null) {
        ErrorResponse errresponse;
        try {
          var errjson = jsonDecode(response.body);
          errresponse = ErrorResponse.fromjson(errjson);
        } catch (ex) {
          throw DsException(0, ex.toString());
        }
        throw DsException(errresponse.code, errresponse.type='\n'+errresponse.message);
      } else {
        throw DsException(0, 'Unknow api error!');
      }
    }
  }

  Future<DateTime> getServerDate() async{
    var servicepath='/jomasysapi/v1/jomasys/server/date';
    var response=await _client.headRequest(servicepath);
    if(response.statusCode==200){
      return DateTime.parse(response.headers['fecha']);
    }else{
      throw Exception("No se pudo obtener la fecha del servidor");
    }
  }
}