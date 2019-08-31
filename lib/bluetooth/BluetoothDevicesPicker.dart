import 'package:ds_appcobro/bluetooth/BluetoothManager.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BluetoothDevicesPicker extends StatefulWidget {
  @override
  _BluetoothDevicesPickerState createState() => _BluetoothDevicesPickerState();
}

class _BluetoothDevicesPickerState extends State<BluetoothDevicesPicker> {
  @override
  Widget build(BuildContext context) {
    var btmanagerprovider = Provider.of<BluetoothManager>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Seleccione un dispositivo",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<BluetoothDevice>>(
          future: btmanagerprovider.getDeviceBoundedList(),
          builder: (context, snp) {
            if (snp.connectionState == ConnectionState.done) {
              if (snp.hasError) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        snp.error.toString(),
                        textAlign: TextAlign.center,
                      ),
                      FutureBuilder<bool>(
                        future: btmanagerprovider.isBluetoothEnabled(),
                        builder: (context, snp2) {
                          if (snp2.connectionState == ConnectionState.done) {
                            if (snp2.hasData && !snp2.data) {
                              return FlatButton(
                                child: Text("Activar Bluetooth"),
                                onPressed: () {
                                  btmanagerprovider.requestEnabledBluetooth();
                                },
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Loader(
                              initialradius: 15,
                              animationduration: 3,
                            );
                          }
                        },
                      )
                    ],
                  ),
                );
              } else {
                var list = snp.data;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.bluetooth,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(list[index].nombre),
                      subtitle: Text(list[index].address),
                      onTap: () {
                        Navigator.of(context).pop(list[index]);
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
