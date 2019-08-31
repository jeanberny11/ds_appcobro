import 'package:moor_flutter/moor_flutter.dart';

class Usuarios extends Table{
  IntColumn get usuarioid=> integer().autoIncrement()();
  TextColumn get usuario=>text().withLength(max: 15)();
  TextColumn get clave =>text().withLength(max: 20)();
  TextColumn get nombre =>text().withLength(max: 100)();
  TextColumn get direccion =>text().withLength(max: 300)();
  TextColumn get telefono =>text().withLength(max: 20)();
  IntColumn get level =>integer().withDefault(Constant(0))();
  BoolColumn get activo => boolean().withDefault(Constant(false))();
}
