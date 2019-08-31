import 'dart:io';

import 'package:ds_appcobro/System.dart';
import 'package:ds_appcobro/database/AppDatabase.dart';
import 'package:ds_appcobro/database/dao/EmpresaDao.dart';
import 'package:ds_appcobro/database/dao/MenuOptionDao.dart';
import 'package:ds_appcobro/database/dao/PrestamosDao.dart';
import 'package:ds_appcobro/database/dao/RecibosDao.dart';
import 'package:ds_appcobro/database/dao/SettingDao.dart';
import 'package:ds_appcobro/database/dao/SystemSettingDao.dart';
import 'package:ds_appcobro/utils/PagesRoute.dart';
import 'package:ds_appcobro/utils/StringResources.dart';
import 'package:ds_appcobro/widgets/Loader.dart';
import 'package:ds_appcobro/widgets/flutter_radial_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateFormat _format;

  @override
  void initState() {
    super.initState();
    _format = DateFormat("dd-MM-yyyy");
  }

  @override
  Widget build(BuildContext context) {
    var systemsettingprovider = Provider.of<SystemSettingDao>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () async {
            var menuoption = await Navigator.of(context).push(_AppMenu());
            if (menuoption != null) {
              switch (menuoption.menuid) {
                case 0:
                  {
                    if (Platform.isAndroid) {
                      exit(0);
                    } else {
                      print(
                          "Esta opcion no esta disponoble para esta plataforma");
                    }
                    break;
                  }
                case 5:
                  {
                    var empresa =
                        await Provider.of<EmpresaDao>(context).findById(1);
                    if (empresa == null) {
                      empresa = Empresa(
                          id: 1,
                          nombre: '',
                          direccion: '',
                          telefono: '',
                          rnc: '',
                          slogan: '',
                          listadocompleto: false,
                          primeromora: false);
                    }
                    Navigator.of(context)
                        .pushNamed(PageRoutes.empresaroute, arguments: empresa);
                    break;
                  }
                case 1:
                  {
                    Navigator.of(context).pushNamed(PageRoutes.usuarioroute);
                    break;
                  }
                case 6:
                  {
                    Navigator.of(context).pushNamed(PageRoutes.secuencia);
                    break;
                  }
                case 2:
                  {
                    Navigator.of(context).pushNamed(PageRoutes.cargardatos);
                    break;
                  }
                case 3:
                  {
                    Navigator.of(context).pushNamed(PageRoutes.outrecibos);
                    break;
                  }
                case 4:
                  {
                    Navigator.of(context).pushNamed(PageRoutes.reimprimirrecibos);
                    break;
                  }  
              }
            }
          },
        ),
        title: Text(
          StringResources.of(context).home,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                var insetting =
                    await Provider.of<SettingDao>(context).findById(1);
                if (insetting == null) {
                  insetting = Setting(
                      id: 0,
                      remoteurl: '',
                      localurl: '',
                      apiclient: '',
                      apikey: '',
                      online: false,
                      internet: true,
                      npopias: 0,
                      delaycopias: 0,
                      printername: '',
                      printeraddres: '');
                }
                Navigator.of(context)
                    .pushNamed(PageRoutes.settingviewroute,
                        arguments: insetting)
                    .then((s) {
                  Provider.of<SettingDao>(context).findById(1).then((setting) {
                    if (setting != null) {
                      System().loadSetting(setting);
                    }
                  });
                });
              }),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(PageRoutes.perfilroute);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  System().currentUser.nombre.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          children: <Widget>[
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Fecha Operativa",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<SystemSetting>(
                    future: systemsettingprovider.getSystemSetting(),
                    builder: (context, snp) {
                      if (snp.connectionState == ConnectionState.done) {
                        if (snp.data != null) {
                          return Text(_format.format(snp.data.fechaop));
                        } else {
                          return Text(_format.format(DateTime.now()));
                        }
                      } else {
                        return Loader(
                          initialradius: 10,
                          animationduration: 3,
                          width: 20,
                          height: 20,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Fecha ult. sinc.",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<SystemSetting>(
                    future: systemsettingprovider.getSystemSetting(),
                    builder: (context, snp) {
                      if (snp.connectionState == ConnectionState.done) {
                        if (snp.data != null) {
                          return Text(_format.format(snp.data.fechasinc));
                        } else {
                          return Text("No data");
                        }
                      } else {
                        return Loader(
                          initialradius: 10,
                          animationduration: 3,
                          width: 20,
                          height: 20,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Text(
                      "Prestamos",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Total Prestamos: ",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FutureBuilder<int>(
                              future: Provider.of<PrestamosDao>(context)
                                  .getTotalPrestamos(),
                              builder: (context, snp) {
                                if (snp.connectionState ==
                                    ConnectionState.done) {
                                  return Text(snp.data.toString());
                                } else {
                                  return Loader(
                                    initialradius: 10,
                                    animationduration: 3,
                                    width: 20,
                                    height: 20,
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Prestamos atrasados: ",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FutureBuilder<int>(
                              future: Provider.of<PrestamosDao>(context)
                                  .getTotalPrestamosAtrasados(),
                              builder: (context, snp) {
                                if (snp.connectionState ==
                                    ConnectionState.done) {
                                  return Text(snp.data.toString());
                                } else {
                                  return Loader(
                                    initialradius: 10,
                                    animationduration: 3,
                                    width: 20,
                                    height: 20,
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Prestamos Cobrados: ",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FutureBuilder<int>(
                              future: Provider.of<PrestamosDao>(context)
                                  .getTotalPrestamosCobrados(),
                              builder: (context, snp) {
                                if (snp.connectionState ==
                                    ConnectionState.done) {
                                  return Text(snp.data.toString());
                                } else {
                                  return Loader(
                                    initialradius: 10,
                                    animationduration: 3,
                                    width: 20,
                                    height: 20,
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                            "Recibos Hoy: ",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FutureBuilder<int>(
                          future: Provider.of<RecibosDao>(context).getTotalRecibosHoy(),
                          builder: (context,snp){
                            if (snp.connectionState ==
                                    ConnectionState.done) {
                                  return Text(snp.data.toString());
                                } else {
                                  return Loader(
                                    initialradius: 10,
                                    animationduration: 3,
                                    width: 20,
                                    height: 20,
                                  );
                                }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),    
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(PageRoutes.recibosnoenviados);
              },
                          child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                              "Recibos no enviados: ",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FutureBuilder<int>(
                            future: Provider.of<RecibosDao>(context).getTotRecNoSinc(),
                            builder: (context,snp){
                              if (snp.connectionState ==
                                      ConnectionState.done) {
                                    return Text(snp.data.toString());
                                  } else {
                                    return Loader(
                                      initialradius: 10,
                                      animationduration: 3,
                                      width: 20,
                                      height: 20,
                                    );
                                  }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),    
              ),
            )
          ],
          staggeredTiles: [
            StaggeredTile.count(1, 0.5),
            StaggeredTile.count(1, 0.5),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2, 0.3),
            StaggeredTile.count(2, 0.3)
          ],
        ),
      ),
    );
  }
}

class _AppMenu extends ModalRoute<MenuOption> {
  GlobalKey<RadialMenuState> _menuKey = GlobalKey<RadialMenuState>();

  @override
  Color get barrierColor => Colors.black.withOpacity(0.1);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  IconData getMenuicon(int menuid) {
    switch (menuid) {
      case 0:
        {
          return Icons.exit_to_app;
        }
      case 1:
        {
          return Icons.person;
        }
      case 2:
        {
          return Icons.system_update;
        }
      case 3:
        {
          return Icons.monetization_on;
        }
      case 4:
        {
          return Icons.print;
        }
      case 5:
        {
          return Icons.business;
        }
      case 6:
        {
          return Icons.schedule;
        }
      default:
        {
          return Icons.pages;
        }
    }
  }

  Color getMenuColor(int menuid) {
    switch (menuid) {
      case 0:
        {
          return Colors.red;
        }
      case 1:
        {
          return Colors.blue;
        }
      case 2:
        {
          return Colors.orange;
        }
      case 3:
        {
          return Colors.green;
        }
      case 4:
        {
          return Colors.purple;
        }
      case 5:
        {
          return Colors.indigo;
        }
      case 6:
        {
          return Colors.brown;
        }
      default:
        {
          return Colors.teal;
        }
    }
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    var menuprovider = Provider.of<MenuOptionDao>(context);
    return FutureBuilder<List<MenuOption>>(
      future: menuprovider.getMenuByLeve(System().currentUser.level),
      builder: (context, snp) {
        if (snp.connectionState == ConnectionState.done) {
          var menuitems = List<RadialMenuItem<MenuOption>>.generate(
              snp.data.length, (index) {
            return RadialMenuItem(
              value: snp.data[index],
              child: Icon(getMenuicon(snp.data[index].menuid)),
              iconColor: Colors.white,
              backgroundColor: getMenuColor(snp.data[index].menuid),
              tooltip: snp.data[index].nombre,
            );
          });
          return Center(
            child: RadialMenu(
              key: _menuKey,
              items: menuitems,
              initopen: true,
              onMenuOpened: () {},
              onSelected: (menuoption) {
                Navigator.of(context).pop(menuoption);
              },
              onMenuClosed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        } else {
          return Center(
            child: Loader(
              initialradius: 25,
              animationduration: 3,
            ),
          );
        }
      },
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
