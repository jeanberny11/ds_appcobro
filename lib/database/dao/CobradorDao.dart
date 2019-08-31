import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/Cobradors.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'CobradorDao.g.dart';

@UseDao(tables: [Cobradors])
class CobradorDao extends DatabaseAccessor<AppDatabase>
    with _$CobradorDaoMixin {
  final AppDatabase db;
  CobradorDao(this.db) : super(db);
  Stream<int> watchCobradorCount() =>
      select(cobradors).watch().map<int>((list) => list.length);

  Future<int> getCobradorCount() async {
    var list = await select(cobradors).get();
    return list.length;
  }

  Stream<int> watchCobradorCountByUser(int usuarioid) =>
      (select(cobradors)..where((c) => c.usuarioid.equals(usuarioid)))
          .watch()
          .map<int>((list) => list.length);

  Future<int> getCobradorCountByUser(int usuarioid) async {
    var list = await (select(cobradors)
          ..where((c) => c.usuarioid.equals(usuarioid)))
        .get();
    return list.length;
  }

  Stream<List<Cobrador>> watchUserCobrador(int usuarioid) =>
      (select(cobradors)..where((v) => v.usuarioid.equals(usuarioid))).watch();

  Future<bool> setDefaultCobrador(int usuarioid, Cobrador vendedor) async {
    await customUpdate(
        'update cobradors set defecto=0 where usuarioid=$usuarioid');
    return update(cobradors).replace(vendedor);
  }

  Future<Cobrador> getDefaultCobrador(int usuarioid) async {
    var res = await (select(cobradors)
          ..where((c) => c.defecto.equals(true))
          ..where((c) => c.usuarioid.equals(usuarioid)))
        .get();
    if (res.length > 0) {
      return res.first;
    }
    return null;
  }

  Future<Cobrador> getCobrador(int cobradorid) async {
    var res =
        await (select(cobradors)..where((c) => c.id.equals(cobradorid))).get();
    if (res.length > 0) {
      return res.first;
    }
    return null;
  }

  Future<int> deleteCobrador(int id) =>
      (delete(cobradors)..where((v) => v.id.equals(id))).go();

  Future<int> create(Cobrador vendedor) =>
      into(cobradors).insert(vendedor, orReplace: true);
}
