import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/RandomColor.dart';
import 'package:ds_appcobro/widgets/DsWidgetSelector.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutRecibosView extends StatelessWidget {
  final _randomColor = RandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<Prestamo>>(
          future: Provider.of<PrestamosDao>(context).getPrestamosNoCobrados(),
          builder: (context, snp) {
            if (snp.connectionState == ConnectionState.done) {
              var list = snp.data;
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    iconTheme:
                        IconThemeData(color: Theme.of(context).primaryColor),
                    backgroundColor: Colors.transparent,
                    floating: true,
                    title: Text('Prestamos disp.',
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          var list=await Provider.of<PrestamosDao>(context).getPrestamosNoCobrados();
                          var prestamo=await showSearch<Prestamo>(context: context,delegate: PrestamoSearch(list));
                          if(prestamo!=null){
                            Navigator.of(context).pushReplacementNamed(PageRoutes.cobro,arguments: prestamo);
                          }
                        },
                      )
                    ],
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(5.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _randomColor.randomcolor,
                            child: Text(list[index]
                                .nombre
                                .substring(0, 1)
                                .toUpperCase()),
                          ),
                          title: Text(list[index].prestamoid),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                list[index].nombre,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(list[index].direccion),
                              Row(
                                children: <Widget>[
                                  Text("Monto atrasado: "),
                                  Text(list[index].montovencido.toString())
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                PageRoutes.cobro,
                                arguments: list[index]);
                          },
                        );
                      }, childCount: list.length),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Loader(
                  animationduration: 3,
                  initialradius: 30,
                  dotradius: 8,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class PrestamoSearch extends SearchDelegate<Prestamo> {
  final List<Prestamo> _data;

  PrestamoSearch(this._data);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var result = _data
        .where((p) =>
            p.prestamoid.toLowerCase().contains(query.toLowerCase()) ||
            p.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return DsWidgetSelector(
      condition: result.isNotEmpty,
      onTrue: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              close(context, result[index]);
            },
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Text(result[index].nombre.substring(0, 1).toUpperCase()),
            ),
            title: Text(result[index].prestamoid),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  result[index].nombre,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(result[index].direccion),
                Row(
                  children: <Widget>[
                    Text("Monto atrasado: "),
                    Text(result[index].montovencido.toString())
                  ],
                )
              ],
            ),
          );
        },
      ),
      onFalse: Center(
        child: Text(
          "No hay prestamos con estos parametros!",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }
    var list = _data
        .where((prestamo) =>
            prestamo.prestamoid.toLowerCase().contains(query.toLowerCase()) ||
            prestamo.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(list[index].prestamoid),
          subtitle: Text(list[index].nombre),
          onTap: () {
            close(context, list[index]);
          },
        );
      },
    );
  }
}
