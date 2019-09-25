import 'package:moor_flutter/moor_flutter.dart';

class Pagares extends Table {
  TextColumn get prestamoid => text().withLength(max: 15)();
  IntColumn get idpagare => integer()();  
  IntColumn get pagare => integer()();
  DateTimeColumn get fechavenc=>dateTime()();
  RealColumn get monto => real()();
  RealColumn get capital => real()();
  RealColumn get interes => real()();
  RealColumn get comision => real()();
  RealColumn get mora => real()();
  RealColumn get balance => real()();

  @override  
  Set<Column> get primaryKey => {idpagare};
}
