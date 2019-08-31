import 'package:moor_flutter/moor_flutter.dart';

class UsuarioLevels extends Table{
  IntColumn get level=>integer().withDefault(Constant(0))();
  TextColumn get nombre=>text().withLength(max: 50)();

  @override
  Set<Column> get primaryKey => {level};
}