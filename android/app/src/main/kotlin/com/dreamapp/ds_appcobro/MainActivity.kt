package com.dreamapp.ds_appcobro

import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.jetbrains.anko.doAsync
import org.jetbrains.anko.uiThread
import org.json.JSONArray
import org.json.JSONObject
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.*


class MainActivity: FlutterActivity() {
  private val BLUETOOTHCHANNEL="com.dreamapp.ds_appcobro/bluetooth"
  private val PRINTERCHANNEL="com.dreamapp.ds_appcobro/printer"
  private val REQUEST_ENABLE_BT=1111
  private val dateFormat = SimpleDateFormat("dd-MM-yyyy", Locale.US)
  private val timeformat = SimpleDateFormat("hh:mm a", Locale.US)
  private val numberformat = DecimalFormat("###,###,##0.00")
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
        val recibodata=call.arguments.toString()
        val jsondata = JSONObject(recibodata)
        val setting = jsondata.getJSONObject("setting")
        val printerManager=PrinterManager()
        doAsync {
          try{
            printerManager.loadPrinter(setting.getString("printeraddres"))
            printerManager.openConnection()
            val ncopias = setting.getInt("npopias")
            for (i in 0 until ncopias) {
              imprimirrecibo(jsondata,printerManager,i==0)
              if (ncopias > 1 && i < ncopias - 1) {
                Thread.sleep((setting.getInt("delaycopias") * 1000).toLong())
              }
            }
            Thread.sleep(5000)
            printerManager.closeConnection()
            uiThread {
              result.success("Recibo impreso con exito!")
            }
          }catch (ex:Exception){
            printerManager.closeConnection()
            uiThread {
              result.error("PRINTERERROR",ex.message,null)
            }
          }
        }

        /*if(!isBluetoothEnabled()){
          result.error("BLUETOOTHOFF","EL adaptador bluetooth esta apagado o el dispositivo no tiene adaptador bluetooth",null)
        }else if(call.arguments==null){
          result.error("PRINTDATAERROR","No hay datos para imprimir",null)
        }else{

          val printerManager= PrinterManagerviejo(recibodata)
          try{
            printerManager.imprimir()
          }catch(ex:Exception){
            result.error("PRINTERERROR",ex.message,null)
          }
          result.success("Recibo impreso con exito!")
        }*/
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

  private fun imprimirrecibo(jsondata:JSONObject,printerManager: PrinterManager,original:Boolean){
    val empresa = jsondata.getJSONObject("empresa")
    val cobrador = jsondata.getJSONObject("cobrador")
    val prestamo = jsondata.getJSONObject("prestamo")
    val recibo = jsondata.getJSONObject("recibo")
    val cuotasatrasadas = recibo.getInt("cuotasatrasadas")
    printerManager.print(empresa.getString("nombre"),PrinterAlignment.center,PrinterTextStyle.normaltext,true)
    printerManager.print(empresa.getString("direccion"),PrinterAlignment.center,PrinterTextStyle.smalltext,false)
    printerManager.feed()
    printerManager.print("Rnc: " + empresa.getString("rnc"),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("Tel.: " + empresa.getString("telefono"),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.feed()
    printerManager.print("Recibo No.: " + recibo.getString("documento"),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("Fecha.: " + dateFormat.format(Date(recibo.getLong("fecha"))),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("Hora.: " + timeformat.format(Date()),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("Cob.: " + cobrador.getString("nombre"),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("Cuotas atrasadas.: $cuotasatrasadas",PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("==========================================",PrinterAlignment.center,PrinterTextStyle.smalltext,false)
    printerManager.print("Cliente:"+prestamo.getInt("idcliente"),PrinterAlignment.left,PrinterTextStyle.normaltext,true)
    printerManager.print(prestamo.getString("nombre"),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print(prestamo.getString("direccion"),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("Prestamo No.: " + prestamo.getString("prestamoid"),PrinterAlignment.left,PrinterTextStyle.normaltext,true)
    printerManager.print("==========================================",PrinterAlignment.center,PrinterTextStyle.smalltext,false)
    if (recibo.getBoolean("efectivo")) {
      printerManager.print("Efectivo.: " + numberformat.format(recibo.getDouble("monto")),PrinterAlignment.left,PrinterTextStyle.normaltext,true)
    } else {
      printerManager.print("Cheque.: " + numberformat.format(recibo.getDouble("monto")),PrinterAlignment.left,PrinterTextStyle.normaltext,true)
    }
    printerManager.print("MORA.: " + numberformat.format(recibo.getDouble("mora")),PrinterAlignment.left,PrinterTextStyle.normaltext,false)
    printerManager.print("Monto cobrado.: " + numberformat.format(recibo.getDouble("monto")),PrinterAlignment.left,PrinterTextStyle.normaltext,true)
    printerManager.print("==========================================",PrinterAlignment.center,PrinterTextStyle.smalltext,false)
    printerManager.print("Concepto: " + recibo.getString("concepto"),PrinterAlignment.left,PrinterTextStyle.normaltext,true)
    printerManager.feed()
    printerManager.print("---------------------",PrinterAlignment.center,PrinterTextStyle.smalltext,false)
    printerManager.print("Firma",PrinterAlignment.center,PrinterTextStyle.smalltext,true)
    printerManager.feed()
    if (original){
      printerManager.print("ORIGINAL",PrinterAlignment.center,PrinterTextStyle.smalltext,true)
    }else{
      printerManager.print("COPIA",PrinterAlignment.center,PrinterTextStyle.smalltext,true)
    }
    printerManager.feed()
    printerManager.feed()
  }
}
