import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/Usuarios.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'UsuarioDao.g.dart';

@UseDao(tables: [Usuarios])
class UsuarioDao extends DatabaseAccessor<AppDatabase> with _$UsuarioDaoMixin{
  final AppDatabase db;
  UsuarioDao(this.db) : super(db);

  Future<Usuario> authUsuario(String username,String password)async{
    var result= await (select(usuarios)..where((u)=>u.usuario.equals(username))..where((u)=>u.clave.equals(password))).get();
    if(result.isNotEmpty){
      return result.first;
    }else{
      return null;
    }
  }

  Stream<List<Usuario>> watchUsuario()=>select(usuarios).watch();

  Future<int> create(Usuario usuario)=>into(usuarios).insert(usuario,orReplace: true);

  Future<bool> updateUsuario(Usuario usuario)=>update(usuarios).replace(usuario);
}