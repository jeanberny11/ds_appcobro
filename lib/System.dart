
import 'package:ds_appcobro/database/AppDatabase.dart';

class System{
  static final System _singleton = System._internal();
  factory System() {
    return _singleton;
  }
  System._internal();
  Setting _setting;
  Usuario _usuario;
  Empresa _empresa;
  Cobrador _cobrador;
  bool _isSetup=false;

  void loadSetting(Setting setting){
    this._setting=setting;
    _isSetup=true;
  }
  void loadUsuario(Usuario user)=>_usuario=user;
  void loadEmpresa(Empresa empresa)=>this._empresa=empresa;
  void loadCobrador(Cobrador cobrador)=>this._cobrador=cobrador;

  Setting get setting=>this._setting;
  Usuario get currentUser=>this._usuario;
  bool get isSetup=>_isSetup;
  Empresa get empresa=>this._empresa;
  String get baseUrl=>_setting.internet?setting.remoteurl:setting.localurl;
  Cobrador get currentcobrador=>this._cobrador;
}