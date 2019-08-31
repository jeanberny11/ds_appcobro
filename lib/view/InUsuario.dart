import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/UsuarioDao.dart';
import 'package:ds_appcobro/database/dao/UsuarioLevelDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/StringResources.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InUsuario extends StatefulWidget {
  final Usuario usuario;
  const InUsuario({Key key, this.usuario}) : super(key: key);
  @override
  _InUsuarioState createState() => _InUsuarioState();
}

class _InUsuarioState extends State<InUsuario> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _usuariocontroller;
  TextEditingController _clavecontroller;
  TextEditingController _nombrecontroller;
  TextEditingController _direccioncontroller;
  TextEditingController _telefonocontroller;
  int _usuarioid;
  int _level;
  bool _activo;
  final _usuariofocus = FocusNode();
  final _clavefocus = FocusNode();
  final _nombrefocus = FocusNode();
  final _direccionfocus = FocusNode();
  final _telefonofocus = FocusNode();
  bool _isloading;

  @override
  void initState() {
    super.initState();
    _isloading = false;
    var usuario = widget.usuario;
    _usuariocontroller = TextEditingController(text: usuario.usuario);
    _clavecontroller = TextEditingController(text: usuario.clave);
    _nombrecontroller = TextEditingController(text: usuario.nombre);
    _direccioncontroller = TextEditingController(text: usuario.direccion);
    _telefonocontroller = TextEditingController(text: usuario.telefono);
    _usuarioid = usuario.usuarioid;
    _level = usuario.level;
    _activo = usuario.activo;
  }

  @override
  void dispose() {
    _usuariofocus.dispose();
    _clavefocus.dispose();
    _nombrefocus.dispose();
    _direccionfocus.dispose();
    _telefonofocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _usuariocontroller.text,
      child: Form(
        key: _formkey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Usuairo',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            actions: <Widget>[
              DsWidgetSelector(
                condition: _usuarioid != null || _usuarioid != 0,
                onTrue: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.people),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            PageRoutes.cobradorroute,
                            arguments: _usuarioid);
                      },
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                        child: StreamBuilder<int>(
                          stream: Provider.of<CobradorDao>(context)
                              .watchCobradorCountByUser(_usuarioid),
                          builder: (context, snp) {
                            if (snp.hasData && snp.data != null) {
                              return Text(
                                snp.data.toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              );
                            } else {
                              return Text(
                                '0',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              );
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                onFalse: Container(),
              ),
              DsWidgetSelector(
                condition: _isloading,
                onTrue: Loader(
                  initialradius: 15,
                  animationduration: 3,
                  width: 30,
                  height: 30,
                ),
                onFalse: IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();
                      setState(() {
                        _isloading = true;
                      });
                      var usuario = Usuario(
                          usuarioid: _usuarioid,
                          usuario: _usuariocontroller.text,
                          clave: _clavecontroller.text,
                          nombre: _nombrecontroller.text,
                          direccion: _direccioncontroller.text,
                          telefono: _telefonocontroller.text,
                          level: _level,
                          activo: _activo);
                      try {
                        var save = await Provider.of<UsuarioDao>(context)
                            .create(usuario);
                        if (save <= 0) {
                          mensaje(
                              context, 'No se pudo guardar la configuracion');
                          return;
                        }
                        setState(() {
                          _isloading = false;
                        });
                        Navigator.of(context).pop();
                      } catch (ex) {
                        setState(() {
                          _isloading = false;
                        });
                        mensaje(context, ex.toString());
                        return;
                      }
                    }
                  },
                ),
              )
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                TextBold(
                  StringResources.of(context).nombre,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _nombrecontroller,
                  autofocus: true,
                  focusNode: _nombrefocus,
                  onFieldSubmitted: (value) {
                    _nombrefocus.unfocus();
                    FocusScope.of(context).requestFocus(_direccionfocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return StringResources.of(context).emptyvalidate;
                    }
                    return null;
                  },
                  enabled: !_isloading,
                  decoration: InputDecoration(
                    hintText: StringResources.of(context).nombre,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextBold(
                  StringResources.of(context).dirrecion,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _direccioncontroller,
                  focusNode: _direccionfocus,
                  onFieldSubmitted: (value) {
                    _direccionfocus.unfocus();
                    FocusScope.of(context).requestFocus(_telefonofocus);
                  },
                  enabled: !_isloading,
                  decoration: InputDecoration(
                    hintText: StringResources.of(context).dirrecion,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextBold(
                  StringResources.of(context).telefono,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: _telefonocontroller,
                  focusNode: _telefonofocus,
                  onFieldSubmitted: (value) {
                    _telefonofocus.unfocus();
                    FocusScope.of(context).requestFocus(_usuariofocus);
                  },
                  enabled: !_isloading,
                  decoration: InputDecoration(
                    hintText: StringResources.of(context).telefono,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextBold(
                  StringResources.of(context).nombreusuario,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _usuariocontroller,
                  focusNode: _usuariofocus,
                  onFieldSubmitted: (value) {
                    _usuariofocus.unfocus();
                    FocusScope.of(context).requestFocus(_clavefocus);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return StringResources.of(context).emptyvalidate;
                    }
                    return null;
                  },
                  enabled: !_isloading,
                  decoration: InputDecoration(
                    hintText: StringResources.of(context).nombreusuario,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextBold(
                  StringResources.of(context).password,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: _clavecontroller,
                  focusNode: _clavefocus,
                  onFieldSubmitted: (value) {
                    _clavefocus.unfocus();
                  },
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return StringResources.of(context).emptyvalidate;
                    }
                    return null;
                  },
                  enabled: !_isloading,
                  decoration: InputDecoration(
                    hintText: StringResources.of(context).password,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextBold(
                  StringResources.of(context).usuariolevel,
                ),
                Row(
                  children: <Widget>[
                    FutureBuilder<List<UsuarioLevel>>(
                      future: Provider.of<UsuarioLevelDao>(context).findAll(),
                      builder: (context, snp) {
                        if (snp.hasError) {
                          return Text(snp.error.toString());
                        } else if (snp.data == null) {
                          return Loader(
                            initialradius: 15,
                            animationduration: 3,
                            width: 30,
                            height: 30,
                          );
                        } else {
                          return DropdownButton<int>(
                            items: List<DropdownMenuItem<int>>.generate(
                                snp.data.length, (index) {
                              return DropdownMenuItem<int>(
                                value: snp.data[index].level,
                                child: Text(snp.data[index].nombre),
                              );
                            }),
                            disabledHint:
                                Text(StringResources.of(context).usuariolevel),
                            onChanged: (value) {
                              setState(() {
                                _level = value;
                              });
                            },
                            value: _level,
                          );
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextBold(
                  StringResources.of(context).activo,
                ),
                Row(
                  children: <Widget>[
                    Switch(
                      value: _activo,
                      onChanged: (value) {
                        setState(() {
                          _activo = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
