import 'dart:io';
import 'package:ds_appcobro/utils/StringResources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

Future<bool> confirmaraviso(BuildContext context, String mensaje,
    {String btnok, String btncancel}) async {
  var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(StringResources.of(context).confirmmessaetitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(mensaje)],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child:
                  Text(btncancel ?? StringResources.of(context).cancelbutton),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text(btnok ?? StringResources.of(context).okbutton),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        );
      });
  return result;
}

mensaje(BuildContext context, String mensaje,
    {String title, String buttontext}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5.0,
          title: Text(title ?? StringResources.of(context).messagetitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(mensaje)],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(buttontext ?? "ACEPTAR"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
}

notificar(BuildContext context,String mensaje) {
  Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      timeInSecForIos: 2);
}

Future<bool> haveconnection(String url) async {
  try {
    var uri = Uri.parse(url);
    final result = await InternetAddress.lookup(uri.host);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

String right(String value, int len) {
  return value.substring(value.length - len);
}

String dtos(DateTime date) {
  var format = DateFormat("yyyy-MM-dd");
  return format.format(date);
}

String dtos2(DateTime date) {
  var format = DateFormat("dd-MM-yyyy");
  return format.format(date);
}

DateTime stod(String fecha){
  var format = DateFormat("yyyy-MM-dd");
  return format.parse(fecha);
}

DateTime stod2(String fecha){
  var format = DateFormat("dd-MM-yyyy");
  return format.parse(fecha);
}
