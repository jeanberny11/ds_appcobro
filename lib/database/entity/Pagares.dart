import 'package:moor_flutter/moor_flutter.dart';

class Pagares extends Table {
  IntColumn get idpagare => integer()();
  TextColumn get prestamoid => text().withLength(max: 15)();
  DateTimeColumn get fechavenc=>dateTime()();
  IntColumn get pagare => integer()();
  RealColumn get cuota => real()();
  RealColumn get capital => real()();
  RealColumn get interes => real()();
  RealColumn get comision => real()();
  RealColumn get mora => real()();
  RealColumn get balance => real()();

  @override  
  Set<Column> get primaryKey => {idpagare};
}
