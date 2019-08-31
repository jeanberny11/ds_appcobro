import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/Recibos.dart';
import 'package:ds_appcobro/database/entity/SystemSettings.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'RecibosDao.g.dart';

@UseDao(tables: [Recibos, SystemSettings])
class RecibosDao extends DatabaseAccessor<AppDatabase> with _$RecibosDaoMixin {
  final AppDatabase db;
  RecibosDao(this.db) : super(db);

  Future<int> create(Recibo recibo) =>
      into(recibos).insert(recibo, orReplace: true);

  Future<List<Recibo>> getReciboNoSincronizados() =>
      (select(recibos)..where((r) => r.sincronizado.equals(false))).get();

  Future<int> getCountRecNoSinc() async {
    var res = await getReciboNoSincronizados();
    return res.length;
  }

  Future<Recibo> getRecibo(String serial) async {
    var res =
        await (select(recibos)..where((r) => r.serial.equals(serial))).get();
    if (res.length > 0) {
      return res.first;
    }
    return null;
  }

  Future<int> setReciboSincronizado(String serial) {
    return customUpdate(
        "update recibos set sincronizado=1 where serial='$serial'");
  }

  Future<int> getTotalRecibosHoy() async {
    var setting =
        await (select(systemSettings)..where((s) => s.id.equals(1))).get();
    var fechaop=setting.isEmpty?DateTime.now():setting.first.fechaop;    
    var res = await (select(recibos)
          ..where((r) => r.fecha.equals(fechaop)))
        .get();
    return res.length;
  }

  Future<int> getTotRecNoSinc() async {
    var res = await (select(recibos)
          ..where((r) => r.sincronizado.equals(false)))
        .get();
    return res.length;
  }

  Stream<List<Recibo>> watchRecNoSinc() =>
      (select(recibos)..where((r) => r.sincronizado.equals(false))).watch();

  Future<List<Recibo>> getRecibosByDateRange(
          DateTime fecha1, DateTime fecha2) =>
      (select(recibos)
            ..where((r) => r.fecha.isBiggerOrEqualValue(fecha1))
            ..where((r) => r.fecha.isSmallerOrEqualValue(fecha2))
            ..orderBy([
              (r) => OrderingTerm(expression: r.fecha),
              (r) => OrderingTerm(expression: r.serial, mode: OrderingMode.desc)
            ]))
          .get();
}
