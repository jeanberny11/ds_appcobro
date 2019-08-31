import 'dart:convert';

import 'package:flutter/services.dart';

class BluetoothManager{
  static const bluetoothchannel = const MethodChannel('com.dreamapp.ds_appcobro/bluetooth');

  Future<List<BluetoothDevice>> getDeviceBoundedList()async{
    try{
      var jsonlist=await bluetoothchannel.invokeMethod('getDevicesList') as String;
    var list=jsonDecode(jsonlist);
    return list.map<BluetoothDevice>((device)=>BluetoothDevice(device['name'], device['address'])).toList();
    }on PlatformException catch(ex){
      throw Exception(ex.code+'\n'+ex.message);
    }
  }

  Future<Null> requestEnabledBluetooth()async{
    bluetoothchannel.invokeMethod("requestEnabledBluetooth");
  }

  Future<bool> isBluetoothEnabled(){
    return bluetoothchannel.invokeMethod("isBluetoothEnabled");
  }
}

class BluetoothDevice{
  String nombre;
  String address;
  BluetoothDevice(this.nombre,this.address);
}