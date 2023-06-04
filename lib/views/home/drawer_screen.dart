import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/utils/assets_path.dart';

// ignore: must_be_immutable
class DrawerScreen extends StatelessWidget {

  DrawerScreen(this.signOut, this.userLoginId, this.status4);

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;

    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Center(
              child: Image.asset(AssetsPath.logo),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .getTranslated('beneficiariesHomeIcon'),
              style: textStyle,
            ),
            leading: Icon(Icons.people),
            onTap: () {
              goToBeneficiariesPage(context, signOut, 'Add Beneficiary',
                  User(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                      '', '', '', '','','','','','','','', '', '', '', '', '','','','','','','','','', '', '',
                      '','','','','','','','', '', '', '', '', '','','', '','','','','','', '', '',
                      '','','','','','','','', '', '', '', '', '','','','','','','','','', '', '',
                      '', '', '','','','','','', '', '', '', '', ''), false, null, userLoginId, status4);
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .getTranslated('addDemandAppBarTitle'),
              style: textStyle,
            ),
            leading: Icon(Icons.add_circle),
            onTap: () {
              goToDemandsPage(context, signOut,
                  User(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                      '', '', '', '', '', '', '','','','','','','','', '', '', '', '', '', '', '', '', '',
                      '', '', '','', '', '', '','','','','','','','', '', '', '', '', '','','', '','','',
                      '','','', '', '', '','','','','','','','', '', '', '', '','','','','','','','','',
                      '', '', '', '', '','','','','', '', '', '', ''),
                  Demand('', '',
                      '', 0, 0, 0, 0, 0, 0, '', 0, 0, '', 0, '', 0, 0, 0),
                  'Add Demand',
                  NatureDemand(''),
                  NatureProject(''),
                  Sector(''),
                  DelayPayment('', '',
                      '', '', '', '', '', ''),
                  userLoginId, status4);
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context).getTranslated('agendaHomeIcon'),
              style: textStyle,
            ),
            leading: Icon(Icons.table_chart),
            onTap: () {

            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .getTranslated('reportingHomeIcon'),
              style: textStyle,
            ),
            leading: Icon(Icons.report),
            onTap: () {
              goToReportsPage(context, signOut, userLoginId, status4);
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .getTranslated('simulator'),
              style: textStyle,
            ),
            leading: Icon(Icons.calculate_outlined),
            onTap: () {
              goToSimulationPage(context);
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .getTranslated('LinkedDevices'),
              style: textStyle,
            ),
            leading: Icon(Icons.phonelink),
            onTap: () {
              goToLinkedDevicesPage(context, signOut, userLoginId, status4);
              },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .getTranslated('Settings'),
              style: textStyle,
            ),
            leading: Icon(Icons.settings),
            onTap: () {
              goToAppSettingsPage(context, signOut, userLoginId, status4);
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context).getTranslated('drawerLogout'),
              style: textStyle,
            ),
            leading: Icon(Icons.lock_outline),
            onTap: () {
              signOut();
              goToLoginPage(context, status4);
              },
          )
        ],
      ),
    );
  }
}

