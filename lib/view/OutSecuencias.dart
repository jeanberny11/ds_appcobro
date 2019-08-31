import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/SecuenciasDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/RandomColor.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OutSecuencias extends StatelessWidget {
  final _randomcolor=RandomColor();
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
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<List<Secuencia>>(
          stream: Provider.of<SecuenciasDao>(context).watchSecuencias(),
          builder: (context, snp) {
            if (snp.connectionState == ConnectionState.active) {
              if (snp.hasError) {
                return Center(
                  child: Text(snp.error.toString()),
                );
              } else {
                var list = snp.data;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _randomcolor.randomcolor,
                        child: Text(list[index].tipodoc),
                      ),
                      title: Text(list[index].descripcion),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                            "Secuencia: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(list[index].secuencia.toString())
                        ],
                      ),
                      onTap: (){
                        Navigator.of(context).pushNamed(PageRoutes.insecuencia,arguments: list[index]);
                      },
                    );
                  },
                );
              }
            } else {
              return Center(
                child: Loader(
                  initialradius: 30,
                  animationduration: 3,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
