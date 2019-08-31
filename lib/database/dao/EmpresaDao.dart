import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/EmpresaSetting.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'EmpresaDao.g.dart';

@UseDao(tables: [EmpresaSetting])
class EmpresaDao extends DatabaseAccessor<AppDatabase> with _$EmpresaDaoMixin {
  final AppDatabase db;
  EmpresaDao(this.db) : super(db);

  Future<int> create(Empresa empresa) =>
      into(empresaSetting).insert(empresa, orReplace: true);

  Future<Empresa> findById(int id) async {
    var res =
        await (select(empresaSetting)..where((e) => e.id.equals(id))).get();
    if (res.length > 0) {
      return res.first;
    }
    return null;
  }
}
