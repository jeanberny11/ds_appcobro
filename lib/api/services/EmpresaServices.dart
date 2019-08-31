import 'dart:convert';

import 'package:ds_appcobro/api/ApiClient.dart';
import 'package:ds_appcobro/api/ErrorResponse.dart';
import 'package:ds_appcobro/api/exception/DsException.dart';
import 'package:ds_appcobro/api/models/Empresa.dart';

class EmpresaServices {
  final ApiClient _client;
  final String _basepath = '/jomasysapi/v1/jomasys/empresa';
  EmpresaServices(this._client);

  Future<Empresa> getInfoEmpresa() async {
    var response = await _client.getRequest(_basepath);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Empresa.fromJson(json);
    } else {
      if (response.body != null) {
        ErrorResponse errresponse;
        try {
          var errjson = jsonDecode(response.body);
          errresponse = ErrorResponse.fromjson(errjson);
        } catch (ex) {
          throw DsException(0, ex.toString());
        }
        throw DsException(errresponse.code, errresponse.message);
      } else {
        throw DsException(0, 'Unknow api error!');
      }
    }
  }
}
