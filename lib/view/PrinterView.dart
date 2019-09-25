import 'package:ds_appcobro/api/models/ImpresionReciboData.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';

class PrinterView extends StatefulWidget {
  final ImpresionReciboData impresionReciboData;

  const PrinterView({Key key, this.impresionReciboData}) : super(key: key);
  @override
  _PrinterViewState createState() => _PrinterViewState();
}

class _PrinterViewState extends State<PrinterView> {
  //PrinterManager _printerManager = PrinterManager();
  bool _isloading = false;
  bool _haserror = false;
  String _mensaje = '';
  @override
  void initState() {
    super.initState();
    printRecibo();
  }

  void printRecibo() async {
    /*setState(() {
      _haserror = false;
      _isloading = true;
      _mensaje = 'Imprimiendo recibo ...';
    });
    try {
      var result = await _printerManager.printRecibo(_impresionReciboData);
      setState(() {
        _isloading = false;
        _mensaje = result;
      });
    } on PlatformException catch (ex) {
      setState(() {
        _isloading = false;
        _haserror = true;
        _mensaje = "${ex.code} \n ${ex.message}";
      });
    } on Exception catch (ex) {
      setState(() {
        _isloading = false;
        _haserror = true;
        _mensaje = ex.toString();
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DsWidgetSelector(
          condition: _haserror,
          onTrue: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _mensaje,
                  textAlign: TextAlign.center,
                ),
                FlatButton(
                  onPressed: () {
                    printRecibo();
                  },
                  child: Text(
                    "Reintentar",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                )
              ],
            ),
          ),
          onFalse: DsWidgetSelector(
            condition: _isloading,
            onTrue: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ],
              ),
            ),
            onFalse: Center(
              child: Text(
                _mensaje,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
