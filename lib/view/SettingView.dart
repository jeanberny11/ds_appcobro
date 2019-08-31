import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/ApiClient.dart';
import 'package:ds_appcobro/bluetooth/BluetoothManager.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/SettingDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/StringResources.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SettingView extends StatefulWidget {
  final Setting setting;
  SettingView(this.setting);
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _remoteurlcontroller;
  TextEditingController _localurlcontroller;
  TextEditingController _apiclientcontroller;
  TextEditingController _apikeycontroller;
  TextEditingController _ncopiascontroller;
  TextEditingController _delaycopiascontroller;
  TextEditingController _printernamecontroller;
  TextEditingController _printeraddresscontroller;
  FocusNode _remoteurlfocus;
  FocusNode _localurlfocus;
  FocusNode _apiclientfocus;
  FocusNode _apikeyfocus;
  FocusNode _ncopiasfocus;
  FocusNode _delaycopiasfocus;
  bool _isloading;
  bool _online;
  bool _internet;

  @override
  void initState() {
    super.initState();
    var _setting = widget.setting;
    _isloading = false;
    _remoteurlcontroller = TextEditingController(text: _setting.remoteurl);
    _localurlcontroller = TextEditingController(text: _setting.localurl);
    _apiclientcontroller = TextEditingController(text: _setting.apiclient);
    _apikeycontroller = TextEditingController(text: _setting.apikey);
    _ncopiascontroller =
        TextEditingController(text: _setting.npopias.toString());
    _delaycopiascontroller =
        TextEditingController(text: _setting.delaycopias.toString());
    _printeraddresscontroller =
        TextEditingController(text: _setting.printeraddres);
    _printernamecontroller =
        TextEditingController(text: _setting.printername);
    _online = _setting.online;
    _internet = _setting.internet;
    _remoteurlfocus = FocusNode();
    _localurlfocus = FocusNode();
    _apiclientfocus = FocusNode();
    _apikeyfocus = FocusNode();
    _ncopiasfocus = FocusNode();
    _delaycopiasfocus = FocusNode();
  }

  @override
  void dispose() {
    _remoteurlfocus.dispose();
    _localurlfocus.dispose();
    _apiclientfocus.dispose();
    _apikeyfocus.dispose();
    _ncopiasfocus.dispose();
    _delaycopiasfocus.dispose();
    super.dispose();
  }

  void salvar(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isloading = true;
      });
      _formKey.currentState.save();
      await Provider.of<ApiClient>(context).init(
          _internet ? _remoteurlcontroller.text : _localurlcontroller.text,
          _apiclientcontroller.text,
          _apikeycontroller.text);
      if (!Provider.of<ApiClient>(context).isInit) {
        var q = await confirmaraviso(context,
            'La conexion con el servidor no se pudo iniciar con esta configuracion! \n Desea salvar esta configuracion de todas formas?',
            btnok: 'Si', btncancel: 'No');
        if (!q) {
          setState(() {
            _isloading = false;
          });
          return;
        }
      }
      var setting = Setting(
          id: 1,
          remoteurl: _remoteurlcontroller.text,
          localurl: _localurlcontroller.text,
          apiclient: _apiclientcontroller.text,
          apikey: _apikeycontroller.text,
          online: _online,
          internet: _internet,
          npopias: int.parse(_ncopiascontroller.text),
          delaycopias: int.parse(_delaycopiascontroller.text),
          printername: _printernamecontroller.text,
          printeraddres: _printeraddresscontroller.text);
      try {
        var s = await Provider.of<SettingDao>(context).create(setting);
        if (s <= 0) {
          mensaje(context, 'No se pudo guardar la configuracion');
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            StringResources.of(context).settingtitle,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          actions: <Widget>[
            _isloading
                ? Loader(
                    initialradius: 12,
                    animationduration: 3,
                    width: 24,
                    height: 24,
                  )
                : IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      salvar(context);
                    },
                  )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: System().currentUser.level == 2
                ? <Widget>[
                    TextBold(StringResources.of(context).delaycopias),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: _delaycopiascontroller,
                      focusNode: _delaycopiasfocus,
                      enabled: !_isloading,
                      onFieldSubmitted: (value) {
                        _delaycopiasfocus.unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: StringResources.of(context).delaycopias,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold(StringResources.of(context).printername),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _printernamecontroller,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: StringResources.of(context).printername,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.print,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PageRoutes.bluetoothpicker)
                                .then((device) {
                              setState(() {
                                _printernamecontroller.text =
                                    (device as BluetoothDevice).nombre;
                                _printeraddresscontroller.text =
                                    (device as BluetoothDevice).address;
                              });
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold(StringResources.of(context).printeraddress),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _printeraddresscontroller,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: StringResources.of(context).printeraddress,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextBold(StringResources.of(context).online),
                        Switch(
                          value: _online,
                          onChanged: (value) {
                            setState(() {
                              _online = value;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextBold(
                            StringResources.of(context).internetconnection),
                        Switch(
                          value: _internet,
                          onChanged: (value) {
                            setState(() {
                              _internet = value;
                            });
                          },
                        )
                      ],
                    )
                  ]
                : <Widget>[
                    TextBold('Remote url'),
                    TextFormField(
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      controller: _remoteurlcontroller,
                      autofocus: true,
                      enabled: !_isloading,
                      focusNode: _remoteurlfocus,
                      onFieldSubmitted: (value) {
                        _remoteurlfocus.unfocus();
                        FocusScope.of(context).requestFocus(_localurlfocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'La url del api no debe estar en blanco';
                        } else if (!isURL(value)) {
                          return 'La url digitada no es valida!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: StringResources.of(context).remoteurl,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold(StringResources.of(context).localurl),
                    TextFormField(
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      controller: _localurlcontroller,
                      focusNode: _localurlfocus,
                      enabled: !_isloading,
                      onFieldSubmitted: (value) {
                        _localurlfocus.unfocus();
                        FocusScope.of(context).requestFocus(_apiclientfocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'La url local no debe estar en blanco';
                        } else if (!isURL(value)) {
                          return 'La url digitada no es valida!';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: StringResources.of(context).localurl,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold('Api client'),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _apiclientcontroller,
                      focusNode: _apiclientfocus,
                      maxLength: 10,
                      enabled: !_isloading,
                      onFieldSubmitted: (value) {
                        _apiclientfocus.unfocus();
                        FocusScope.of(context).requestFocus(_apikeyfocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'La client del api no debe estar en blanco';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Api Client',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold('Api key'),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: _apikeycontroller,
                      focusNode: _apikeyfocus,
                      maxLength: 10,
                      obscureText: true,
                      enabled: !_isloading,
                      onFieldSubmitted: (value) {
                        _apikeyfocus.unfocus();
                        FocusScope.of(context).requestFocus(_ncopiasfocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'La clave del api no debe estar en blanco';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Api key',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold(StringResources.of(context).ncopias),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: _ncopiascontroller,
                      focusNode: _ncopiasfocus,
                      enabled: !_isloading,
                      onFieldSubmitted: (value) {
                        _ncopiasfocus.unfocus();
                        FocusScope.of(context).requestFocus(_delaycopiasfocus);
                      },
                      decoration: InputDecoration(
                        hintText: StringResources.of(context).ncopias,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold(StringResources.of(context).delaycopias),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: _delaycopiascontroller,
                      focusNode: _delaycopiasfocus,
                      enabled: !_isloading,
                      onFieldSubmitted: (value) {
                        _delaycopiasfocus.unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: StringResources.of(context).delaycopias,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold(StringResources.of(context).printername),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _printernamecontroller,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: StringResources.of(context).printername,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.print,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PageRoutes.bluetoothpicker)
                                .then((device) {
                              setState(() {
                                _printernamecontroller.text =
                                    (device as BluetoothDevice).nombre;
                                _printeraddresscontroller.text =
                                    (device as BluetoothDevice).address;
                              });
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextBold(StringResources.of(context).printeraddress),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _printeraddresscontroller,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: StringResources.of(context).printeraddress,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextBold(StringResources.of(context).online),
                        Switch(
                          value: _online,
                          onChanged: (value) {
                            setState(() {
                              _online = value;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextBold(
                            StringResources.of(context).internetconnection),
                        Switch(
                          value: _internet,
                          onChanged: (value) {
                            setState(() {
                              _internet = value;
                            });
                          },
                        )
                      ],
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
