import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/Pagares.dart';
import 'package:ds_appcobro/database/entity/Prestamos.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:collection/collection.dart';

part 'PrestamosDao.g.dart';

@UseDao(tables: [Prestamos, Pagares])
class PrestamosDao extends DatabaseAccessor<AppDatabase>
    with _$PrestamosDaoMixin {
  final AppDatabase db;
  PrestamosDao(this.db) : super(db);

  Future<int> getTotalPrestamos() async {
    var res = await (select(prestamos)).get();
    return res.length;
  }

  Future<Prestamo> getPrestamo(String prestamoid) async {
    var result = await (select(prestamos)
          ..where((p) => p.prestamoid.equals(prestamoid)))
        .get();
    if (result.length > 0) {
      return result.first;
    }
    return null;
  }

  Future<Prestamo> getPrestamoDto(String serial)async{
    var result=await (select(prestamos)..where((p)=>p.cobrado.equals(false))).get();
    if(result.length>0){
      return result.first;
    }
    return null;
  }

  Future<int> getTotalPrestamosAtrasados() async {
    var res = await (select(prestamos)
          ..where((p) => p.cuotasvenc.isBiggerThanValue(1)))
        .get();
    return res.length;
  }

  Future<int> getTotalPrestamosCobrados() async {
    var res =
        await (select(prestamos)..where((p) => p.cobrado.equals(true))).get();
    return res.length;
  }

  Future<int> createPrestamo(Prestamo prestamo) =>
      into(prestamos).insert(prestamo, orReplace: true);

  Future<void> createAllPagares(List<Pagare> pagareslist) =>
      into(pagares).insertAll(pagareslist, orReplace: true);

  Future<int> deleteAllPrestamos() => delete(prestamos).go();
  Future<int> deleteAllPagares() => delete(pagares).go();

  Future<List<Prestamo>> getPrestamosNoCobrados()=>(select(prestamos)..where((p)=>p.cobrado.equals(false))).get();

  Future<int> getTotalPrestamosVencHoy() async {
    var datetime = DateTime.now();
    var hoy = DateTime(datetime.year, datetime.month, datetime.day);
    var res=await (select(pagares)..where((p)=>p.fechavenc.equals(hoy))).get();
    var group=groupBy(res,(pag)=>pag.prestamoid);
    return group.length;
  }

  Future<List<Pagare>> getPrestamoPagaresConBalance(String prestamoid) => (select(pagares)
        ..where((p) => p.prestamoid.equals(prestamoid))
        ..where((p)=> p.balance.isBiggerThanValue(0))
        ..orderBy([(p) => OrderingTerm(expression: p.pagare)]))
      .get();

  Future<int> setPrestamoCobrado(String prestamoid) {
    return customUpdate(
        "update prestamos set cobrado=1 where prestamoid='$prestamoid'");
  }
}
