import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/dao/app_helpers/parameters_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/service/api.dart';
import 'package:mobile4us_new_version/utils/alertDialog.dart';
import 'package:mobile4us_new_version/views/settings/theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AppSettings extends StatefulWidget {

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  AppSettings(this.signOut, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return _AppSettingsState(this.signOut, this.userLoginId, this.status4);
  }
}

class _AppSettingsState extends State<AppSettings> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  Parameters synchParam;
  ParameterHelper helperParameter = new ParameterHelper();
  User user;

  _AppSettingsState(this.signOut, this.userLoginId, this.status4);

  void _getSynchParam() async {
    final Parameters _synch = await helperParameter.getParameterByKey('autoSynch');
    setState(() {
      synchParam = _synch;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSynchParam();
  }

  @override
  Widget build(BuildContext context) {

    print('user login id is : ' + userLoginId.toString());
    return WillPopScope(

        onWillPop: () {
          goToHomePage(context, signOut, userLoginId, status4);
          return Future.value(true);
        },

        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0), // here the desired height
                child: AppBar(
                  title: Text(
                      AppLocalizations.of(context)
                          .getTranslated('Settings')),
                )),
            body: new Center(child: getSettingsListView())));
  }

  ListView getSettingsListView() {
    return ListView(
        children: <Widget>[

          Container(height: 25),

          MaterialButton(
              height: 50,
              onPressed: () {
                goToAppLockPage(context, signOut, userLoginId, status4);
              },
              elevation: 2.0,
              //color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 5),
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('FingerprintLock')),
                ],
              )
          ),

          Container(height: 25),

          MaterialButton(
              height: 50,
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).swapTheme();
              },
              elevation: 2.0,
              //color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.nightlight_round),
                  Container(width: 5),

                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('darkMode')),
                ],
              )
          ),

          Container(height: 25),

          MaterialButton(
              height: 50,
              onPressed: () {
                goToParameterPage(context, signOut, userLoginId, status4);
              },
              elevation: 2.0,
              //color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 5),
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('Parameters')),
                ],
              )
          ),

          Container(height: 25),

          MaterialButton(
              height: 50,
              onPressed: () {
                if (synchParam.value != '1')
                {
                  debugPrint('icon clicked');
                  var dialog = CustomAlertDialog(
                      message: AppLocalizations.of(context)
                          .getTranslated('SynchSendMessage'),
                      onPostivePressed: () async {
                        setState(() {
                          _syncNow(status4);
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      positiveBtnText: AppLocalizations.of(context)
                          .getTranslated('yes'),
                      negativeBtnText: AppLocalizations.of(context)
                          .getTranslated('no'));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                }
                else {}
              },
              elevation: 2.0,
              //color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 5),
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('SynchSend')),
                ],
              )
          ),

          Container(height: 25),

          MaterialButton(
              height: 50,
              onPressed: () {
                if (synchParam.value != '1')
                {
                  debugPrint('icon clicked');
                  var dialog = CustomAlertDialog(
                      message: AppLocalizations.of(context)
                          .getTranslated('SynchImportMessage'),
                      onPostivePressed: () async {
                        user = await helperUser.getId(userLoginId);
                        setState(() {
                          getBeneficiariesByResponsible(userLoginId, user.authorizationCode);
                          getDemandsByResponsible(userLoginId, user.authorizationCode);
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      positiveBtnText: AppLocalizations.of(context)
                          .getTranslated('yes'),
                      negativeBtnText: AppLocalizations.of(context)
                          .getTranslated('no'));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                }
                else {}
              },
              elevation: 2.0,
              //color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(width: 5),
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('SynchImport')),
                ],
              )
          ),

          Container(height: 25),
        ]
    );
  }
  _syncNow(_connectionStatus)async{
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
}

