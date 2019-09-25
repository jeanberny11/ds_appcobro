import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/models/RecibosM.dart';
import 'package:ds_appcobro/api/models/RecibosResult.dart';
import 'package:ds_appcobro/api/services/RecibosServices.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:ds_appcobro/api/exception/DsException.dart';

class CobroValidate extends StatefulWidget {
  final RecibosServices services;
  final RecibosDao recibosDao;
  final CobradorDao cobradorDao;
  final PrestamosDao prestamosDao;
  final SystemSettingDao systemSettingDao;
  final SearchMode searchMode;

  const CobroValidate(
      {Key key,
      @required this.services,
      @required this.recibosDao,
      @required this.cobradorDao,
      @required this.prestamosDao,
      @required this.systemSettingDao,
      @required this.searchMode})
      : super(key: key);

  @override
  _CobroValidateState createState() => _CobroValidateState();
}

class _CobroValidateState extends State<CobroValidate> {
  bool _isexecuting = false;
  ValState _valState;
  String _mensaje;

  @override
  void initState() {
    super.initState();
    _valState = ValState.done;
    _mensaje = '';
    _validate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _validate() async {
    setState(() {
      _isexecuting = true;
      _valState = ValState.loading;
    });
    setState(() {
      _mensaje = "Verificando la fecha de operacion";
    });
    var systemsetting = await widget.systemSettingDao.getSystemSetting();
    var osdate = dtos(DateTime.now());
    if (systemsetting == null || systemsetting.fechaop.isBefore(stod(osdate))) {
      setState(() {
        _isexecuting = false;
        _valState = ValState.error;
        _mensaje = "Fecha de operaciones obsoleta, favor actualize!";
      });
      return;
    }

    //verificando los parametros del sistema
    setState(() {
      _mensaje = "Verificando los parametros del sistema";
    });
    if (System().empresa == null) {
      setState(() {
        _isexecuting = false;
        _valState = ValState.error;
        _mensaje = "No hay empresa configurada en los parametros del sistema";
      });
      return;
    }

    if (System().setting == null || System().setting.printeraddres.isEmpty) {
      setState(() {
        _isexecuting = false;
        _valState = ValState.error;
        _mensaje = "No hay impresora configurada en los parametros del sistema";
      });
      return;
    }

    if (System().currentcobrador == null) {
      setState(() {
        _isexecuting = false;
        _valState = ValState.error;
        _mensaje = "No hay cobrador configurada en los parametros del sistema";
      });
      return;
    }

    if (!System().setting.online) {
      setState(() {
        _isexecuting = false;
        _valState = ValState.done;
        _mensaje = '';
      });
      _openCobro();
    } else {
      setState(() {
        _mensaje = "Buscando recibos sin sincronizar";
      });
      var cantrec = await widget.recibosDao.getCountRecNoSinc();
      if (cantrec <= 0) {
        setState(() {
          _isexecuting = false;
          _valState = ValState.done;
          _mensaje = '';
        });
        _openCobro();
        return;
      }
      setState(() {
        _mensaje = "Enviando recibos...";
      });
      var listrecibos = await widget.recibosDao.getReciboNoSincronizados();
      List<RecibosResult> errorresult = List();
      for (var recibo in listrecibos) {
        var prestamo = await widget.prestamosDao.getPrestamo(recibo.prestamoid);
        var cobrador = await widget.cobradorDao.getCobrador(recibo.idcobrador);
        var recibom = RecibosM(
            serial: recibo.serial,
            documento: recibo.documento,
            prestamoid: recibo.prestamoid,
            idcliente: prestamo.idcliente,
            fecha: dtos(recibo.fecha),
            monto: recibo.monto,
            telcob: cobrador.telefono,
            concepto: recibo.concepto,
            efectivo: recibo.efectivo,
            requesttag: this.runtimeType.toString()+DateTime.now().toString(),
            ladob: recibo.ladob);
        setState(() {
          _mensaje = "Enviando recibo no. ${recibo.documento}";
        });
        try {
          var result = await widget.services.enviarRecibo(recibom);
          if (result.insertado) {
            widget.recibosDao.setReciboSincronizado(result.serial);
          } else {
            errorresult.add(result);
          }
        } on DsException catch (ex) {
          setState(() {
            _isexecuting = false;
            _valState = ValState.error;
            _mensaje = ex.toString();
          });
          break;
        } on Exception catch (ex) {
          setState(() {
            _isexecuting = false;
            _valState = ValState.error;
            _mensaje = ex.toString();
          });
          break;
        }
      }
      _openCobro();
    }
  }

  void _openCobro() {
    switch (widget.searchMode) {
      case SearchMode.all:
        Navigator.of(context).pushReplacementNamed(PageRoutes.outallpresrecibos);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isexecuting) {
          mensaje(context,
              "Se esta ejecutando el proceso de sincronizacion, por favor espere!");
          return false;
        }
        return true;
      },
      child: Material(
        child: Builder(
          builder: (context) {
            switch (_valState) {
              case ValState.loading:
                {
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
                        ),
                        Text(
                          _mensaje,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }
              case ValState.error:
                {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _mensaje,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          child: Text("Aceptar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
                }
              case ValState.done:
                {
                  return Container();
                }
              default:
                {
                  return Container();
                }
            }
          },
        ),
      ),
    );
  }
}

enum ValState { loading, error, done }

enum SearchMode {
  all,
}
