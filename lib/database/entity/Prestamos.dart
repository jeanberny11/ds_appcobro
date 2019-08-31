import 'package:moor_flutter/moor_flutter.dart';

class Prestamos extends Table{
  TextColumn get prestamoid=>text().withLength(max: 15)();
  IntColumn get idprestamo=>integer()();
  IntColumn get idcliente=>integer()();
  TextColumn get nombre =>text().withLength(max: 100)();
  TextColumn get direccion =>text().withLength(max: 300)();
  RealColumn get monto=>real()();
  RealColumn get balance=>real()();
  IntColumn get duracion=>integer()();
  RealColumn get cuota=>real()();
  IntColumn get cuotasvenc=>integer()();
  RealColumn get montovencido=>real()();
  IntColumn get ultimacuota=>integer()();
  RealColumn get balancecuota=>real()();
  RealColumn get mora=>real()();
  BoolColumn get ladob =>boolean()();
  BoolColumn get cobrado =>boolean()();

  @override
  Set<Column> get primaryKey =>{prestamoid};
}