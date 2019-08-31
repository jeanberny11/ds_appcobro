import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/Settings.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'SettingDao.g.dart';

@UseDao(tables: [Settings])
class SettingDao extends DatabaseAccessor<AppDatabase> with _$SettingDaoMixin{
  SettingDao(AppDatabase db) : super(db);

  Future<Setting> findById(int id)async{
    var res=await (select(settings)..where((s)=>s.id.equals(id))).get();
    if(res.length>0){
      return res.first;
    }
    return null;
  }

  Future<int> create(Setting setting)=>into(settings).insert(setting,orReplace: true);
}