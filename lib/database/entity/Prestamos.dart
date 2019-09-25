import 'package:moor_flutter/moor_flutter.dart';

class Prestamos extends Table{
  TextColumn get prestamoid=>text().withLength(max: 15)();
  IntColumn get idprestamo=>integer()();
  IntColumn get idcliente=>integer()();
  DateTimeColumn get fecha=>dateTime()();
  RealColumn get monto=>real()();
  RealColumn get balance=>real()();
  IntColumn get duracion=>integer()();
  RealColumn get cuota=>real()();
  TextColumn get formapago=>text().withLength(max: 30)();
  TextColumn get nombre=>text().withLength(max: 300)();
  TextColumn get direccion=>text().withLength(max: 600)();
  TextColumn get cedula=>text().withLength(max: 20)();
  TextColumn get telefono=>text().withLength(max: 30)();
  TextColumn get sexo=>text().withLength(max: 30)();
  IntColumn get cobradorid=>integer()();
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