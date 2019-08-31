import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("Empresa")
class EmpresaSetting extends Table{
  IntColumn get id=>integer().withDefault(Constant(0))();
  TextColumn get nombre=>text().withLength(max: 50)();
  TextColumn get direccion=>text().withLength(max: 200)();
  TextColumn get rnc=>text().withLength(max: 20)();
  TextColumn get telefono=>text().withLength(max: 50)();
  TextColumn get slogan=>text().withLength(max: 100)();
  BoolColumn get listadocompleto=>boolean()();
  BoolColumn get primeromora=>boolean()();
  
  @override
  Set<Column> get primaryKey =>{id};
}