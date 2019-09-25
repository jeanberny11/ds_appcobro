package com.dreamapp.ds_appcobro;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.os.Build;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;

public class PrinterManager {
    private final BluetoothAdapter bluetoothAdapter= BluetoothAdapter.getDefaultAdapter();
    private BluetoothDevice bluetoothDevice;
    private BluetoothSocket bluetoothSocket;
    private OutputStream outputStream;

    public void loadPrinter(String printeraddress)throws Exception {
        if(bluetoothAdapter==null){
            throw new Exception("No se encontro preiferico Bluetooth en el dispositivo!");
        }
        if (!bluetoothAdapter.isEnabled()){
            throw new Exception("El dispositivo bluetooh esta desactivado!");
        }
        if (bluetoothAdapter.isDiscovering()){
            bluetoothAdapter.cancelDiscovery();
        }

        bluetoothDevice=bluetoothAdapter.getRemoteDevice(printeraddress);
        if(bluetoothDevice.getBondState()!= BluetoothDevice.BOND_BONDED){
            throw new Exception("El dispositivo seleccionado no esta vinculado");
        }
    }

    public void openConnection() throws Exception {
        if (Build.VERSION.SDK_INT >= 10) {
            Method m = bluetoothDevice.getClass().getMethod("createRfcommSocket", int.class);
            bluetoothSocket = (BluetoothSocket) m.invoke(bluetoothDevice,1);
        } else {
            bluetoothSocket = bluetoothDevice.createRfcommSocketToServiceRecord(bluetoothDevice.getUuids()[0].getUuid());
        }
        if (bluetoothSocket==null){
            throw new Exception("No se ha podido establecer la conexion con el dispositivo!");
        }
        bluetoothSocket.connect();
        this.outputStream=bluetoothSocket.getOutputStream();
    }

    public void closeConnection() throws IOException {
        if(outputStream!=null){
            this.outputStream.flush();
            this.outputStream.close();
        }
        if(bluetoothSocket!=null){
            bluetoothSocket.close();
        }
    }

    public boolean isBluetoothEnabled(){
        return bluetoothAdapter.isEnabled();
    }

    private String ajustartexto(String text, PrinterTextStyle style){
        StringBuilder result=new StringBuilder();
        switch (style){
            case smalltext:{//-----small text size
                if (text.length()<=PrinterCommands.MAXSMALLCHAR){
                    result.append(text);
                }else{
                    String ln=text;
                    while (ln.length()>0){
                        if (ln.length()>PrinterCommands.MAXSMALLCHAR){
                            boolean blk=false;
                            for(int i=PrinterCommands.MAXSMALLCHAR;i>0;i--){
                                if (ln.charAt(i)==' '){
                                    blk=true;
                                    result.append(ln, 0, i).append("\n");
                                    ln=ln.substring(i+1);
                                    break;
                                }
                            }
                            if (!blk){
                                result.append(ln, 0, PrinterCommands.MAXSMALLCHAR);
                                ln=ln.substring(PrinterCommands.MAXSMALLCHAR+1);
                            }
                        }else{
                            result.append(ln);
                            ln="";
                        }
                    }
                }
                break;
            }
            case normaltext:{//-----Normal text size
                if (text.length()<=PrinterCommands.MAXNORMALCHAR){
                    result.append(text);
                }else{
                    String ln=text;
                    while (ln.length()>0){
                        if (ln.length()>PrinterCommands.MAXNORMALCHAR){
                            boolean blk=false;
                            for(int i=PrinterCommands.MAXNORMALCHAR;i>0;i--){
                                if (ln.charAt(i)==' '){
                                    blk=true;
                                    result.append(ln, 0, i).append("\n");
                                    ln=ln.substring(i+1);
                                    break;
                                }
                            }
                            if (!blk){
                                result.append(ln, 0, PrinterCommands.MAXNORMALCHAR);
                                ln=ln.substring(PrinterCommands.MAXNORMALCHAR+1);
                            }
                        }else{
                            result.append(ln);
                            ln="";
                        }
                    }
                }
                break;
            }
            case bigtext:{//-----Normal text size
                if (text.length()<=PrinterCommands.MAXBIGCHAR){
                    result.append(text);
                }else{
                    String ln=text;
                    while (ln.length()>0){
                        if (ln.length()>PrinterCommands.MAXBIGCHAR){
                            boolean blk=false;
                            for(int i=PrinterCommands.MAXBIGCHAR;i>0;i--){
                                if (ln.charAt(i)==' '){
                                    blk=true;
                                    result.append(ln, 0, i).append("\n");
                                    ln=ln.substring(i+1);
                                    break;
                                }
                            }
                            if (!blk){
                                result.append(ln, 0, PrinterCommands.MAXBIGCHAR);
                                ln=ln.substring(PrinterCommands.MAXBIGCHAR+1);
                            }
                        }else{
                            result.append(ln);
                            ln="";
                        }
                    }
                }
                break;
            }
        }

        return  result.toString();
    }

    public void print(String text, PrinterAlignment alignment, PrinterTextStyle style, boolean bold) throws IOException {
        String tiprint=ajustartexto(text,style);
        final byte[] cc = {0x1B, 0x21, 0x03};  // 0- small size text
        final byte[] nn = new byte[]{0x1B, 0x21, 0x00}; //1-mormal size text
        final byte[] bb2 = new byte[]{0x1B, 0x21, 0x20}; // 2- BIG size text
        switch (alignment){
            case left:{
                //left align
                this.outputStream.write(PrinterCommands.ESC_ALIGN_LEFT);
                break;
            }
            case center:{
                //center align
                this.outputStream.write(PrinterCommands.ESC_ALIGN_CENTER);
                break;
            }
            case right:{
                //right align
                this.outputStream.write(PrinterCommands.ESC_ALIGN_RIGHT);
                break;
            }
        }
        switch (style){
            case smalltext: this.outputStream.write(cc);
                break;
            case normaltext: this.outputStream.write(nn);
                break;
            case bigtext: this.outputStream.write(bb2);
                break;
        }
        if (bold){
            byte[] bd = new byte[]{0x1B, 0x21, 0x08};  // 2- only bold text
            this.outputStream.write(bd);
        }
        this.outputStream.write(tiprint.getBytes());
        this.outputStream.write(PrinterCommands.LF);
    }

    public void feed() throws IOException {
        this.outputStream.write(PrinterCommands.FEED_LINE);
    }

}

