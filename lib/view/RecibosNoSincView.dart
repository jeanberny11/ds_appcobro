import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/models/RecibosM.dart';
import 'package:ds_appcobro/api/services/RecibosServices.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RecibosNoSincView extends StatefulWidget {
  @override
  _RecibosNoSincViewState createState() => _RecibosNoSincViewState();
}

class _RecibosNoSincViewState extends State<RecibosNoSincView> {
  bool _isloading;
  String _mensaje;

  @override
  void initState() {
    super.initState();
    _isloading = false;
    _mensaje = '';
  }

  void _enviarrecibos() async {
    var services = Provider.of<RecibosServices>(context);
    setState(() {
      _isloading = true;
      _mensaje = 'iniciando...';
    });
    List<Recibo> errorrecibos = List();
    var reciboslist =
        await Provider.of<RecibosDao>(context).getReciboNoSincronizados();
    for (var recibo in reciboslist) {
      setState(() {
        _mensaje = "Enviando recibo ${recibo.documento}";
      });
      var prestamo = await Provider.of<PrestamosDao>(context)
          .getPrestamo(recibo.prestamoid);
      var recibom = RecibosM(
          serial: recibo.serial,
          documento: recibo.documento,
          fecha: dtos(recibo.fecha),
          monto: recibo.monto,
          concepto: recibo.concepto,
          efectivo: recibo.efectivo,
          prestamoid: recibo.prestamoid,
          requesttag:
              this.runtimeType.toString() + DateTime.now().toIso8601String(),
          idcliente: prestamo.idcliente,
          telcob: System().currentcobrador.telefono,
          ladob: recibo.ladob);
      try {
        var reciboresult = await services.enviarRecibo(recibom);
        if (!reciboresult.insertado) {
          errorrecibos.add(recibo);
        } else {
          await Provider.of<RecibosDao>(context)
              .setReciboSincronizado(reciboresult.serial);
        }
      } catch (ex) {
        errorrecibos.add(recibo);
      }
    }
    if (errorrecibos.length > 0) {
      var recs = '';
      for (var errrec in errorrecibos) {
        recs += '${errrec.documento} \n';
      }
      mensaje(context, "Los recibos $recs no han sido sincronizados");
    }
    setState(() {
      _mensaje = "";
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isloading) {
          mensaje(context,
              "El proceso de enviado se esta ejecutando, por favor espere!");
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Sincronizar recibos",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: () {
                _enviarrecibos();
              },
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(8.0),
          child: DsWidgetSelector(
            condition: _isloading,
            onTrue: Center(
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
                    _mensaje,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            onFalse: StreamBuilder<List<Recibo>>(
              stream: Provider.of<RecibosDao>(context).watchRecNoSinc(),
              builder: (context, snp) {
                if (snp.connectionState == ConnectionState.active) {
                  if (snp.data.isEmpty) {
                    return Center(
                      child: Text("No hay recibos sin enviar"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snp.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    TextBold("Serial: "),
                                    Text(snp.data[index].serial)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    TextBold("Documento: "),
                                    Text(snp.data[index].documento)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    TextBold("Prestamo: "),
                                    Text(snp.data[index].prestamoid)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    TextBold("Fecha: "),
                                    Text(DateFormat('dd-MM-yyyy')
                                        .format(snp.data[index].fecha))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    TextBold("Monto: "),
                                    Text(NumberFormat('###,###,##0.00')
                                        .format(snp.data[index].monto))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    TextBold("Concepto: "),
                                    Flexible(
                                        child: Text(snp.data[index].concepto))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: Loader(
                      initialradius: 30,
                      animationduration: 3,
                      width: 60,
                      height: 60,
                      dotradius: 8,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
