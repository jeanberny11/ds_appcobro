import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var usuario = System().currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Perfil usuario',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        radius: 28.0,
                        backgroundColor: Theme.of(context).accentColor,
                        child: Text(
                          usuario.nombre.substring(0, 1),
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 232, 255, 100),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nombre: ',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Positioned(
                            right: 1.0,
                            left: 70.0,
                            child: Text(
                              usuario.nombre,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 232, 255, 100),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Direccion: ',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Positioned(
                            right: 1.0,
                            left: 80.0,
                            child: Text(
                              usuario.direccion,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 232, 255, 100),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Telefono: ',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Positioned(
                            right: 1.0,
                            left: 70.0,
                            child: Text(
                              usuario.telefono,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 232, 255, 100),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Contraseña: ',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Positioned(
                            right: 80.0,
                            child: GestureDetector(
                              child: Text(
                                '********',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 1.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(PageRoutes.passwordedit);
                              },
                              child: Text(
                                'Cambiar',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Cobrador>>(
                stream: Provider.of<CobradorDao>(context)
                    .watchUserCobrador(usuario.usuarioid),
                builder: (context, snp) {
                  if (snp.connectionState == ConnectionState.active) {
                    if (snp.hasError) {
                      return Center(
                        child: Text(
                          snp.error.toString(),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      var list = snp.data;
                      return ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          if (list[index].defecto) {
                            return ListTile(
                              leading: Text(list[index].cobradorid.toString()),
                              title: Text(list[index].nombre),
                              subtitle: Row(
                                children: <Widget>[
                                  TextBold('Defecto: '),
                                  list[index].defecto
                                      ? TextBold('SI')
                                      : TextBold('NO')
                                ],
                              ),
                            );
                          } else {
                            return Slidable(
                              actionPane: SlidableBehindActionPane(),
                              child: ListTile(
                                leading:
                                    Text(list[index].cobradorid.toString()),
                                title: Text(list[index].nombre),
                                subtitle: Row(
                                  children: <Widget>[
                                    TextBold('Defecto: '),
                                    list[index].defecto
                                        ? TextBold('SI')
                                        : TextBold('NO')
                                  ],
                                ),
                              ),
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: 'Defecto',
                                  closeOnTap: true,
                                  color: Colors.green,
                                  foregroundColor: Colors.white,
                                  icon: Icons.assignment_turned_in,
                                  onTap: () {
                                    Provider.of<CobradorDao>(context)
                                        .setDefaultCobrador(
                                            usuario.usuarioid,
                                            list[index]
                                                .copyWith(defecto: true));
                                  },
                                )
                              ],
                            );
                          }
                        },
                      );
                    }
                  } else {
                    return Center(
                      child: Loader(
                        initialradius: 25,
                        animationduration: 3,
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
