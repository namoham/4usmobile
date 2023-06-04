import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/dao/app_helpers/PaymentState_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/delayLevel_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/delayLevel.dart';
import 'package:mobile4us_new_version/models/paymentState.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/utils/assets_path.dart';
import 'package:mobile4us_new_version/utils/hexColor.dart';
import 'package:mobile4us_new_version/views/location/userLocation.dart';

class BeneficiariesDetails extends StatefulWidget {

  final VoidCallback signOut;
  final User user;
  final DelayLevel delayLevel;
  final Payment payment;
  int userLoginId;
  bool status4;

  BeneficiariesDetails(this.signOut, this.user, this.delayLevel, this.payment, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return beneficState(this.signOut, user, delayLevel, payment, this.userLoginId, this.status4);
  }
}

class beneficState extends State<BeneficiariesDetails> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  User user;
  DelayLevel delayLevel;
  Payment payment;

  PaymentStateHelper payHelper = new PaymentStateHelper();
  DelayLevelHelper helDelay = new DelayLevelHelper();

  File _imageFile;

  beneficState(this.signOut, this.user, this.delayLevel, this.payment, this.userLoginId, this.status4);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          goToBeneficiariesPage(context, signOut, '',
              User(1, 1, 1, 1, 1, 1,1, 1, 1, 1, 1, 1, 1, 1,
                  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', '', '', '', '', '',
                  '','','','','','','','', '', '', '', '', '','','','','','','','','', '', '',
                  '','','','','','','','', '', '', '', '', '','','', '','','','','','', '', '',
                  '','','','','','','','', '', '', '', '', '','','','','','','','','', '', '',
                  '', '', '','','','','', '', '', ''), false, null, userLoginId, status4);
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).getTranslated('beneficiary')),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  goToAddBeneficiaryPage(context, signOut,
                      'add', user, userLoginId, status4);
                  },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  if (user.mapsAddress != null){
                    getToUserLocationPage(context, signOut,
                        '', user, userLoginId, status4);
                  } else {}
                },
                icon: Icon(Icons.location_on),
              )
            ],
          ),
          body: _buildCard(),
        ));
  }
  Widget _buildCard() => ListView(children: [
    Container(
      height: 20,
    ),
    new Container(
      child: user.photo != null
          ? Image.file(
        File(user.photo),
        height: 120.0,
        width: 120,
      )
          : Image.asset(
        AssetsPath.image_4us,
        height: 120,
        width: 120,
      ),
    ),
    Container(
      height: 10,
    ),
    Card(
      child: Column(
        children: [
          ListTile(
            title: Text(user.firstName + ' ' + user.middleName,
                style: TextStyle(fontWeight: FontWeight.w900),
                textAlign: TextAlign.center),
/*
                user.firstName != null ? Text(user.firstName + ' ' + user.middleName,
                    style: TextStyle(fontWeight: FontWeight.w900),
                textAlign: TextAlign.center) : Text('test'),
*/
          ),
          Divider(),
          ListTile(
            title: Text(AppLocalizations.of(context).getTranslated('detailsIdentityNum'),
                style: TextStyle(fontSize: 14,
                    color: Colors.blueGrey)),
            subtitle: user.identity_ != null ? Text(user.identity_) : Text(' '),
            leading: Icon(
              Icons.perm_identity,
              color: Colors.indigoAccent,
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).getTranslated('detailsTelephone'),
                style: TextStyle(fontSize: 14,
                    color: Colors.blueGrey)),
            subtitle: user.telephone != null ? Text(user.telephone) : Text(' '),
            leading: Icon(
              Icons.phone,
              color: Colors.indigoAccent,
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).getTranslated('detailsEmail'),
                style: TextStyle(fontSize: 14,
                    color: Colors.blueGrey)),
            subtitle: user.email != null ? Text(user.email) : Text(' '),
            leading: Icon(
              Icons.contact_mail,
              color: Colors.indigoAccent,
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).getTranslated('detailsBusinessAgent'),
                style: TextStyle(fontSize: 14,
                    color: Colors.blueGrey)),
            subtitle: Text(''),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).getTranslated('detailsRefundStatus'),
                style: TextStyle(fontSize: 14,
                    color: Colors.blueGrey)),
          ),
          Opacity(
              opacity: payment != null ? 1 : 0,
              // visible if showShould is true
              child: ButtonTheme(
                height: 150,
                minWidth: 200,
                child: SizedBox(
                    width: 250,
                    child: RaisedButton(
                      onPressed: () {
                        debugPrint("button Tapped");
                        if (payment != null) {
                          print(payment.id.toString());
                          showDialog<Payment>(
                              context: context,
                              builder: (BuildContext context) {
                                return paymentDetail();
                              });
                        };
                      },
                      elevation: 2.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      color: delayLevel != null
                          ? HexColor(delayLevel.colorCode)
                          : Colors.grey,
                      child: payment != null
                          ? Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                              bottom: 5.0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).getTranslated('unpaidAmount'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white)),
                                Container(
                                  width: 20,
                                ),
                                Text(payment.unpaidAmount.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: Colors.white))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                              bottom: 5.0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).getTranslated('unpaidDeadlines'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white)),
                                Container(
                                  width: 20,
                                ),
                                Text(
                                    payment.numberDeadline.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: Colors.white))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                              bottom: 5.0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).getTranslated('delay(per day)'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white)),
                                Container(
                                  width: 60,
                                ),
                                Text(
                                    payment.numberDayDelay.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: Colors.white))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                              bottom: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).getTranslated('actorId'),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white)),
                                Container(
                                  width: 85,
                                ),
                                Text(payment.actorId.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: Colors.white))
                              ],
                            )),
                      ])
                          : Column(children: <Widget>[]),
                    )),
              )),
          Container(
            height: 10,
          ),
        ],
      ),
    )
  ]);

  Widget paymentDetail() {
    return AlertDialog(
        actions: [
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                            AppLocalizations.of(context).getTranslated('codeTableDeadline'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 20,
                        ),
                        Text(payment
                            .codeTableDeadline)
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('date'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 80,
                        ),
                        Text(payment.creationDate_ != null  ?
                        payment.creationDate_ : ' ')
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('totalAmount'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 40,
                        ),
                        Text(payment.totalAmount
                            .toString())
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('amount'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 74,
                        ),
                        Text(payment.amount
                            .toString())
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('payrollAmount'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 34,
                        ),
                        Text(payment
                            .payrollAmount
                            .toString())
                      ],
                    )),
                Divider(
                  thickness: 3,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('numberDeadline'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 35,
                        ),
                        Text(payment
                            .numberDeadline
                            .toString())
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('delay(per day)'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 75,
                        ),
                        Text(payment
                            .numberDayDelay
                            .toString())
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('unpaidAmount'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 32,
                        ),
                        Text(payment
                            .unpaidAmount
                            .toString())
                      ],
                    )),
                Divider(
                  thickness: 3,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).getTranslated('leftToPay'),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .blueGrey)),
                        Container(
                          width: 80,
                        ),
                        Text((payment
                            .totalAmount -
                            payment
                                .payrollAmount)
                            .toString())
                      ],
                    ))
              ],
            )));
  }
}


