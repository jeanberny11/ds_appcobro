import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/UsuarioLevels.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'UsuarioLevelDao.g.dart';
@UseDao(tables: [UsuarioLevels])
class UsuarioLevelDao extends DatabaseAccessor<AppDatabase> with _$UsuarioLevelDaoMixin{
  final AppDatabase db;
  UsuarioLevelDao(this.db):super(db);

  Future<List<UsuarioLevel>> findAll()=>(select(usuarioLevels)..orderBy([(u)=>OrderingTerm(expression: u.level)])).get();
}