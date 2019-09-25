import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/EmpresaDao.dart';
import 'package:ds_appcobro/database/dao/MenuOptionDao.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/database/dao/SecuenciasDao.dart';
import 'package:ds_appcobro/database/dao/SettingDao.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:ds_appcobro/database/dao/UsuarioDao.dart';
import 'package:ds_appcobro/database/dao/UsuarioLevelDao.dart';
import 'package:ds_appcobro/database/entity/Cobradors.dart';
import 'package:ds_appcobro/database/entity/EmpresaSetting.dart';
import 'package:ds_appcobro/database/entity/MenuOptions.dart';
import 'package:ds_appcobro/database/entity/Pagares.dart';
import 'package:ds_appcobro/database/entity/Prestamos.dart';
import 'package:ds_appcobro/database/entity/Recibos.dart';
import 'package:ds_appcobro/database/entity/Secuencias.dart';
import 'package:ds_appcobro/database/entity/Settings.dart';
import 'package:ds_appcobro/database/entity/SystemSettings.dart';
import 'package:ds_appcobro/database/entity/UsuarioLevels.dart';
import 'package:ds_appcobro/database/entity/Usuarios.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'AppDatabase.g.dart';

@UseMoor(tables: [
  Cobradors,
  EmpresaSetting,
  MenuOptions,
  Pagares,
  Prestamos,
  Recibos,
  Secuencias,
  Settings,
  Usuarios,
  UsuarioLevels,
  SystemSettings
], daos: [UsuarioDao,MenuOptionDao,SettingDao,UsuarioLevelDao,EmpresaDao,SystemSettingDao,PrestamosDao,CobradorDao,SecuenciasDao,RecibosDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'dsdb.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  void createdefaultuser() async {
    var user =
        await (select(usuarios)..where((u) => u.usuarioid.equals(1))).get();
    if (user.isEmpty) {
      into(usuarios).insert(
          Usuario(
              usuarioid: null,
              usuario: 'su',
              clave: '1234',
              nombre: 'Jean Berny Gay',
              telefono: '829-457-7289',
              direccion: 'Santiago de lo caballeros',
              level: 0,
              activo: true),
          orReplace: true);
    }
  }
  
  List<MenuOption> defaultMenus() {
    return [
      MenuOption(
          menuid: 0,
          nombre: 'Salir',
          level: 2,
          routename: '',
          orden: 20,
          activo: true),
      MenuOption(
          menuid: 1,
          nombre: 'Usuarios',
          level: 1,
          routename: PageRoutes.usuarioroute,
          orden: 1,
          activo: true),
      MenuOption(
          menuid: 2,
          nombre: 'Cargar datos',
          level: 2,
          routename: PageRoutes.cargardatos,
          orden: 2,
          activo: true),
      MenuOption(
          menuid: 3,
          nombre: 'Cobro',
          level: 2,
          routename: PageRoutes.cobro,
          orden: 3,
          activo: true),
      MenuOption(
          menuid: 4,
          nombre: 'Reimprimir Rec.',
          level: 2,
          routename: PageRoutes.reimprimirrecibos,
          orden: 4,
          activo: true),
      MenuOption(
          menuid: 5,
          nombre: 'Empresa',
          level: 1,
          routename: PageRoutes.empresaroute,
          orden: 5,
          activo: true),
          MenuOption(
          menuid: 6,
          nombre: 'Secuencias',
          level: 1,
          routename: PageRoutes.secuencia,
          orden: 6,
          activo: true)
    ];
  }

  List<UsuarioLevel> userLeves() => [
        UsuarioLevel(level: 0, nombre: 'Super User'),
        UsuarioLevel(level: 1, nombre: 'Administrator'),
        UsuarioLevel(level: 2, nombre: 'Basic User')
      ];

  List<Secuencia> appSecuencias()=>[
    Secuencia(
      id: 1,
      tipodoc: 'RM',
      descripcion: 'Recibos mobil',
      secuencia: 1,
      intervalo: 1
    )
  ];

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) {
          return m.createAllTables().whenComplete(() {
            into(menuOptions).insertAll(defaultMenus());
            into(usuarioLevels).insertAll(userLeves());
            into(secuencias).insertAll(appSecuencias());
          });
        },        
      );
}
