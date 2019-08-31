import 'package:moor_flutter/moor_flutter.dart';

class SystemSettings extends Table{
  IntColumn get id=>integer().withDefault(Constant(1))();
  DateTimeColumn get fechaop=>dateTime()();
  DateTimeColumn get fechasinc=>dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}