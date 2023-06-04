import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/service/local_auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AppLockPage extends StatefulWidget {

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  AppLockPage(this.signOut, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return _AppLockPageState(this.signOut, this.userLoginId, this.status4);
  }
}

class _AppLockPageState extends State<AppLockPage> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  _AppLockPageState(this.signOut, this.userLoginId, this.status4);

  //bool status4 = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('user login id is : ' + userLoginId.toString());
    return WillPopScope(

        onWillPop: () {
          goToAppSettingsPage(context, signOut, userLoginId, status4);
          return Future.value(true);
        },

        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0), // here the desired height
                child: AppBar(
                  title: Text(
                      AppLocalizations.of(context)
                          .getTranslated('FingerprintLock')),
                )),
            body: new Center(child: getSettingsListView())));
  }

  void onClic (bool val) async {
    final isAuthenticated = await LocalAuthApi.authenticate();

    if (isAuthenticated) {
      setState(() {
        status4 = val;
      });
      /*Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => FingerprintPage()),
  );*/
    }}

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState", value);
  }


  ListView getSettingsListView() {
    return ListView(
        children: <Widget>[

          Container(height: 25),

          MaterialButton(
              height: 50,
              onPressed: () {
                /*Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return AppSwitch(signOut, userLoginId); //Dashboard();
                    }));*/
                //onClic(true);
              },
              elevation: 2.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 5),
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('Lock')),
                  Container(width: 110),
                  Expanded(child: FlutterSwitch(
                    width: 55.0,
                    height: 25.0,
                    valueFontSize: 12.0,
                    toggleSize: 18.0,
                    value: status4,
                    onToggle: (val) {
                      setState(() {
                        onClic(val);
                        saveSwitchState(val);
                        //status4 = val;
                      });
                    },
                  )),
                ],
              )
          ),
          Container(height: 25),
        ]
    );
  }
}

