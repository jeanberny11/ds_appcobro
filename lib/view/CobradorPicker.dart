import 'package:ds_appcobro/api/models/CobradorM.dart';
import 'package:ds_appcobro/api/services/CobradoresServices.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/TextBold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CobradorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Elija un Vendedor',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<CobradorM>>(
          future: Provider.of<CobradoresServices>(context).getCobradores(),
          builder: (context, snp) {
            if (snp.connectionState == ConnectionState.done) {
              if (snp.hasError) {
                return Center(
                  child: Text(
                    snp.error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snp.data.length,                  
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          child:
                              TextBold(snp.data[index].cobradorid.toString())),
                      title: Text(snp.data[index].nombre),
                      subtitle: Text(snp.data[index].telefono),
                      onTap: ()=>Navigator.of(context).pop(snp.data[index]),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: Loader(
                  initialradius: 30,
                  animationduration: 3,
                  width: 60,
                  height: 60,
                  dotradius: 7,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
