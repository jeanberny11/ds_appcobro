import 'package:ds_appcobro/managers/CargarDatosManager.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CargarDatosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Cargar Datos",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer<CargarDatosManager>(
          builder: (context, manager, _) {
            switch (manager.currentstate) {
              case CargaState.initstate:
                {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("Pulse el boton para empezar la descarga"),
                        IconButton(
                          icon: Icon(
                            Icons.file_download,
                            size: 40,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            manager.downloadData();
                          },
                        )
                      ],
                    ),
                  );
                }
              case CargaState.loadingstate:
                {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Loader(
                          initialradius: 30,
                          animationduration: 3,
                          dotradius: 8,
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(height: 15,),
                        Text(
                          manager.mensaje,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }
              case CargaState.errorstate:
                {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          manager.error.toString(),
                          textAlign: TextAlign.center,
                        ),
                        FlatButton(
                          child: Text("Reintentar"),
                          onPressed: () {
                            manager.reset();
                          },
                        )
                      ],
                    ),
                  );
                }
              case CargaState.donestate:
                {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          manager.mensaje,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        FlatButton(
                          child: Text("Aceptar"),
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
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
