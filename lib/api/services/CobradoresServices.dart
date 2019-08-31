import 'dart:convert';

import 'package:ds_appcobro/api/ApiClient.dart';
import 'package:ds_appcobro/api/ErrorResponse.dart';
import 'package:ds_appcobro/api/exception/DsException.dart';
import 'package:ds_appcobro/api/models/CobradorM.dart';

class CobradoresServices {
  final ApiClient _client;
  final String _basepath = '/jomasysapi/v1/jomasys/cobradores';
  CobradoresServices(this._client);

  Future<List<CobradorM>> getCobradores() async {
    var servicepath = _basepath + "/list";
    var response = await _client.getRequest(servicepath);
    if (response.statusCode == 200) {
      var jsonlist = jsonDecode(response.body);
      return jsonlist
          .map<CobradorM>((json) => CobradorM.fromJson(json))
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
        throw DsException(errresponse.code, errresponse.message);
      } else {
        throw DsException(0, 'Unknow api error!');
      }
    }
  }
}
