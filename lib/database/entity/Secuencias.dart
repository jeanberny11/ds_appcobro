import 'package:moor_flutter/moor_flutter.dart';

class Secuencias extends Table{
  IntColumn get id =>integer().withDefault(Constant(0))();
  TextColumn get tipodoc=>text().withLength(max: 30)();
  IntColumn get secuencia=>integer().withDefault(Constant(0))();
  IntColumn get intervalo=>integer().withDefault(Constant(1))();
  TextColumn get descripcion=>text().withLength(max: 100)();

  @override
  Set<Column> get primaryKey =>{id};
}