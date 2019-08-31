import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/SecuenciasDao.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InSecuencias extends StatefulWidget {
  final Secuencia secuencia;
  const InSecuencias({Key key, this.secuencia}) : super(key: key);
  @override
  _InSecuenciasState createState() => _InSecuenciasState();

}

class _InSecuenciasState extends State<InSecuencias> {
  Secuencia _secuencia;
  TextEditingController _secuenciacontroller;
  TextEditingController _intervaloController;
  FocusNode _secuenciafocus;
  FocusNode _intervalofocus;

  @override
  void initState() { 
    super.initState();
    _secuencia=widget.secuencia;
    _secuenciacontroller=TextEditingController(text: _secuencia.secuencia.toString());
    _intervaloController=TextEditingController(text: _secuencia.intervalo.toString());
    _secuenciafocus=FocusNode();
    _intervalofocus=FocusNode();
  }

  @override
  void dispose() {
    _secuenciafocus.dispose();
    _intervalofocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Secuencias",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: ()async{
              var sec=_secuencia.copyWith(secuencia: int.parse(_secuenciacontroller.text),intervalo: int.parse(_intervaloController.text));
              var g=await Provider.of<SecuenciasDao>(context).create(sec);
              if(g<=0){
                mensaje(context, 'No se pudo guardar la secuencia');
              }else{
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                TextBold("Id: "),
                Text(_secuencia.id.toString())
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                TextBold("Tipo Documento: "),
                Text(_secuencia.tipodoc.toString())
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                TextBold("Descripcion: "),
                Text(_secuencia.descripcion.toString())
              ],
            ),
            SizedBox(height: 15,),
            TextBold("Secuencia"),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              controller: _secuenciacontroller,
              focusNode: _secuenciafocus,
              onSubmitted: (value){
                _secuenciafocus.unfocus();
                FocusScope.of(context)
                                  .requestFocus(_intervalofocus);
              },
              decoration: InputDecoration(
                        hintText: "Secuencia",
                      ),
            ),
            SizedBox(
              height: 10,
            ),
            TextBold("Intervalo"),
            TextField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: _intervaloController,
              focusNode: _intervalofocus,
              onSubmitted: (value){
                _intervalofocus.unfocus();                
              },
              decoration: InputDecoration(
                        hintText: "Intervalo",
                      ),
            )
          ],
        ),
      ),
    );
  }
}