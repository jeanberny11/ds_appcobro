import 'dart:async';
import 'dart:convert';
import 'package:ds_appcobro/api/TokenManager.dart';
import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  TokenManager _tokenManager;
  bool _isInit = false;
  http.Client _inner;
  String _baseurl='';

  bool get isInit => this._isInit;
  String get baseurl=>this._baseurl;

  Future<Null> init(String baseurl, String client, String key) async{
    assert(baseurl != null, 'La url base no puede estar nulo');
    assert(client != null, 'El cliente no puede estar nulo');
    assert(key != null, 'El Api key no puede estar nulo');
    assert(baseurl != '', 'La url base no puede estar en blanco');
    assert(client != '', 'El cliente no puede estar en blanco');
    assert(key != '', 'El Api key no puede estar en blanco');
    _inner = http.Client();
    _baseurl=baseurl;
    _tokenManager = TokenManager(baseurl, client, key);
    _isInit = await test(baseurl);
  }

  Future<bool> test(String baseurl) async {
    try {
      _isInit=true;
      var url = '/jomasysapi/v1/jomasys/test';
      var response = await this.get(baseurl + url);
      return response.statusCode == 200;
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (!_isInit) {
      throw Exception('The Inner client is not init yet');
    }
    request.headers['Authorization'] = await _tokenManager.getToken();
    return _inner.send(request);
  }

   Future<http.Response> getRequest(servicepath, {Map<String, String> headers}){
     final url=_baseurl+servicepath;
     return this.get(url,headers: headers);
   }
  Future<http.Response> headRequest(servicepath, {Map<String, String> headers}){
     final url=_baseurl+servicepath;
     return this.head(url,headers: headers);
   }

  Future<http.Response> postRequest(String servicepath,String body,{Map<String, String> headers}){
    final url=_baseurl+servicepath;
    return this.post(url,body: body,headers: {'content-type':'application/json'},encoding: Encoding.getByName("utf-8"));
  }

  @override
  void close() {
    _tokenManager.dispose();
    _inner.close();
    super.close();
  }
}
