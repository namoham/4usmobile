import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mobile4us_new_version/dao/app_helpers/parameters_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/user_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/service/api.dart';
import 'package:mobile4us_new_version/utils/assets_path.dart';
import 'package:mobile4us_new_version/views/home/drawer_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_offline/flutter_offline.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  HomeScreen(this.signOut, this.userLoginId, this.status4);

  @override
  _HomeScreenState createState() => _HomeScreenState(this.userLoginId, this.status4);
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _HomeScreenState(this.userLoginId, this.status4);

  var value;
  int userLoginId;
  bool status4;
  String lastUpdate = '';
  List<DateTime> time = [];

  Parameters synchParam = new Parameters("test", "test");
  ParameterHelper helperParameter = new ParameterHelper();
  UserHelper helperUser = new UserHelper();

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  void _showScaffold(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.blueGrey,
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _getSynchParam() async {
    final Parameters _synch = await helperParameter.getParameterByKey('autoSynch');
    setState(() {
      synchParam = _synch;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    _lastDate();
    _getSynchParam();
  }

  _lastDate()async{
     var allBeneficiariesRows = await helperUser.getUserList();
     int leng = allBeneficiariesRows.length;
     DateTime upd;
     DateTime def = DateTime.parse("1900-01-01");

     allBeneficiariesRows.forEach((element) {
       DateTime date = element.synchDate_ != null ?
       DateTime.parse(element.synchDate_) : def;
       time.add(date);
     });
     int dateLength = time.length;
     if(dateLength>0){
       time.sort();
     }
      if (leng > 0) {
        setState(() {
          upd = time.last;
        });
      }
     lastUpdate = DateFormat('dd-MM-yyyy hh:mm:ss ' ).format(upd);
  }

  _syncNow(_connectionStatus)async
  {
    if(_connectionStatus == true) {

      var allBeneficiariesRows = await helperUser.getSyncUserList();
      allBeneficiariesRows.forEach((row) async {
        await syncBeneficiary(userLoginId, row ,_connectionStatus);
      });

      var allDemandsRows = await helper.getSyncDemandList();
      allDemandsRows.forEach((row) async {
        await syncDemand(userLoginId, row ,_connectionStatus);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;

    String ResetDatabase = AppLocalizations.of(context)
        .getTranslated('ResetDatabase');
    String ExportDatabase = AppLocalizations.of(context)
        .getTranslated('ExportDatabase');
    List<String> choices = <String>[
      ResetDatabase,
      ExportDatabase
    ];

    return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(true);
        },
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            title: new Text(
              AppLocalizations.of(context).getTranslated('homeTitle'),
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
               onSelected: (value){
                 if(value == ExportDatabase){
                   print('Export Db');
                   _exportDb();
                 }
               },
               itemBuilder: (BuildContext context){
                return choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice, style: TextStyle(color: Colors.indigo),),
                  );
                }).toList();
              },
              icon: Icon(Icons.import_export),
            )
          ],
          ),
          bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              child: Container(
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                     lastUpdate != null ? AppLocalizations.of(context).
                     getTranslated('lastUpdate') + ': '+ lastUpdate :
                     AppLocalizations.of(context).getTranslated('lastUpdate') +
                         ': '+ AppLocalizations.of(context).getTranslated('NotFound'),
                      style: TextStyle(color: Colors.blueGrey[300]),
                    )
                  ],
                ),
              ),
            ),
          body: Builder(
            builder: (BuildContext context) {
              return OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if(connected){
                    if(synchParam.value == '1'){
                      _syncNow(connected);
                    }
                  }
                  status4 = connected;
                  return Stack(
                  fit: StackFit.expand,
                  children: [
                  child,
                  Positioned(
                  left: 0.0,
                  right: 0.0,
                  height: 32.0,
                  child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color:
                  connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: connected
                  ?  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "ONLINE",
                                style: TextStyle(color: Colors.white),
                              ),

                            ],
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "OFFLINE",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                width: 12.0,
                                height: 12.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                child: new Center(
                  child: new ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 40.0, bottom: 20.0, left: 5.0, right: 10.0),
                                child: Column(
                                    children: <Widget>[
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {
                                          goToBeneficiariesPage(context,
                                              signOut, 'Add Beneficiary',
                                              User(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                  '', '', '', '', '', '', '','','','','','','','', '', '', '', '', '','','','','','','',
                                                  '','', '', '', '','','','','','','','', '', '', '', '','','', '','','','','','', '', '',
                                                  '','','','','','','','', '', '', '', '', '','','','','','','','','', '', '', '', '', '','',
                                                  '','','','', '', '', ''), false, null,
                                              userLoginId, status4);
                                        },
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100.0),
                                            side: BorderSide(color: Colors.white)
                                        ),
                                        color: Colors.white,
                                        child: new Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image:  AssetImage(
                                                      AssetsPath.beneficiaries
                                                  )
                                              ),
                                            )),
                                      ),
                                      Container(
                                        height: 10.0,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .getTranslated(
                                            'beneficiariesHomeIcon'),
                                        style: textStyle,
                                      ),
                                    ]
                                )),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 40.0,
                                    bottom: 20.0,
                                    left: 5.0,
                                    right: 10.0),
                                child: Column(
                                    children: <Widget>[
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        padding: EdgeInsets.all(0.0),
                                        onPressed: () {
                                          goToDemandsPage(context, signOut,
                                              User(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                                  '', '', '', '', '', '', '','','','','','','','', '', '', '', '', '','','','','','',
                                                  '','','', '', '', '','','','','','','','', '', '', '', '', '','','', '','','','','',
                                                  '', '', '', '','','','','','','','', '', '', '', '', '','','','','','','','','', '',
                                                  '', '', '', '','','','','','', '', ''),
                                              Demand('',
                                                  '', '', 0, 0, 0, 0, 0, 0, '', 0, 0, '', 0, '', 0, 0, 0),
                                              'Add Demand',
                                              NatureDemand(''),
                                              NatureProject(''),
                                              Sector(''),
                                              DelayPayment('',
                                                  '', '', '', '', '', '', ''),
                                              userLoginId, status4);
                                        },
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100.0),
                                            side: BorderSide(color: Colors.white)
                                        ),
                                        color: Colors.white,
                                        child: new Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      AssetsPath.demandFinancement)
                                              ),
                                            )),
                                      ),
                                      Container(
                                        height: 10.0,
                                      ),
                                      Text(
                                        AppLocalizations.of(context).getTranslated('demandsHomeIcon'),
                                        style: textStyle,
                                      ),
                                    ]
                                )),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 5.0,
                                      right: 10.0),
                                  child: Column(
                                      children: <Widget>[
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          padding: EdgeInsets.all(0.0),
                                          onPressed: () {
                                            goToReportsPage(context,
                                                signOut, userLoginId, status4);
                                            },
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100.0),
                                              side: BorderSide(color: Colors.white)
                                          ),
                                          color: Colors.white,
                                          child: new Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:  AssetImage(
                                                        AssetsPath.reporting)
                                                ),
                                              )),
                                        ),
                                        Container(
                                          height: 10.0,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .getTranslated('reportingHomeIcon'),
                                          style: textStyle,
                                        ),
                                      ]
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, bottom: 10.0, left: 5.0, right: 10.0),
                                  child: Column(
                                      children: <Widget>[
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          padding: EdgeInsets.all(0.0),
                                          onPressed: () {
                                            debugPrint('icon clicked');
                                          },
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100.0),
                                              side: BorderSide(color: Colors.white)
                                          ),
                                          color: Colors.white,
                                          child: new Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:  AssetImage(
                                                        AssetsPath.agenda)
                                                ),
                                              )),
                                        ),
                                        Container(
                                          height: 10.0,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .getTranslated('agendaHomeIcon'),
                                          style: textStyle,
                                        ),
                                      ]
                                  )
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 10.0,
                                      left: 5.0,
                                      right: 10.0),
                                  child: Column(
                                      children: <Widget>[
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          padding: EdgeInsets.all(0.0),
                                          onPressed: () {
                                            goToSimulationPage(context);
                                          },
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100.0),
                                              side: BorderSide(color: Colors.white)
                                          ),
                                          color: Colors.white,
                                          child: new Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image:  AssetImage(
                                                        AssetsPath.calculation)
                                                ),
                                              )),
                                        ),
                                        Container(
                                          height: 10.0,
                                        ),
                                        Text(
                                          AppLocalizations.of(context).getTranslated('simulation'),
                                          style: textStyle,
                                        ),
                                      ]
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          drawer: DrawerScreen(signOut, userLoginId, status4),
        ));
  }

/*
  void choiceAction(String choice) {
    if(choice == Constants.ExportDatabase){
      print('Export Db');
      _exportDb();
    }
  }
*/

  void _exportDb() async {
    Directory dbDir = await getApplicationDocumentsDirectory();
    final sourcePath = join(dbDir.path, 'data_4us.db');
    print(sourcePath);
    File sourceFile = File(sourcePath);
    List content = await sourceFile.readAsBytes();

    if (await Permission.storage.request().isGranted) {
    final folderName = "4US";
    final targetDir = Directory("storage/emulated/0/$folderName");
    if ((await targetDir.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      targetDir.create();
    }
    final targetPath = join(targetDir.path, 'my_backup_db.db');
    print(targetPath);
    File targetFile = File(targetPath);
      var result;
      result = await targetFile.writeAsBytes(content, flush: true);
      if (result != null) {
        _showScaffold("Database Successfully exported to: " + folderName + "/" +
            "my_backup_db.db");
      } else {
        _showScaffold("Export faild!");
      }
    }
  }
}
