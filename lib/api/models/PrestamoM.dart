import 'package:ds_appcobro/api/models/PagaresDto.dart';
import 'package:ds_appcobro/models/PrestamoDto.dart';

class PrestamoM {
  PrestamoDto prestamo;
  List<PagaresDto> pagares;
  
  PrestamoM._(this.prestamo,this.pagares);

  factory PrestamoM.fromJson(Map<String,dynamic> json){
    var pres=PrestamoDto.fromJson(json['prestamo']);
    var pag=json['pagares'].map<PagaresDto>((map)=>PagaresDto.fromJsom(map)).toList();
    return PrestamoM._(pres, pag);
  }
}

