import 'package:moor_flutter/moor_flutter.dart';

class Recibos extends Table{
  TextColumn get serial=>text().withLength(max: 100)();
  TextColumn get documento=>text().withLength(max: 15)();
  TextColumn get prestamoid=>text().withLength(max: 15)();
  IntColumn get idcliente=>integer()();
  DateTimeColumn get fecha=>dateTime()();
  IntColumn get idcobrador=>integer()();
  RealColumn get monto=>real()();
  RealColumn get capital=>real()();
  RealColumn get interes=>real()();
  RealColumn get comision=>real()();
  RealColumn get mora=>real()();
  IntColumn get cuotasatrasadas=>integer()();
  TextColumn get concepto=>text().withLength(max: 500)();
  BoolColumn get efectivo=>boolean()();
  BoolColumn get sincronizado=>boolean().withDefault(Constant(false))();
  BoolColumn get ladob=>boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey =>{serial};
}