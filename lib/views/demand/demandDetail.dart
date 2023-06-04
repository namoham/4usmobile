import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:mobile4us_new_version/models/user.dart';

class DemandDetails extends StatefulWidget {

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  final User user;
  final Demand demand;
  final NatureDemand natureDemand;
  final Sector sector;
  final NatureProject natureProject;
  final DelayPayment _delayPayment;

  DemandDetails(this.signOut, this.user, this.demand, this.natureDemand, this.natureProject,
      this.sector, this._delayPayment, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return demandState(this.signOut, this.user, this.demand, this.natureDemand, this.sector,
        this.natureProject, this._delayPayment, this.userLoginId, this.status4);
  }
}

class demandState extends State<DemandDetails> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  User user;
  Demand demand;
  NatureDemand natureDemand;
  Sector sector;
  NatureProject natureProject;
  DelayPayment delayPayment;
  String appBarTitle;

  demandState(this.signOut, this.user, this.demand, this.natureDemand, this.sector,
      this.natureProject, this.delayPayment, this.userLoginId, this.status4);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).getTranslated('beneficiary')),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              bool showButton = true;
              bool showSaveButton = false;
              goToAddDemandPage(context, signOut, user, demand, 'add',
                  delayPayment, showButton, showSaveButton,
                  userLoginId, status4);
            },
            icon: Icon(Icons.edit),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            debugPrint('icon clicked');
            moveToLastScreen();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: _buildCard(),
    );
  }

  Widget _buildCard() => ListView(children: [
        Container(
          height: 30,
        ),
        Card(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context).getTranslated('detailsCode'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 20,
                  ),
                  Text(demand.code),
                ]),
              ),
              //Divider(),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, left: 30.0, right: 30.0, bottom: 20.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsDesignation'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                  Text(demand.designation),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsDescription'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                  demand.description != null ? Text(demand.description) : Text('testing'),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsBeneficiary'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                  Expanded(
                    child: Text(delayPayment.Name),
                  ) ,
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsDemNature'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                  natureDemand!=null?Text(natureDemand.Name):Text(''),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsProspector'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                  //Text(''),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsSector'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                    sector!=null?Text(sector.Name): Text(''),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsProjectNature'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                  natureProject!=null?Text(natureProject.Name): Text(''),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
                child: Row(children: [
                  Text(
                      AppLocalizations.of(context)
                          .getTranslated('detailsResponsible'),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  Container(
                    width: 30,
                  ),
                  //Text(''),
                ]),
              ),
            ],
          ),
        )
      ]);

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
