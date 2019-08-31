import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/MenuOptions.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'MenuOptionDao.g.dart';

@UseDao(tables: [MenuOptions])
class MenuOptionDao extends DatabaseAccessor<AppDatabase>
    with _$MenuOptionDaoMixin {
  final AppDatabase db;
  MenuOptionDao(this.db) : super(db);

  Future<List<MenuOption>> findAll() => select(menuOptions).get();

  Stream<List<MenuOption>> watchAllActiveMenu() => (select(menuOptions)
        ..where((m) => m.activo.equals(true))
        ..orderBy([(m) => OrderingTerm(expression: m.orden)]))
      .watch();

  Future<List<MenuOption>> getMenuByLeve(int level) => (select(menuOptions)
        ..where((m) => m.level.isBiggerOrEqualValue(level))
        ..where((m) => m.activo.equals(true))
        ..orderBy([(m) => OrderingTerm(expression: m.orden)]))
      .get();
}
