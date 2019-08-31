
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/entity/SystemSettings.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'SystemSettingDao.g.dart';
@UseDao(tables: [SystemSettings])
class SystemSettingDao extends DatabaseAccessor<AppDatabase> with _$SystemSettingDaoMixin{
  final AppDatabase db;
  SystemSettingDao(this.db):super(db);
  
  Future<SystemSetting> getSystemSetting()async{
    var res=await (select(systemSettings)..where((s)=>s.id.equals(1))).get();
    if(res.length>0){
      return res.first;
    }
    return null;
  }

  Future<int> create(SystemSetting systemSetting)=>into(systemSettings).insert(systemSetting,orReplace: true);
}