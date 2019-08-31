import 'dart:async';
import 'dart:io';
import 'dart:convert' show utf8, base64;
import 'dart:convert';
import 'package:http/io_client.dart';

class TokenManager {
  DateTime _expiredate;
  String _token;
  IOClient _client;
  final String _baseurl;
  final String _apiclient;
  final String _apikey;

  TokenManager(this._baseurl, this._apiclient, this._apikey)
      : assert(_baseurl != null),
        assert(_baseurl != ''),
        assert(_apiclient != null),
        assert(_apiclient != ''),
        assert(_apikey != null),
        assert(_apikey != '') {
    _expiredate = DateTime.now();
    _token = "";
    _client = IOClient(HttpClient()..connectionTimeout = Duration(seconds: 10));
  }

  String get secret => base64.encode(utf8.encode("$_apiclient:$_apikey"));

  Future<String> getToken() async {
    if (DateTime.now().isBefore(_expiredate)) {
      return _token;
    }
    var response = await _client.post("$_baseurl/oauth/token",
        body: "grant_type=client_credentials",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Basic $secret"
        });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      _expiredate = _expiredate.add(Duration(seconds: json['expires_in']));
      _token = json['token_type'] + ' ' + json['access_token'];
      return _token;
    } else {
      throw Exception('No se pudo obtener el token');
    }
  }

  void dispose(){
    _client.close();
  }
}
