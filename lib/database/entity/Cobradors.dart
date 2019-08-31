import 'package:moor_flutter/moor_flutter.dart';

class Cobradors extends Table{
  IntColumn get id =>integer().autoIncrement()();
  IntColumn get usuarioid =>integer().withDefault(Constant(0))();
  IntColumn get cobradorid =>integer().withDefault(Constant(0))();
  TextColumn get nombre =>text().withLength(max: 100)();
  TextColumn get telefono =>text().withLength(max: 30)();
  TextColumn get direccion =>text().withLength(max: 200)();
  BoolColumn get defecto =>boolean().withDefault(Constant(false))();
}