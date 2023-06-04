import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';

// ignore: must_be_immutable, camel_case_types
class chartsListScreen extends StatefulWidget {

  final VoidCallback signOut;

  int userLoginId;
  bool status4;

  chartsListScreen(this.signOut, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return chartsListState(this.signOut, this.userLoginId, this.status4);
  }
}

// ignore: camel_case_types
class chartsListState extends State<chartsListScreen> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  chartsListState(this.signOut, this.userLoginId, this.status4);

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(

        onWillPop: () {
          goToHomePage(context, signOut, userLoginId, status4);
          return Future.value(true);
        },

        child: Scaffold(
            backgroundColor: Colors.white70,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0), // here the desired height
                child: AppBar(
                  title: Text(
                      AppLocalizations.of(context).getTranslated('chartsList')),
                  leading: IconButton(
                    onPressed: () async {
                      goToHomePage(context, signOut, userLoginId, status4);
                    },
                    icon: Icon(Icons.home),
                    iconSize: 30.0,
                  ),
                )),
            body: new Center(child: getChartsListView())));
  }

  ListView getChartsListView() {

    return ListView(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 50.0),
      children: <Widget>[
        MaterialButton(
            height: 50,
            onPressed: () {
              String chartQuery = 'SELECT count(actorId) as value, TB_DELAY_PAYMENT_LEVEL.name as key, CAST(ROUND((count(actorId)*100)/(SELECT count(*) FROM TB_PAIEMENT_STATE))as TEXT) as percentage, TB_DELAY_PAYMENT_LEVEL.colorCode as color from TB_PAIEMENT_STATE join TB_DELAY_PAYMENT_LEVEL on levelDelayPaymentId=TB_DELAY_PAYMENT_LEVEL.Id group by TB_DELAY_PAYMENT_LEVEL.name';
              goToPieChart1Page(context, signOut,
                  userLoginId, chartQuery);
            },
            elevation: 2.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.pie_chart, color: Colors.blueGrey[700]),
                Container(width: 5,),

                Text(
                    AppLocalizations.of(context)
                        .getTranslated('delayPaymentButton')),
              ],
            )
        ),
        Container(
          height: 15,
        ),
        MaterialButton(
            height: 50,
            onPressed: () {
              String chartQuery = 'SELECT count(TB_ACTOR.id) as value, TB_POVERTY_DEGREE.Name as key, CAST(ROUND((count(TB_ACTOR.id)*100)/(SELECT count(*) FROM TB_ACTOR))as TEXT) as percentage FROM TB_ACTOR join TB_POVERTY_DEGREE on DegreePovertyId = TB_POVERTY_DEGREE.Id group by TB_POVERTY_DEGREE.Name';
              goToPieChart2Page(context, signOut,
                  userLoginId, chartQuery);
            },
            elevation: 2.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.pie_chart, color: Colors.orange),
                Container(width: 5),

                Text(
                    AppLocalizations.of(context)
                        .getTranslated('povertyDegreeButton')),
              ],
            )
        ),
        Container(
          height: 15,
        ),
        MaterialButton(
            height: 50,
            onPressed: () {
              String chartQuery = 'SELECT count(TB_ACTOR.id) as value, TB_FAMILY_SITUATION.Name as key, CAST(ROUND((count(TB_ACTOR.id)*100)/(SELECT count(*) FROM TB_ACTOR))as TEXT) as percentage FROM TB_ACTOR join TB_FAMILY_SITUATION on situationFamilyId = TB_FAMILY_SITUATION.Id group by TB_FAMILY_SITUATION.Name';
              goToPieChart3Page(context, signOut, userLoginId, chartQuery);
            },
            elevation: 2.0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.pie_chart, color: Colors.blueGrey[200]),
                Container(width: 5),

                Text(
                    AppLocalizations.of(context)
                        .getTranslated('familySituationButton')),
              ],
            )
        ),
      ],
    );
  }
}

