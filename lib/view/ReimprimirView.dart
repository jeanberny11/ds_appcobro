import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/models/ImpresionReciboData.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/managers/PrinterManager.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReimprimirView extends StatefulWidget {
  @override
  _ReimprimirViewState createState() => _ReimprimirViewState();
}

class _ReimprimirViewState extends State<ReimprimirView> {
  DateTime _fecha1;
  DateTime _fecha2;
  TextEditingController _tfecha1;
  TextEditingController _tfecha2;

  @override
  void initState() {
    super.initState();
    var sfecha = dtos2(DateTime.now());
    _fecha1 = stod2(sfecha);
    _fecha2 = stod2(sfecha);
    _tfecha1 = TextEditingController(text: sfecha);
    _tfecha2 = TextEditingController(text: sfecha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Recibos",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DsWidgetSelector(
              condition: System().currentUser.level > 1,
              onTrue: Container(),
              onFalse: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _tfecha1,
                            readOnly: true,
                            decoration:
                                InputDecoration(hintText: 'Fecha inicial'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: _fecha1,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now());
                            if (date != null) {
                              setState(() {
                                _fecha1 = date;
                                _tfecha1.text = dtos2(date);
                              });
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _tfecha2,
                            readOnly: true,
                            decoration:
                                InputDecoration(hintText: 'Fecha final'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today,
                              color: Theme.of(context).accentColor),
                          onPressed: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: _fecha2,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now());
                            if (date != null) {
                              setState(() {
                                _fecha2 = date;
                                _tfecha2.text = dtos2(date);
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Recibo>>(
                future: Provider.of<RecibosDao>(context)
                    .getRecibosByDateRange(_fecha1, _fecha2),
                builder: (context, snp) {
                  if (snp.connectionState == ConnectionState.done) {
                    if (snp.hasError) {
                      return Center(
                        child: Text(
                          snp.error.toString(),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (snp.data.isEmpty) {
                      return Center(
                        child: Text(
                          "No hay prestamos en esa fecha!",
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: System().currentUser.level > 1
                            ? 1
                            : snp.data.length,
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
                                  FutureBuilder<Prestamo>(
                                    future: Provider.of<PrestamosDao>(context)
                                        .getPrestamo(
                                            snp.data[index].prestamoid),
                                    builder: (context, snp2) {
                                      if (snp2.connectionState ==
                                          ConnectionState.done) {
                                        return Row(
                                          children: <Widget>[
                                            TextBold("Cliente: "),
                                            Text(snp2.data.nombre)
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.print),
                                    onPressed: () async {
                                      var prestamo =
                                          await Provider.of<PrestamosDao>(
                                                  context)
                                              .getPrestamo(
                                                  snp.data[index].prestamoid);
                                      var cobrador =
                                          await Provider.of<CobradorDao>(
                                                  context)
                                              .getCobrador(
                                                  snp.data[index].idcobrador);
                                      var impresiondata = ImpresionReciboData(
                                          System().empresa,
                                          System().setting,
                                          cobrador,
                                          prestamo,
                                          snp.data[index]);
                                      try {
                                        var printmanager = PrinterManager();
                                        await printmanager
                                            .printRecibo(impresiondata);
                                      } on PlatformException catch (ex) {
                                        mensaje(context, ex.toString());
                                      } on Exception catch (ex) {
                                        mensaje(context, ex.toString());
                                      }
                                    },
                                  )
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
                        dotradius: 8,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
