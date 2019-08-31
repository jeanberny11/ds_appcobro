import 'package:moor_flutter/moor_flutter.dart';

class Settings extends Table {
  IntColumn get id => integer().withDefault(Constant(1))();
  TextColumn get remoteurl => text().withLength(max: 50)();
  TextColumn get localurl => text().withLength(max: 50)();
  TextColumn get apiclient => text().withLength(max: 10)();
  TextColumn get apikey => text().withLength(max: 10)();
  BoolColumn get online => boolean().withDefault(Constant(true))();
  BoolColumn get internet => boolean().withDefault(Constant(true))();
  IntColumn get npopias => integer().withDefault(Constant(0))();
  IntColumn get delaycopias => integer().withDefault(Constant(0))();
  TextColumn get printername => text().withLength(max: 50)();
  TextColumn get printeraddres => text().withLength(max: 50)();

  @override
  Set<Column> get primaryKey => {id};
}
