package com.dreamapp.ds_appcobro

import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONArray
import org.json.JSONObject

class MainActivity: FlutterActivity() {
  private val BLUETOOTHCHANNEL="com.dreamapp.ds_appcobro/bluetooth"
  private val PRINTERCHANNEL="com.dreamapp.ds_appcobro/printer"
  private val REQUEST_ENABLE_BT=1111
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, BLUETOOTHCHANNEL).setMethodCallHandler { call, result ->
      if(call.method=="getDevicesList"){
        if(isBluetoothEnabled()){
          try {
              val devicelist=getDevicesList()
              result.success(devicelist)
          }catch (ex:Exception){
            result.error("BLUETOOTHERROR",ex.message,ex)
          }
        }else{
          result.error("BLUETOOTHOFF","EL adaptador bluetooth esta apagado o el dispositivo no tiene adaptador bluetooth",null)
        }
      }else if(call.method=="requestEnabledBluetooth"){
        requestEnabledBluetooth()
      }else if(call.method=="isBluetoothEnabled"){
        result.success(isBluetoothEnabled())
      }else{
        result.notImplemented()
      }
    }

    MethodChannel(flutterView,PRINTERCHANNEL).setMethodCallHandler{ call, result ->
      if(call.method=="printRecibo"){
        if(!isBluetoothEnabled()){
          result.error("BLUETOOTHOFF","EL adaptador bluetooth esta apagado o el dispositivo no tiene adaptador bluetooth",null)
        }else if(call.arguments==null){
          result.error("PRINTDATAERROR","No hay datos para imprimir",null)
        }else{
          val recibodata=call.arguments.toString()
          val printerManager=PrinterManager(recibodata)
          try{
            printerManager.imprimir()
          }catch(ex:Exception){
            result.error("PRINTERERROR",ex.message,null)
          }
          result.success("Recibo impreso con exito!")
        }
      }else{
        result.notImplemented()
      }
    }
  }

  private fun getDevicesList():String{
    val bluetoothAdapter=BluetoothAdapter.getDefaultAdapter()
    if(bluetoothAdapter.isDiscovering){
      bluetoothAdapter.cancelDiscovery()
    }
    val deviceslist= JSONArray()
    val bondeddevices=bluetoothAdapter.bondedDevices
    for (devices in bondeddevices){
      val device= JSONObject()
      device.put("name",devices.name)
      device.put("address",devices.address)
      deviceslist.put(device)
    }
    return deviceslist.toString()
  }

  private fun requestEnabledBluetooth(){
    val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
    startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)
  }

  private fun isBluetoothEnabled():Boolean{
    val bluetoothAdapter=BluetoothAdapter.getDefaultAdapter()
    return bluetoothAdapter!=null && bluetoothAdapter.isEnabled
  }
}
