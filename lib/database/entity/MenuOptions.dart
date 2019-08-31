import 'package:moor_flutter/moor_flutter.dart';

class MenuOptions extends Table{
  IntColumn get menuid =>integer().withDefault(Constant(0))();
  TextColumn get nombre=>text().withLength(max: 50)();
  IntColumn get level =>integer().withDefault(Constant(0))();
  TextColumn get routename=>text().withLength(max: 50)();
  IntColumn get orden =>integer().withDefault(Constant(0))();
  BoolColumn get activo=>boolean().withDefault(Constant(true))();

  @override
  Set<Column> get primaryKey =>{menuid};
}