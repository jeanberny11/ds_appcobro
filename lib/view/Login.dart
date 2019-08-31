import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/ApiClient.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/EmpresaDao.dart';
import 'package:ds_appcobro/database/dao/SettingDao.dart';
import 'package:ds_appcobro/database/dao/UsuarioDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _formkey = GlobalKey<FormState>();
  TextEditingController _usernamecontroller;
  TextEditingController _passwordcontroller;
  FocusNode _usefocus;
  FocusNode _passwordfocus;
  bool _isloading;
  bool _obscuretext = true;

  void _autenticar(BuildContext context) async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isloading = true;
      });
      _formkey.currentState.save();
      var usuario = await Provider.of<UsuarioDao>(context)
          .authUsuario(_usernamecontroller.text, _passwordcontroller.text);
      if (usuario == null) {
        mensaje(context, 'Usuario o contraseña incorrectas!');
        if (_usefocus.hasFocus) {
          _usefocus.unfocus();
        }
        if (_passwordfocus.hasFocus) {
          _passwordfocus.unfocus();
        }
        FocusScope.of(context).requestFocus(_usefocus);
        setState(() {
          _isloading = false;
        });
        return;
      }
      System().loadUsuario(usuario);
      var setting = await Provider.of<SettingDao>(context).findById(1);
      if (setting != null) {
        await Provider.of<ApiClient>(context).init(
          setting.internet ? setting.remoteurl : setting.localurl,
          setting.apiclient,
          setting.apikey);
        System().loadSetting(setting);
      }
      var empresa= await Provider.of<EmpresaDao>(context).findById(1);
      if(empresa!=null){
        System().loadEmpresa(empresa);
      }

      var cobrador=await Provider.of<CobradorDao>(context).getDefaultCobrador(usuario.usuarioid);
      if(cobrador!=null){
        System().loadCobrador(cobrador);
      }

      setState(() {
        _isloading = false;
      });
      Navigator.of(context).pushReplacementNamed(PageRoutes.homeroute);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    _isloading = false;
    _usernamecontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    _usefocus = FocusNode();
    _passwordfocus = FocusNode();
  }

  @override
  void dispose() {
    _usefocus.dispose();
    _passwordfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
          body: DsWidgetSelector(
        condition: MediaQuery.of(context).orientation == Orientation.portrait,
        onTrue: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor
                      ],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SafeArea(
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius:
                                MediaQuery.of(context).size.height * 0.08,
                            child: Text(
                              'DS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 10),
                            )),
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).accentColor,
                              blurRadius: 2)
                        ]),
                    child: TextFormField(
                      controller: _usernamecontroller,
                      focusNode: _usefocus,
                      enabled: !_isloading,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _usefocus.unfocus();
                        FocusScope.of(context).requestFocus(_passwordfocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nombre usuario',
                          icon: Icon(
                            Icons.person,
                            color: Theme.of(context).accentColor,
                            size: 32,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).accentColor,
                              blurRadius: 2)
                        ]),
                    child: TextFormField(
                      obscureText: _obscuretext,
                      controller: _passwordcontroller,
                      focusNode: _passwordfocus,
                      enabled: !_isloading,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        _passwordfocus.unfocus();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Contaseña',
                          icon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).accentColor,
                            size: 32,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_obscuretext
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscuretext = !_obscuretext;
                              });
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _isloading
                      ? Loader(
                          animationduration: 3,
                          initialradius: 20,
                          width: 40,
                          height: 40,
                        )
                      : InkWell(
                          onTap: () {
                            _autenticar(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).accentColor
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Center(
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                ],
              ))
            ],
          ),
        ),
        onFalse: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor
                      ],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.2,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).accentColor,
                              blurRadius: 2)
                        ]),
                    child: TextFormField(
                      controller: _usernamecontroller,
                      focusNode: _usefocus,
                      enabled: !_isloading,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _usefocus.unfocus();
                        FocusScope.of(context).requestFocus(_passwordfocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nombre usuario',
                          icon: Icon(
                            Icons.person,
                            color: Theme.of(context).accentColor,
                            size: 32,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).accentColor,
                              blurRadius: 2)
                        ]),
                    child: TextFormField(
                      obscureText: _obscuretext,
                      controller: _passwordcontroller,
                      focusNode: _passwordfocus,
                      enabled: !_isloading,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        _passwordfocus.unfocus();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obligatorio';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Contaseña',
                          icon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).accentColor,
                            size: 32,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_obscuretext
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscuretext = !_obscuretext;
                              });
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  _isloading
                      ? Loader(
                          animationduration: 3,
                          initialradius: 20,
                          width: 40,
                          height: 40,
                        )
                      : InkWell(
                          onTap: () {
                            _autenticar(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).accentColor
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Center(
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
}
