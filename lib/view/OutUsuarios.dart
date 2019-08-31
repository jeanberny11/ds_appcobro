import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/UsuarioDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/RandomColor.dart';
import 'package:ds_appcobro/utils/StringResources.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutUsuarios extends StatelessWidget {
  final _randomColor = RandomColor();
  final _customkey = UniqueKey();
  final _listkey = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<Usuario>>(
          stream: Provider.of<UsuarioDao>(context).watchUsuario(),
          builder: (context, snp) {
            if (snp.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      snp.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      child: Text(
                        'Retornar',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              );
            } else if (snp.data == null) {
              return Center(
                child: Loader(
                  initialradius: 30,
                  animationduration: 3,
                  dotradius: 7,
                  width: 60,
                  height: 60,
                ),
              );
            } else {
              var list = snp.data;
              return CustomScrollView(
                key: _customkey,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme:
                        IconThemeData(color: Theme.of(context).primaryColor),
                    floating: true,
                    pinned: true,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        StringResources.of(context).usuariotitle,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SliverList(
                    key: _listkey,
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ListTile(
                        leading: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed(PageRoutes.inusuarioroute,arguments: list[index]);
                          },
                          child: Hero(
                            tag: list[index].usuario,
                            child: CircleAvatar(
                              backgroundColor: _randomColor.randomcolor,
                              child: Text(
                                list[index]
                                    .nombre
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        title: Text(list[index].nombre),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(list[index].direccion),
                            Text(list[index].telefono),
                          ],
                        ),
                      );
                    }, childCount: list.length),
                  )
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(PageRoutes.inusuarioroute,
              arguments: Usuario(
                  usuarioid: null,
                  usuario: '',
                  clave: '',
                  nombre: '',
                  direccion: '',
                  telefono: '',
                  level: 0,
                  activo: false));
        },
      ),
    );
  }
}
