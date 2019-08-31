import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/services/EmpresaServices.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/EmpresaDao.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmpresaView extends StatefulWidget {
  final Empresa empresa;
  const EmpresaView({Key key, this.empresa}) : super(key: key);
  @override
  _EmpresaViewState createState() => _EmpresaViewState();
}

class _EmpresaViewState extends State<EmpresaView> {
  TextEditingController _nombrecontroller;
  TextEditingController _direccioncontroller;
  TextEditingController _rnccontroller;
  TextEditingController _telefonocontroller;
  TextEditingController _slogancontroller;
  bool _listadocompleto;
  bool _primeromora;
  bool _isloading = false;
  @override
  void initState() {
    super.initState();
    var _empresa = widget.empresa;
    _nombrecontroller = TextEditingController(text: _empresa.nombre);
    _direccioncontroller = TextEditingController(text: _empresa.direccion);
    _rnccontroller = TextEditingController(text: _empresa.rnc);
    _telefonocontroller = TextEditingController(text: _empresa.telefono);
    _slogancontroller = TextEditingController(text: _empresa.slogan);
    _listadocompleto = _empresa.listadocompleto;
    _primeromora=_empresa.primeromora;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Datos Empresa",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              setState(() {
                _isloading = true;
              });
              try {
                var wempresa = await Provider.of<EmpresaServices>(context)
                    .getInfoEmpresa();
                if (wempresa != null) {
                  _nombrecontroller.text = wempresa.nombre;
                  _direccioncontroller.text = wempresa.direccion;
                  _rnccontroller.text = wempresa.rnc;
                  _telefonocontroller.text = wempresa.telefono;
                  _slogancontroller.text = wempresa.slogan;
                  _listadocompleto = wempresa.listadocompleto;
                  _primeromora=wempresa.primeromora;
                }
                setState(() {
                  _isloading = false;
                });
              } catch (ex) {
                mensaje(context, ex.toString());
                setState(() {
                  _isloading = false;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              if (_nombrecontroller.text.isEmpty ||
                  _direccioncontroller.text.isEmpty ||
                  _telefonocontroller.text.isEmpty) {
                mensaje(context,
                    "No hay suficiente informacion para configurar la empresa!");
                return;
              }
              var _empresa = Empresa(
                  id: 1,
                  nombre: _nombrecontroller.text,
                  direccion: _direccioncontroller.text,
                  rnc: _rnccontroller.text,
                  telefono: _telefonocontroller.text,
                  slogan: _slogancontroller.text,
                  listadocompleto: _listadocompleto,
                  primeromora: _primeromora);
              var create =
                  await Provider.of<EmpresaDao>(context).create(_empresa);
              if (create <= 0) {
                mensaje(context, "No se pudo salvar la empresa!");
                return;
              }
              System().loadEmpresa(_empresa);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: DsWidgetSelector(
          condition: _isloading,
          onFalse: ListView(
            children: <Widget>[
              TextBold("Nombre Empresa"),
              TextField(
                controller: _nombrecontroller,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Nombre Empresa",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextBold("Direccion"),
              TextField(
                controller: _direccioncontroller,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Direccion",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextBold("Rnc"),
              TextField(
                controller: _rnccontroller,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Rnc",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextBold("Telefono"),
              TextField(
                controller: _telefonocontroller,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Telefono",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextBold("Slogan"),
              TextField(
                controller: _slogancontroller,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Slogan",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextBold("Listado Completo"),
              Row(
                children: <Widget>[
                  Switch(
                    value: _listadocompleto,
                    onChanged: (value) {},
                  )
                ],
              ),
              TextBold("Primero mora"),
              Row(
                children: <Widget>[
                  Switch(
                    value: _primeromora,
                    onChanged: (value) {},
                  )
                ],
              ),
            ],
          ),
          onTrue: Center(
            child: Loader(
              initialradius: 30,
              animationduration: 3,
              dotradius: 7,
            ),
          ),
        ),
      ),
    );
  }
}
