package com.dreamapp.ds_appcobro;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.os.Build;
import org.json.JSONObject;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PrinterManagerviejo {
    private final String recibodata;
    private final BluetoothAdapter bluetoothAdapter=BluetoothAdapter.getDefaultAdapter();
    private OutputStream outputStream;
    private SimpleDateFormat dateFormat=new SimpleDateFormat("dd-MM-yyyy");
    private SimpleDateFormat timeformat=new SimpleDateFormat("hh:mm a");
    private DecimalFormat numberformat=new DecimalFormat("###,###,##0.00");
    private final int MAXCHAR=32;
    private final int TO_CENTER=1;
    public PrinterManagerviejo(String recibodata) {
        this.recibodata = recibodata;
    }

    private void saltodelinea(int cnt) throws IOException {
        for (int i=0;i<cnt;i++){
            String salto="\n";
            outputStream.write(salto.getBytes());
        }
    }
    private String tocenter(String msg){
        int x=MAXCHAR-msg.length();
        if(!(x % 2==0)){
            x=x-1;
        }
        return String.format("%1$-"+(x/2)+"s","")+msg+String.format("%1$-"+(x/2)+"s","");
    }

    private String toright(String msg){
        int  x=MAXCHAR-msg.length();
        return String.format("%1$-"+x+"s","")+msg;
    }

    private String toleft(String msg){
        int  x=MAXCHAR-msg.length();
        return msg+String.format("%1$-"+x+"s","");
    }

    private void  print(String mesg,int posicion) throws IOException {
        final int TO_LEFT=2;
        final int TO_RIGTH=3;
        String linea=mesg.trim();
        StringBuilder text= new StringBuilder();
        if (linea.length()>MAXCHAR){
            while(linea.length()>0){
                if(linea.length()>MAXCHAR){
                    for (int i = MAXCHAR; i >= 0; i--) {
                        if(linea.charAt(i)==' '){
                            text.append(linea.substring(0, i)).append("\n");
                            linea=linea.substring(i+1);
                            break;
                        }
                    }
                }
                else{
                    text.append(linea);
                    linea="";
                }
            }
        }else{
            switch (posicion){
                case TO_CENTER:
                    text = new StringBuilder(tocenter(linea));
                    break;
                case TO_LEFT:
                    text = new StringBuilder(toleft(linea));
                    break;
                case TO_RIGTH:
                    text = new StringBuilder(toright(linea));
                    break;
                default:
                    text = new StringBuilder(linea);
            }
        }
        if (outputStream!=null){
            outputStream.write(text.toString().getBytes());
        }
    }

    public void imprimir() throws Exception {
        JSONObject jsondata=new JSONObject(recibodata);
        JSONObject empresa=jsondata.getJSONObject("empresa");
        JSONObject setting=jsondata.getJSONObject("setting");
        JSONObject cobrador=jsondata.getJSONObject("cobrador");
        JSONObject prestamo=jsondata.getJSONObject("prestamo");
        JSONObject recibo=jsondata.getJSONObject("recibo");
        int cuotasatrasadas=recibo.getInt("cuotasatrasadas");
        if(setting.getString("printeraddres").equals("")) {
            throw new Exception("El nombre de la impresora esta blanco. No se puede localizar la impresora");
        }
        if(bluetoothAdapter.isDiscovering()){
            bluetoothAdapter.cancelDiscovery();
        }
        BluetoothDevice bluetoothDevice= bluetoothAdapter.getRemoteDevice(setting.getString("printeraddres"));
        if(bluetoothDevice==null){
            throw new Exception("No se encontro el dispositivo "+setting.getString("printername"));
        }
        if(bluetoothDevice.getBondState() != BluetoothDevice.BOND_BONDED){
            throw new Exception("El dispositivo "+setting.getString("printername")+" no se encuentra vinculado por el momento!");
        }
        BluetoothSocket bluetoothSocket;

            if (Build.VERSION.SDK_INT >= 10) {
                Method m = bluetoothDevice.getClass().getMethod("createRfcommSocket", new Class[]{int.class});
                bluetoothSocket = (BluetoothSocket) m.invoke(bluetoothDevice,1);
            } else {
                bluetoothSocket = bluetoothDevice.createRfcommSocketToServiceRecord(bluetoothDevice.getUuids()[0].getUuid());
            }
            if (bluetoothSocket == null) {
                throw new Exception("no se pudo establecer la coneccion son el socket");
            }
            bluetoothSocket.connect();

            outputStream = bluetoothSocket.getOutputStream();
            int ncopias=setting.getInt("npopias");

        for (int i=0;i<ncopias;i++){
                //print header
                saltodelinea(1);
                print(empresa.getString("nombre"),TO_CENTER);
                saltodelinea(1);
                print(empresa.getString("direccion"),0);
                saltodelinea(1);
                print("RNC: "+empresa.getString("rnc"),0);
                saltodelinea(1);
                print("TEL.: "+empresa.getString("telefono"),0);
                saltodelinea(2);
                print("RECIBO NO.: "+recibo.getString("documento"),0);
                saltodelinea(1);
                print("FECHA.: "+dateFormat.format(new Date(recibo.getLong("fecha"))),0);
                saltodelinea(1);
                print("HORA.: "+timeformat.format(new Date()),0);
                saltodelinea(1);
                print("COB.: "+cobrador.getString("nombre"),0);
                saltodelinea(1);
                print("CUOTAS ATRASADAS.: "+cuotasatrasadas,0);
                saltodelinea(1);
                print("================================",0);
                saltodelinea(1);
                //--------fin header

                //--------print detail
                print(prestamo.getInt("idcliente")+" "+prestamo.getString("nombre"),0);
                saltodelinea(1);
                print(prestamo.getString("direccion"),0);
                saltodelinea(1);
                print("PRESTAMO NO.: "+prestamo.getString("prestamoid"),0);
                saltodelinea(1);
                print("================================",0);
                saltodelinea(1);
                if (recibo.getBoolean("efectivo")){
                    print("EFECTIVO.: "+numberformat.format(recibo.getDouble("monto")),0);
                }else{
                    print("CHEQUE.: "+numberformat.format(recibo.getDouble("monto")),0);
                }
                saltodelinea(1);
                print("MORA.: "+numberformat.format(recibo.getDouble("mora")),0);
                saltodelinea(1);
                print("TOTAL.: "+numberformat.format(recibo.getDouble("monto")),0);
                saltodelinea(1);
                print("================================",0);
                //---------fin detail

                //--------print footer
                saltodelinea(1);
                print("CONCEPTO.: "+recibo.getString("concepto"),0);
                saltodelinea(2);
                print("----------------------------",TO_CENTER);
                saltodelinea(1);
                print("FIRMA",TO_CENTER);
                saltodelinea(2);
                print((i==0?"ORIGINAL":"COPIA"),TO_CENTER);
                saltodelinea(4);

                //---------------------fin---------
            if (ncopias>1 && i<ncopias-1){
                Thread.sleep((setting.getInt("delaycopias")*1000));
            }
            }

            outputStream.flush();
        bluetoothSocket.close();

        }


    }

