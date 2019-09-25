import 'dart:io';

import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:ds_appcobro/managers/PrinterManager.dart';
import 'package:ds_appcobro/managers/ReciboManager.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:device_info/device_info.dart';
import 'package:provider/provider.dart';

class ReciboView extends StatefulWidget {
  final Prestamo prestamo;
  const ReciboView({Key key, this.prestamo}) : super(key: key);
  @override
  _ReciboViewState createState() => _ReciboViewState();
}

class _ReciboViewState extends State<ReciboView> {
  Prestamo _prestamo;
  NumberFormat _numberFormat;
  TextEditingController _tcobrocontroller;
  Recibo _recibo;
  String _serial = "";
  int _efectivo = 1;
  Recibostate _currentstate;
  String _errormsg = '';
  @override
  void initState() {
    super.initState();
    _prestamo = widget.prestamo;
    _numberFormat = NumberFormat("###,###,##0.00");
    _tcobrocontroller = TextEditingController();
    _currentstate = Recibostate.initstate;
  }

  void _salvar(BuildContext context) async {
    var recibomanager = Provider.of<ReciboManager>(context);

    if (_tcobrocontroller.text.isEmpty || _tcobrocontroller.text == '') {
      mensaje(context, "Debe digitar el monto a cobrar!");
      return;
    }
    var montoacobrar = double.tryParse(_tcobrocontroller.text);
    if (montoacobrar == null || montoacobrar <= 0) {
      mensaje(context, "El monto a cobrar es incorrecto!");
      return;
    }
    _serial = "";
    setState(() {
      _currentstate = Recibostate.savingstate;
    });
    Map<String, dynamic> distribucion;
    try {
      var sistemsetting =
          await Provider.of<SystemSettingDao>(context).getSystemSetting();
      var cobrador = System().currentcobrador;
      var deviceid = '';
      var tipodoc = "RM";
      var pagares =
          await recibomanager.getPagaresPrestamo(_prestamo.prestamoid);
      if (pagares.isEmpty) {
        mensaje(context,
            "Este prestamo no tiene detalle, no se puede completar el proceso!");
        return;
      }
      var deviceinfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var build = await deviceinfo.androidInfo;
        deviceid = build.androidId;
      } else if (Platform.isIOS) {
        var build = await deviceinfo.iosInfo;
        deviceid = build.identifierForVendor;
      } else {
        deviceid = 'NO SUPPORT PLATFORM';
      }
      var secuencia = await recibomanager.getSecuencia(tipodoc, true);
      var wholenum = right('0000000$secuencia', 7);
      var documento = '$tipodoc${cobrador.cobradorid}$wholenum';
      _serial = deviceid + documento;
      distribucion = crearDistribucion(pagares, montoacobrar);
      _recibo = Recibo(
          serial: _serial,
          documento: documento,
          idcliente: _prestamo.idcliente,
          fecha: sistemsetting.fechaop,
          prestamoid: _prestamo.prestamoid,
          monto: montoacobrar,
          capital: distribucion['capital'],
          interes: distribucion['interes'],
          comision: distribucion['comision'],
          mora: distribucion['mora'],
          concepto: distribucion['concepto'],
          efectivo: _efectivo == 1,
          cuotasatrasadas:
              (_prestamo.cuotasvenc - distribucion['cuotaspagadas']) < 0
                  ? 0
                  : (_prestamo.cuotasvenc - distribucion['cuotaspagadas']),
          idcobrador: cobrador.id,
          ladob: _prestamo.ladob,
          sincronizado: false);
      var insert = await recibomanager.createRecibo(_recibo);
      if (insert <= 0) {
        setState(() {
          _errormsg = 'No se pudo guardar el recibo intentelo de nuevo';
          _currentstate = Recibostate.savingerror;
        });
        return;
      }
      recibomanager.setPrestamoCobrado(_prestamo.prestamoid);
    } on PlatformException catch (ex) {
      setState(() {
        _errormsg = ex.toString();
        _currentstate = Recibostate.savingerror;
      });
      return;
    } on Exception catch (ex) {
      setState(() {
        _errormsg = ex.toString();
        _currentstate = Recibostate.savingerror;
      });
      return;
    }

    try {
      setState(() {
        _currentstate = Recibostate.imprimiendo;
      });
      await _imprimir(context, _serial);
    } on PlatformException catch (ex) {
      setState(() {
        _errormsg = ex.toString();
        _currentstate = Recibostate.imprimirerror;
      });
      return;
    } on Exception catch (ex) {
      setState(() {
        _errormsg = ex.toString();
        _currentstate = Recibostate.imprimirerror;
      });
      return;
    }

    if (System().setting.online) {
      try {
        setState(() {
          _currentstate = Recibostate.sincronizando;
        });
        await recibomanager.enviarRecibo(_serial);
      } catch (ex) {
        setState(() {
          _errormsg = ex.toString();
          _currentstate = Recibostate.sincronizarerror;
        });
        return;
      }
    }
    setState(() {
      _currentstate = Recibostate.donestate;
    });

    Navigator.of(context).pop();
  }

  Future<Null> _imprimir(BuildContext context, String serial) async {
    var printmanager = Provider.of<PrinterManager>(context);
    await printmanager.printRecibo(serial);
  }

  Map<String, dynamic> crearDistribucion(List<Pagare> pagares, double acobrar) {
    var pagareinicial = 0;
    var pagaretotal = _prestamo.duracion;
    var pagarefinal = 0;
    var capital = 0.0;
    var interes = 0.0;
    var comision = 0.0;
    var mora = 0.0;
    var cuotaspagadas = 0;
    bool saldo = false;
    bool abono = false;
    var pagando = acobrar;
    if (System().empresa.primeromora) {
      for (var pagare in pagares) {
        if (pagare.mora > 0) {
          if (pagando >= pagare.mora) {
            abono = true;
            mora += pagare.mora;
            pagando -= pagare.mora;
          } else {
            abono = true;
            mora += pagando;
            pagando = 0;
          }
          if (pagando == 0) break;
        }
      }
      if (pagando > 0) {
        for (var pagare in pagares) {
          var bal = pagare.capital + pagare.interes + pagare.comision;
          if (pagando >= bal) {
            saldo = true;
            if (pagareinicial == 0) {
              pagareinicial = pagare.pagare;
            }
            pagarefinal = pagare.pagare;
            cuotaspagadas++;
            capital += pagare.capital;
            interes += pagare.interes;
            comision += pagare.comision;
            pagando -= bal;
          } else {
            abono = true;
            if (pagare.comision > 0 && pagando > 0) {
              if (pagando >= pagare.comision) {
                comision += pagare.comision;
                pagando -= pagare.comision;
              } else {
                comision += pagando;
                pagando = 0;
              }
            }
            if (pagare.interes > 0 && pagando > 0) {
              if (pagando >= pagare.interes) {
                interes += pagare.interes;
                pagando -= pagare.interes;
              } else {
                interes += pagando;
                pagando = 0;
              }
            }
            if (pagare.capital > 0 && pagando > 0) {
              if (pagando >= pagare.capital) {
                capital += pagare.capital;
                pagando -= pagare.capital;
              } else {
                capital += pagando;
                pagando = 0;
              }
            }
          }
          if (pagando == 0) break;
        }
      }
    } else {
      for (var pagare in pagares) {
        if (pagando >= pagare.balance) {
          saldo = true;
          cuotaspagadas++;
          if (pagareinicial == 0) {
            pagareinicial = pagare.pagare;
          }
          capital += pagare.capital;
          interes += pagare.interes;
          comision += pagare.comision;
          mora += pagare.mora;
          pagarefinal = pagare.pagare;
          pagando -= pagare.balance;
        } else {
          abono = true;
          if (pagare.mora > 0 && pagando > 0) {
            if (pagando >= pagare.mora) {
              mora += pagare.mora;
              pagando -= pagare.mora;
            } else {
              mora += pagando;
              pagando = 0;
            }
          }
          if (pagare.comision > 0 && pagando > 0) {
            if (pagando >= pagare.comision) {
              comision += pagare.comision;
              pagando -= pagare.comision;
            } else {
              comision += pagando;
              pagando = 0;
            }
          }
          if (pagare.interes > 0 && pagando > 0) {
            if (pagando >= pagare.interes) {
              interes += pagare.interes;
              pagando -= pagare.interes;
            } else {
              interes += pagando;
              pagando = 0;
            }
          }
          if (pagare.capital > 0 && pagando > 0) {
            if (pagando >= pagare.capital) {
              capital += pagare.capital;
              pagando -= pagare.capital;
            } else {
              capital += pagando;
              pagando = 0;
            }
          }
        }
        if (pagando == 0) break;
      }
    }
    var concepto = '';
    if (saldo) {
      concepto = concepto +
          "SALDO CUOTAS ($pagareinicial HASTA $pagarefinal/$pagaretotal) ";
    }
    if (saldo && abono) {
      concepto = concepto + "Y ABONO CUENTA ";
    } else if (abono) {
      concepto = concepto + " ABONO CUENTA ";
    }
    var result = Map<String, dynamic>();
    result['concepto'] = concepto;
    result['capital'] = capital;
    result['interes'] = interes;
    result['comision'] = comision;
    result['mora'] = mora;
    result['cuotaspagadas'] = cuotaspagadas;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Recibos de ing.",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: <Widget>[
          DsWidgetSelector(
            condition: _currentstate == Recibostate.initstate,
            onTrue: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _salvar(context);
              },
            ),
            onFalse: Container(),
          )
        ],
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(5.0),
          child: Builder(
            builder: (context) {
              switch (_currentstate) {
                case Recibostate.initstate:
                  return ListView(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Prestamo:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: TextBold(_prestamo.prestamoid),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Cliente:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: Text(
                                _prestamo.nombre,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Cuotas atrasadas:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: TextBold(
                                  _numberFormat.format(_prestamo.cuotasvenc)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Balance atrasado:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: TextBold(
                                  _numberFormat.format(_prestamo.montovencido)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Monto cuota:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: TextBold(
                                  _numberFormat.format(_prestamo.cuota)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Ultima cuota pagada:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: TextBold(_prestamo.ultimacuota.toString()),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Balance ult. cuota:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: TextBold(
                                  _numberFormat.format(_prestamo.balancecuota)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 232, 230, 100),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mora acumulada:",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 3,
                              child: TextBold(
                                  _numberFormat.format(_prestamo.mora)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TextBold("Monto a cobrar"),
                          TextField(
                            controller: _tcobrocontroller,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              hintText: "Monto a cobrar",
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Efectivo",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _efectivo,
                            onChanged: (value) {
                              setState(() {
                                _efectivo = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Cheque",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Radio(
                            value: 0,
                            groupValue: _efectivo,
                            onChanged: (value) {
                              setState(() {
                                _efectivo = value;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  );
                case Recibostate.savingstate:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Loader(
                          initialradius: 30,
                          animationduration: 3,
                          width: 60,
                          height: 60,
                          dotradius: 8,
                        ),
                        Text(
                          "Guardando recibo...",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                case Recibostate.savingerror:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _errormsg,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FlatButton(
                          textColor: Theme.of(context).accentColor,
                          child: Text("Aceptar"),
                          onPressed: () {
                            setState(() {
                              _errormsg = '';
                              _currentstate = Recibostate.initstate;
                            });
                          },
                        )
                      ],
                    ),
                  );
                case Recibostate.imprimiendo:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Loader(
                          initialradius: 30,
                          animationduration: 3,
                          width: 60,
                          height: 60,
                          dotradius: 8,
                        ),
                        Text(
                          "Imprimiendo recibo...",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                case Recibostate.imprimirerror:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _errormsg,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FlatButton(
                          textColor: Theme.of(context).accentColor,
                          child: Text("Reintentar"),
                          onPressed: () async {
                            try {
                              setState(() {
                                _currentstate = Recibostate.imprimiendo;
                              });
                              await _imprimir(context,_serial);
                            } on PlatformException catch (ex) {
                              setState(() {
                                _errormsg = ex.toString();
                                _currentstate = Recibostate.imprimirerror;
                              });
                              return;
                            } on Exception catch (ex) {
                              setState(() {
                                _errormsg = ex.toString();
                                _currentstate = Recibostate.imprimirerror;
                              });
                              return;
                            }

                            if (System().setting.online) {
                              try {
                                setState(() {
                                  _currentstate = Recibostate.sincronizando;
                                });
                                await Provider.of<ReciboManager>(context)
                                    .enviarRecibo(_recibo.serial);
                              } catch (ex) {
                                setState(() {
                                  _errormsg = ex.toString();
                                  _currentstate = Recibostate.sincronizarerror;
                                });
                                return;
                              }
                            }
                            setState(() {
                              _currentstate = Recibostate.donestate;
                            });

                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FlatButton(
                          textColor: Theme.of(context).accentColor,
                          child: Text("Omitir"),
                          onPressed: () async {
                            if (System().setting.online) {
                              try {
                                setState(() {
                                  _currentstate = Recibostate.sincronizando;
                                });
                                await Provider.of<ReciboManager>(context)
                                    .enviarRecibo(_recibo.serial);
                              } catch (ex) {
                                setState(() {
                                  _errormsg = ex.toString();
                                  _currentstate = Recibostate.sincronizarerror;
                                });
                                return;
                              }
                            }
                            setState(() {
                              _currentstate = Recibostate.donestate;
                            });
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
                case Recibostate.sincronizando:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Loader(
                          initialradius: 30,
                          animationduration: 3,
                          width: 60,
                          height: 60,
                          dotradius: 8,
                        ),
                        Text(
                          "Enviando recibo...",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                case Recibostate.sincronizarerror:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _errormsg,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FlatButton(
                          textColor: Theme.of(context).accentColor,
                          child: Text("Reintentar"),
                          onPressed: () async {
                            try {
                              setState(() {
                                _currentstate = Recibostate.sincronizando;
                              });
                              await Provider.of<ReciboManager>(context)
                                  .enviarRecibo(_recibo.serial);
                            } catch (ex) {
                              setState(() {
                                _errormsg = ex.toString();
                                _currentstate = Recibostate.sincronizarerror;
                              });
                              return;
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FlatButton(
                          textColor: Theme.of(context).accentColor,
                          child: Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
                case Recibostate.donestate:
                  return Center(
                    child: Text("Recibo Finalizado con exito!"),
                  );
                default:
                  {
                    return Container();
                  }
              }
            },
          )),
    );
  }
}

enum Recibostate {
  initstate,
  savingstate,
  savingerror,
  imprimiendo,
  imprimirerror,
  sincronizando,
  sincronizarerror,
  donestate
}
