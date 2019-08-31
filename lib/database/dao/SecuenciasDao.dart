import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/Secuencias.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'SecuenciasDao.g.dart';

@UseDao(tables: [Secuencias])
class SecuenciasDao extends DatabaseAccessor<AppDatabase> with _$SecuenciasDaoMixin{
  final AppDatabase db;
  SecuenciasDao(this.db):super(db);
  
  Stream<List<Secuencia>> watchSecuencias()=>select(secuencias).watch();

  Future<int> create(Secuencia secuencia)=>into(secuencias).insert(secuencia,orReplace: true);

  Future<int> getSecuencia(String tipodoc,bool create)async{
    var secuencia=0;
    var result=await (select(secuencias)..where((s)=>s.tipodoc.equals(tipodoc))).get();
    if(result.isNotEmpty){
      secuencia=result.first.secuencia+result.first.intervalo;
      if(create){
        await customUpdate("update secuencias set secuencia=$secuencia where tipodoc='$tipodoc'");        
      }
    }else{
      secuencia=1;
    }
    return secuencia;
  }

}