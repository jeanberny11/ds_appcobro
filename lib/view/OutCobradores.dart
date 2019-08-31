import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/api/models/CobradorM.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/RandomColor.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class OutCobradores extends StatelessWidget {
  final int _usuarioid;
  OutCobradores(
    this._usuarioid, {
    Key key,
  }) : super(key: key);
  final _randomColor = RandomColor();
  final _listkey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cobradores Asignados',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<List<Cobrador>>(
          stream:
              Provider.of<CobradorDao>(context).watchUserCobrador(_usuarioid),
          builder: (context, snp) {
            if (snp.hasError) {
              return Center(
                child: Text(
                  snp.error.toString(),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (snp.data == null) {
              return Center(
                child: Loader(
                  initialradius: 30,
                  animationduration: 3,
                  width: 60,
                  height: 60,
                  dotradius: 7,
                ),
              );
            } else {
              var list = snp.data;
              return DsWidgetSelector(
                condition: list.length > 0,
                onTrue: ListView.builder(
                    key: _listkey,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        key: ValueKey(index),
                        actionPane: SlidableBehindActionPane(),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: _randomColor.randomcolor,
                              child:
                                  TextBold(list[index].cobradorid.toString())),
                          title: Text(list[index].nombre),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(list[index].telefono),
                              Row(
                                children: <Widget>[
                                  TextBold('Defecto: '),
                                  list[index].defecto
                                      ? TextBold('SI')
                                      : TextBold('NO')
                                ],
                              )
                            ],
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Eliminar',
                            color: Colors.red,
                            closeOnTap: true,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            onTap: () {
                              Provider.of<CobradorDao>(context)
                                  .deleteCobrador(list[index].id);
                            },
                          )
                        ],
                      );
                    }),
                onFalse: Center(
                  child: Text(
                    'No hay Cobradores asignado a este usuario',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var cob = await Navigator.of(context)
              .pushNamed(PageRoutes.cobradorpickerroute) as CobradorM;
          if (cob != null) {
            var vcount =
                await Provider.of<CobradorDao>(context).getCobradorCountByUser(_usuarioid);
            var cobrador = Cobrador(
                id: null,
                cobradorid: cob.cobradorid,
                nombre: cob.nombre,
                telefono: cob.telefono,
                usuarioid: _usuarioid,
                defecto: vcount == 0,
                direccion: cob.direccion);
            Provider.of<CobradorDao>(context).create(cobrador);

            if (_usuarioid == System().currentUser.usuarioid) {
              var c = await Provider.of<CobradorDao>(context)
                  .getDefaultCobrador(_usuarioid);
              if (c != null) {
                System().loadCobrador(c);
              }
            }
          }
        },
      ),
    );
  }
}
