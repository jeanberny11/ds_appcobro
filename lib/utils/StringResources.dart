import 'package:flutter/material.dart';

class StringResources {
  StringResources(this.locale);
  final Locale locale;
  static StringResources of(BuildContext context) {
    return Localizations.of<StringResources>(context, StringResources);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'DREAM APP',
      'username': 'User Name',
      'password': 'Password',
      'login': 'ENTRAR',
      'exit': 'SALIR',
      'uservalidate': 'El usuario no puede estar en blanco',
      'passwordvalidate': 'La contraseña no puede estar en blanco',
      'messagetitle': 'ALERT',
      'confirmmessaetitle': 'CONFIRM',
      'okbutton': 'ACEPTAR',
      'cancelbutton': 'CANCELAR',
      'exitmessage': 'Desea salir de la aplicacion?',
      'settingtitle': 'SETTINGS',
      'remoteurl': 'Remote url',
      'localurl': 'Local url',
      'empresa': 'Company',
      'hempresa': 'Enter Company Name',
      'dirrecion': 'Address',
      'hdireccion': 'Enter the Address',
      'rnc': 'Rnc',
      'hrnc': 'Digite el Rnc',
      'telefono': 'Phone Number',
      'htelefono': 'Enter Phone Number',
      'autosync': 'Auto Sync',
      'syncdate': 'Fecha Ult. Sincronizacion',
      'systemdate': 'System Date',
      'ncopias': 'Number Of Copy',
      'hncopias': 'Cantidad de copias por impresion',
      'delaycopias': 'Copy Delay',
      'printername': 'Printer Name',
      'printeraddress': 'Printer Mac Address',
      'removeprest': 'Quitar prestamos despues de cobrar',
      'primeromora': 'Cobrar todas las moras primero',
      'emptyvalidate': 'This field cannot be empty.',
      'enablingbluetooth': 'Enabling bluetooth device',
      'waitresult': 'Waiting Result',
      'nobluetoothdevicefound': 'No Bluetooth Device Found',
      'btdevicepickerdialogtitle': 'Pick a device',
      'btrequestcanceled':'The request has canceled by user!',
      'btpickertitle':'Select a device',     
      'dobleconexion':'Double conexion', 
      'usuariotitle':'Users',
      'confirmpassword':'Conform Password',
      'nombre':'Name',
      'userlevel':'User level',
      'activo':'Active',
      'superuser':'Super User',
      'cobradorpickertitle':'Elija un cobrador',
      'appname':'DREAM SOFT',
      'appslogan':'You dream it, we do it',
      'retry':'Retry',
      'importsetting':'Import Setting',
      'online':'Online',
      'internetconnection':'Internet connection',
      'vendedores':'Sellers',
      'vendedorpicker':'Pick a seller',
      'home':'HOME',
      'nombreusuario':'User name',
      'usuariolevel':'User level',
      'superusuario':'Super user',      
    },
    'es': {
      'title': 'DREAM APP',
      'username': 'Usuario',
      'password': 'Contraseña',
      'login': 'ENTRAR',
      'exit': 'SALIR',
      'uservalidate': 'El usuario no puede estar en blanco',
      'passwordvalidate': 'La contraseña no puede estar en blanco',
      'messagetitle': 'AVISO',
      'confirmmessaetitle': 'CONFIRMAR',
      'okbutton': 'ACEPTAR',
      'cancelbutton': 'CANCELAR',
      'exitmessage': 'Desea salir de la aplicacion?',
      'settingtitle': 'CONFIGURACIONES',
      'remoteurl': 'Remote url',
      'localurl': 'Local url',
      'empresa': 'Empresa',
      'hempresa': 'Digite el nombre de la empresa',
      'dirrecion': 'Direccion',
      'hdireccion': 'Digite la direccion',
      'rnc': 'Rnc',
      'hrnc': 'Digite el Rnc',
      'telefono': 'Telefono',
      'htelefono': 'Digite el telefono',
      'autosync': 'Sincronizar Automatico',
      'syncdate': 'Fecha Ult. Sincronizacion',
      'systemdate': 'Fecha del Sistema',
      'ncopias': 'Numero de Copias',
      'hncopias': 'Cantidad de copias por impresion',
      'delaycopias': 'Delay entre copias',
      'printername': 'Nombre Impresora',
      'printeraddress': 'Mac Address Impresora',
      'removeprest': 'Quitar prestamos despues de cobrar',
      'primeromora': 'Cobrar todas las moras primero',
      'emptyvalidate': 'Este campo no puede estar vacio.',
      'enablingbluetooth': 'Habilitando el dispositivo bluetooth',
      'waitresult': 'Esperando respuesta',
      'nobluetoothdevicefound':
          'No Se Encontro Dispositivos bluetooth vinculado',
      'btdevicepickerdialogtitle': 'Elija un dispositivo',
      'btrequestcanceled':'La solicitud de acceso al bluetooht ha sido cancelada!',
      'btpickertitle':'Elija un dispositivo',
      'dobleconexion':'Doble conexion',
      'usuariotitle':'Usuarios',
      'confirmpassword':'Confirmar Contraseña',
      'nombre':'Nombre',
      'userlevel':'Nivel de usuario',
      'activo':'Activo',
      'superuser':'Super Usuario',
      'cobradorpickertitle':'Elija un cobrador',
      'appname':'DREAM SOFT',
      'appslogan':'Tu lo sueñas, nosotros lo hacemos',
      'retry':'Reintentar',
      'importsetting':'Importar Configuracion',
      'online':'En linea',
      'internetconnection':'Conexion internet',
      'vendedores':'Vendedores',
      'vendedorpicker':'Selecciona un vendedor',
      'home':'Inicio',
      'nombreusuario':'Nombre usuario',
      'usuariolevel':'Nivel de usuario',
      'superusuario':'Super usuario',
    }
  };
  String get superusuario=>_localizedValues[locale.languageCode]['superusuario'];

  String get usuariolevel=>_localizedValues[locale.languageCode]['usuariolevel'];

  String get nombreusuario=>_localizedValues[locale.languageCode]['nombreusuario'];

  String get home=>_localizedValues[locale.languageCode]['home'];

  String get vendedorpicker=>_localizedValues[locale.languageCode]['vendedorpicker'];

  String get vendedores=>_localizedValues[locale.languageCode]['vendedores'];

  String get internetconnection=>_localizedValues[locale.languageCode]['internetconnection'];

  String get online=>_localizedValues[locale.languageCode]['online'];

  String get importsetting=>_localizedValues[locale.languageCode]['importsetting'];

  String get retry=>_localizedValues[locale.languageCode]['retry'];

  String get appslogan=>_localizedValues[locale.languageCode]['appslogan'];

  String get appname=>_localizedValues[locale.languageCode]['appname'];

  String get cobradorpickertitle {
    return _localizedValues[locale.languageCode]['cobradorpickertitle'];
  }

  String get superuser {
    return _localizedValues[locale.languageCode]['superuser'];
  }

  String get activo {
    return _localizedValues[locale.languageCode]['activo'];
  }

  String get userlevel {
    return _localizedValues[locale.languageCode]['userlevel'];
  }

  String get nombre {
    return _localizedValues[locale.languageCode]['nombre'];
  }

  String get confirmpassword {
    return _localizedValues[locale.languageCode]['confirmpassword'];
  }

  String get usuariotitle {
    return _localizedValues[locale.languageCode]['usuariotitle'];
  }

  String get dobleconexion {
    return _localizedValues[locale.languageCode]['dobleconexion'];
  }

  String get btpickertitle {
    return _localizedValues[locale.languageCode]['btpickertitle'];
  }

  String get btrequestcanceled {
    return _localizedValues[locale.languageCode]['btrequestcanceled'];
  }

  String get btdevicepickerdialogtitle {
    return _localizedValues[locale.languageCode]['btdevicepickerdialogtitle'];
  }

  String get nobluetoothdevicefound {
    return _localizedValues[locale.languageCode]['nobluetoothdevicefound'];
  }

  String get enablingbluetooth {
    return _localizedValues[locale.languageCode]['enablingbluetooth'];
  }

  String get waitresult {
    return _localizedValues[locale.languageCode]['waitresult'];
  }

  String get telefono {
    return _localizedValues[locale.languageCode]['telefono'];
  }

  String get printeraddress {
    return _localizedValues[locale.languageCode]['printeraddress'];
  }

  String get emptyvalidate {
    return _localizedValues[locale.languageCode]['emptyvalidate'];
  }

  String get remoteurl {
    return _localizedValues[locale.languageCode]['remoteurl'];
  }

  String get rnc {
    return _localizedValues[locale.languageCode]['rnc'];
  }

  String get hdireccion {
    return _localizedValues[locale.languageCode]['hdireccion'];
  }

  String get dirrecion {
    return _localizedValues[locale.languageCode]['dirrecion'];
  }

  String get syncdate {
    return _localizedValues[locale.languageCode]['syncdate'];
  }

  String get hempresa {
    return _localizedValues[locale.languageCode]['hempresa'];
  }

  String get empresa {
    return _localizedValues[locale.languageCode]['empresa'];
  }

  String get localurl {
    return _localizedValues[locale.languageCode]['localurl'];
  }

  String get autosync {
    return _localizedValues[locale.languageCode]['autosync'];
  }

  String get htelefono {
    return _localizedValues[locale.languageCode]['htelefono'];
  }

  String get hrnc {
    return _localizedValues[locale.languageCode]['hrnc'];
  }

  String get removeprest {
    return _localizedValues[locale.languageCode]['removeprest'];
  }

  String get printername {
    return _localizedValues[locale.languageCode]['printername'];
  }

  String get delaycopias {
    return _localizedValues[locale.languageCode]['delaycopias'];
  }

  String get hncopias {
    return _localizedValues[locale.languageCode]['hncopias'];
  }

  String get ncopias {
    return _localizedValues[locale.languageCode]['ncopias'];
  }

  String get systemdate {
    return _localizedValues[locale.languageCode]['systemdate'];
  }

  String get primeromora {
    return _localizedValues[locale.languageCode]['primeromora'];
  }

  String get settingtitle {
    return _localizedValues[locale.languageCode]['settingtitle'];
  }

  String get exitmessage {
    return _localizedValues[locale.languageCode]['exitmessage'];
  }

  String get okbutton {
    return _localizedValues[locale.languageCode]['okbutton'];
  }

  String get cancelbutton {
    return _localizedValues[locale.languageCode]['cancelbutton'];
  }

  String get confirmmessaetitle {
    return _localizedValues[locale.languageCode]['confirmmessaetitle'];
  }

  String get messagetitle {
    return _localizedValues[locale.languageCode]['messagetitle'];
  }

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get username {
    return _localizedValues[locale.languageCode]['username'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get login {
    return _localizedValues[locale.languageCode]['login'];
  }

  String get exit {
    return _localizedValues[locale.languageCode]['exit'];
  }

  String get uservalidate {
    return _localizedValues[locale.languageCode]['uservalidate'];
  }

  String get passwordvalidate {
    return _localizedValues[locale.languageCode]['passwordvalidate'];
  }
}