import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';

// ignore: must_be_immutable
class AppLinkedDevices extends StatefulWidget {

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  AppLinkedDevices(this.signOut, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return _AppLinkedDevices(this.signOut, this.userLoginId, this.status4);
  }
}

class _AppLinkedDevices extends State<AppLinkedDevices> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  _AppLinkedDevices(this.signOut, this.userLoginId, this.status4);

  @override
  void initState() {
    super.initState();
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
                        .getTranslated('LinkedDevices'),
                  ),
                )),
            body: new Center(child: getSettingsListView())));
  }

  ListView getSettingsListView() {
    return ListView(
        children: <Widget>[

          Container(height: 25),

          Icon(Icons.phonelink, size: 100, color: Colors.grey,),

          Container(height: 25),

          Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 20.0, right: 20.0),
              child: Text(
                  AppLocalizations.of(context)
                      .getTranslated('LinkedDeviceMessage'),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)
              ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 20.0, right: 20.0),
            child: MaterialButton(
              height: 40,
              onPressed: () {
                goToScannerPage(context);
              },
              elevation: 2.0,
              color: Colors.indigoAccent,
              child:
              Text(
                AppLocalizations.of(context)
                    .getTranslated('LinkButtonText'),
                style: TextStyle(color: Colors.white),),
            )
          ),

          Container(height: 25),
        ]
    );
  }
}

