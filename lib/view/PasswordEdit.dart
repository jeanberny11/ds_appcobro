import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/database/dao/UsuarioDao.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordEdit extends StatefulWidget {
  PasswordEdit();
  @override
  _PasswordEditState createState() => _PasswordEditState();
}

class _PasswordEditState extends State<PasswordEdit> {
  TextEditingController _tpasswordactualc;
  TextEditingController _tpasswordnewc;
  TextEditingController _tpasswordconfirmc;
  FocusNode _t1focus;
  FocusNode _t2focus;
  FocusNode _t3focus;

  @override
  void initState() {
    super.initState();
    _tpasswordactualc = TextEditingController();
    _tpasswordnewc = TextEditingController();
    _tpasswordconfirmc = TextEditingController();
    _t1focus = FocusNode();
    _t2focus = FocusNode();
    _t3focus = FocusNode();
  }

  void _cambiar(BuildContext context) async {
    var usuario = System().currentUser;
    if (_tpasswordactualc.text != usuario.clave) {
      notificar(context,'Contraseña actual no coincide!');
      return;
    }
    if (_tpasswordnewc.text != _tpasswordconfirmc.text) {
      notificar(context,'Hay diferencia en la contraseña a cambiar!');
      return;
    }
    var res = await Provider.of<UsuarioDao>(context)
        .updateUsuario(usuario.copyWith(clave: _tpasswordconfirmc.text));
    if (res) {
      notificar(context,"Contraseña cambiada con exito!");
      Navigator.of(context).pop();
    } else {
      mensaje(context, "No se pudo cambiar la contraseña!");
    }
  }

  @override
  void dispose() {
    _t1focus.dispose();
    _t2focus.dispose();
    _t3focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cambiar Contraseña"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        textTheme:
            TextTheme(title: TextStyle(color: Theme.of(context).primaryColor)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              TextBold(
                "Contraseña actual",
              ),
              TextField(
                controller: _tpasswordactualc,
                autofocus: true,
                focusNode: _t1focus,
                textInputAction: TextInputAction.next,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Contraseña actual'),
                onSubmitted: (value) {
                  _t1focus.unfocus();
                  FocusScope.of(context).requestFocus(_t2focus);
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextBold(
                "Contraseña nueva",
              ),
              TextField(
                controller: _tpasswordnewc,
                autofocus: true,
                focusNode: _t2focus,
                textInputAction: TextInputAction.next,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Contraseña nueva'),
                onSubmitted: (value) {
                  _t2focus.unfocus();
                  FocusScope.of(context).requestFocus(_t3focus);
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextBold(
                "Confirmar Contraseña",
              ),
              TextField(
                controller: _tpasswordconfirmc,
                autofocus: true,
                focusNode: _t3focus,
                textInputAction: TextInputAction.done,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Confirmar Contraseña'),
                onSubmitted: (value) {
                  _t3focus.unfocus();
                },
              ),
              SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                onTap: () {
                  _cambiar(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).accentColor
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                    child: Text(
                      'Cambiar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
