import 'package:ds_appcobro/api/ApiClient.dart';
import 'package:ds_appcobro/api/services/CobradoresServices.dart';
import 'package:ds_appcobro/api/services/EmpresaServices.dart';
import 'package:ds_appcobro/api/services/PrestamosServices.dart';
import 'package:ds_appcobro/api/services/RecibosServices.dart';
import 'package:ds_appcobro/bluetooth/BluetoothDevicesPicker.dart';
import 'package:ds_appcobro/bluetooth/BluetoothManager.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/CobradorDao.dart';
import 'package:ds_appcobro/database/dao/EmpresaDao.dart';
import 'package:ds_appcobro/database/dao/MenuOptionDao.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/database/dao/SecuenciasDao.dart';
import 'package:ds_appcobro/database/dao/SettingDao.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:ds_appcobro/database/dao/UsuarioDao.dart';
import 'package:ds_appcobro/database/dao/UsuarioLevelDao.dart';
import 'package:ds_appcobro/managers/CargarDatosManager.dart';
import 'package:ds_appcobro/managers/PrinterManager.dart';
import 'package:ds_appcobro/managers/ReciboManager.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/StringResources.dart';
import 'package:ds_appcobro/utils/StringResourcesDelegate.dart';
import 'package:ds_appcobro/view/CargarDatosView.dart';
import 'package:ds_appcobro/view/CobradorPicker.dart';
import 'package:ds_appcobro/view/CobroValidate.dart';
import 'package:ds_appcobro/view/EmpresaView.dart';
import 'package:ds_appcobro/view/Home.dart';
import 'package:ds_appcobro/view/InSecuencias.dart';
import 'package:ds_appcobro/view/InUsuario.dart';
import 'package:ds_appcobro/view/Login.dart';
import 'package:ds_appcobro/view/OutCobradores.dart';
import 'package:ds_appcobro/view/OutRecibosView.dart';
import 'package:ds_appcobro/view/OutSecuencias.dart';
import 'package:ds_appcobro/view/OutUsuarios.dart';
import 'package:ds_appcobro/view/PasswordEdit.dart';
import 'package:ds_appcobro/view/Perfil.dart';
import 'package:ds_appcobro/view/PrinterView.dart';
import 'package:ds_appcobro/view/ReciboView.dart';
import 'package:ds_appcobro/view/RecibosNoSincView.dart';
import 'package:ds_appcobro/view/ReimprimirView.dart';
import 'package:ds_appcobro/view/SettingView.dart';
import 'package:ds_appcobro/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          builder: (context) {
            return AppDatabase()..createdefaultuser();
          },
        ),
        Provider<ApiClient>(
          builder: (context) {
            return ApiClient();
          },
          dispose: (context, apiclient) {
            apiclient.close();
          },
        ),
        ProxyProvider<AppDatabase, UsuarioDao>(
          builder: (context, appdatabase, _) {
            return UsuarioDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, MenuOptionDao>(
          builder: (context, appdatabase, _) {
            return MenuOptionDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, SettingDao>(
          builder: (context, appdatabase, _) {
            return SettingDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, UsuarioLevelDao>(
          builder: (context, appdatabase, _) {
            return UsuarioLevelDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, EmpresaDao>(
          builder: (context, appdatabase, _) {
            return EmpresaDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, SystemSettingDao>(
          builder: (context, appdatabase, _) {
            return SystemSettingDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, PrestamosDao>(
          builder: (context, appdatabase, _) {
            return PrestamosDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, RecibosDao>(
          builder: (context, appdatabase, _) {
            return RecibosDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, CobradorDao>(
          builder: (context, appdatabase, _) {
            return CobradorDao(appdatabase);
          },
        ),
        ProxyProvider<AppDatabase, SecuenciasDao>(
          builder: (context, appdatabase, _) {
            return SecuenciasDao(appdatabase);
          },
        ),
        ProxyProvider<ApiClient, EmpresaServices>(
          builder: (context, apiclient, _) {
            return EmpresaServices(apiclient);
          },
        ),
        ProxyProvider<ApiClient, CobradoresServices>(
          builder: (context, apiclient, _) {
            return CobradoresServices(apiclient);
          },
        ),
        ProxyProvider<ApiClient, PrestamosServices>(
          builder: (context, apiclient, _) {
            return PrestamosServices(apiclient);
          },
        ),
        ProxyProvider<ApiClient, RecibosServices>(
          builder: (context, apiclient, _) {
            return RecibosServices(apiclient);
          },
        ),
        Provider<BluetoothManager>(
          builder: (context) {
            return BluetoothManager();
          },
        ),
        ProxyProvider4<RecibosServices,RecibosDao,PrestamosDao,SecuenciasDao,ReciboManager>(
          builder: (context,recibosservices,recibosdao,prestamosdao,secuenciasdao,_){
            return ReciboManager(recibosservices, recibosdao,prestamosdao,secuenciasdao);
          },
        ),
        ProxyProvider2<PrestamosDao,RecibosDao,PrinterManager>(
          builder: (context,prestamosdao,recibosdao,_){
            return PrinterManager(prestamosdao,recibosdao);
          },
        )
      ],
      child: MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              StringResources.of(context).title,
          localizationsDelegates: [
            const StringResourcesDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('es', ''),
          ],
          title: 'Dream App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColorDark: Color(0xFF0100ca),
              primaryColor: Color(0xFF651fff),
              accentColor: Color(0xFFa255ff),
              fontFamily: 'Nunito'),
          home: SplashScreen(),
          onGenerateRoute: (setting) {
            switch (setting.name) {
              case PageRoutes.loginroute:
                {
                  return MaterialPageRoute(builder: (context) => Login());
                }
              case PageRoutes.homeroute:
                {
                  return MaterialPageRoute(builder: (context) => Home());
                }
              case PageRoutes.settingviewroute:
                {
                  return MaterialPageRoute(
                      builder: (context) => SettingView(setting.arguments));
                }
              case PageRoutes.empresaroute:
                {
                  return MaterialPageRoute(
                      builder: (context) => EmpresaView(
                            empresa: setting.arguments,
                          ));
                }
              case PageRoutes.bluetoothpicker:
                {
                  return MaterialPageRoute(
                      builder: (context) => BluetoothDevicesPicker());
                }
              case PageRoutes.usuarioroute:
                {
                  return MaterialPageRoute(builder: (context) => OutUsuarios());
                }
              case PageRoutes.inusuarioroute:
                {
                  return MaterialPageRoute(
                      builder: (context) => InUsuario(
                            usuario: setting.arguments,
                          ));
                }
              case PageRoutes.cobradorroute:
                {
                  return MaterialPageRoute(
                      builder: (context) => OutCobradores(setting.arguments));
                }
              case PageRoutes.cobradorpickerroute:
                {
                  return MaterialPageRoute(
                      builder: (context) => CobradorPicker());
                }
              case PageRoutes.perfilroute:
                {
                  return MaterialPageRoute(builder: (context) => Perfil());
                }
              case PageRoutes.passwordedit:
                {
                  return MaterialPageRoute(
                      builder: (context) => PasswordEdit());
                }
              case PageRoutes.secuencia:
                {
                  return MaterialPageRoute(
                      builder: (context) => OutSecuencias());
                }
              case PageRoutes.insecuencia:
                {
                  return MaterialPageRoute(
                      builder: (context) => InSecuencias(
                            secuencia: setting.arguments,
                          ));
                }
              case PageRoutes.cargardatos:
                {
                  return MaterialPageRoute(
                      builder: (context) => ChangeNotifierProxyProvider3<
                              PrestamosServices,
                              PrestamosDao,
                              SystemSettingDao,
                              CargarDatosManager>(
                            builder: (context, service, dao, settingdao, _) {
                              return CargarDatosManager(
                                  service, dao, settingdao);
                            },
                            child: CargarDatosView(),
                          ));
                }
              case PageRoutes.cobroprovider:
                {
                  return MaterialPageRoute(
                      builder: (context) => CobroValidate(
                            services: Provider.of<RecibosServices>(context),
                            recibosDao: Provider.of<RecibosDao>(context),
                            cobradorDao: Provider.of<CobradorDao>(context),
                            prestamosDao: Provider.of<PrestamosDao>(context),
                            systemSettingDao: Provider.of<SystemSettingDao>(context),
                            searchMode: setting.arguments,
                          ));
                }
              case PageRoutes.outallpresrecibos:
                {
                  return MaterialPageRoute(
                      builder: (context) => OutRecibosView());
                }  
              case PageRoutes.cobro:
                {
                  return MaterialPageRoute(
                      builder: (context) => ReciboView(
                            prestamo: setting.arguments,
                          ));
                }
              case PageRoutes.printrecibo:
                {
                  return MaterialPageRoute(
                      builder: (context) => PrinterView(
                            impresionReciboData: setting.arguments,
                          ));
                }
              case PageRoutes.recibosnoenviados:
                {
                  return MaterialPageRoute(
                      builder: (context) => RecibosNoSincView());
                }  
              case PageRoutes.reimprimirrecibos:
                {
                  return MaterialPageRoute(
                      builder: (context) => ReimprimirView());
                }    
              default:
                {
                  return null;
                }
            }
          }),
    );
  }
}
