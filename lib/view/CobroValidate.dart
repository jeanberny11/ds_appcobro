import 'dart:async';

import 'package:ds_appcobro/api/services/RecibosServices.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:ds_appcobro/managers/SyncRecibosManager.dart';
import 'package:ds_appcobro/utils/Utils.dart';
import 'package:ds_appcobro/view/OutRecibosView.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:flutter/material.dart';

class CobroValidate extends StatefulWidget {
  final RecibosServices services;
  final RecibosDao recibosDao;
  final CobradorDao cobradorDao;
  final PrestamosDao prestamosDao;
  final SystemSettingDao systemSettingDao;

  const CobroValidate({Key key,@required this.services,@required this.recibosDao,@required this.cobradorDao,@required this.prestamosDao,@required this.systemSettingDao}) : super(key: key);

  @override
  _CobroValidateState createState() => _CobroValidateState();
}

class _CobroValidateState extends State<CobroValidate> {
  SyncRecibosManager _syncRecibosManager;
  StreamSubscription<SyncState> _subscription;
  @override
  void initState() {
    super.initState();
    _syncRecibosManager=SyncRecibosManager(widget.services, widget.recibosDao, widget.cobradorDao, widget.prestamosDao,widget.systemSettingDao);
    _syncRecibosManager.init();
    _subscription=_syncRecibosManager.sincsubject.listen((state){
      if(state is DoneState){
        Future.delayed(Duration(milliseconds: 1000),(){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OutRecibosView()));
        });
      }
    });
    _syncRecibosManager.verificar();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _syncRecibosManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(_syncRecibosManager.isexecuting){
          mensaje(context, "Se esta ejecutando el proceso de sincronizacion, por favor espere!");
          return false;
        }
        return true;
      },
      child: Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<SyncState>(
            stream: _syncRecibosManager.sincsubject,
            builder: (context,snp){              
              if(snp.hasData){
                var state=snp.data;
                if(state is InitState){
                  return Center(
                    child: Text("Sincronizar recibos"),
                  );
                }else if(state is LoadingState){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Loader(
                          initialradius: 30,
                          animationduration: 3,
                          width: 60,
                          height: 60,
                        ),
                        Text(state.mensaje,textAlign: TextAlign.center,)
                      ],
                    ),
                  );
                }else if(state is ErrorState){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[                        
                        Text(state.error,textAlign: TextAlign.center,),
                        SizedBox(height: 10,),
                        FlatButton(
                          child: Text("Aceptar"),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
                }else if(state is DoneState){                  
                  return Center(
                    child: Text(state.mensaje),
                  );
                }else{
                  return Container();
                }
              }else{
                return Center(
                  child: Loader(
                    initialradius: 30,
                    animationduration: 3,
                    dotradius: 8,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}