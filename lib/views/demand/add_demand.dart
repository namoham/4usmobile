import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/dao/app_helpers/demand_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/natureDemand_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/natureProject_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/sector_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/views/users/beneficiaries_screen.dart';

class AddDemand extends StatefulWidget {

  final VoidCallback signOut;

  final String appBarTitle;
  final Demand demand;
  final User user;
  final DelayPayment delayPayment;
  final bool showButton;
  final bool showSaveButton;
  int userLoginId;
  bool status4;

  AddDemand(this.signOut, this.user, this.demand, this.appBarTitle, this.delayPayment, this.showButton, this.showSaveButton, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return AddDemandState(this.signOut, this.user, this.demand, this.appBarTitle, this.delayPayment, this.showButton, this.showSaveButton, this.userLoginId, this.status4);
  }
}

class AddDemandState extends State<AddDemand> {

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  final bool readOnly = true;
  var _formKey = GlobalKey<FormState>();
  BeneficiariesScreen beneficiaryScreen;

  DemandHelper helper = new DemandHelper();

  String appBarTitle;
  Demand demand;
  User user;
  NatureDemand natureDe;
  Sector sector;
  NatureProject natureProject;
  DelayPayment DelayPay;

  NatureDemand natureDemandText;
  Sector sectorText;
  NatureProject natureProjectText;

  NatureDemandHelper natureDeHelper = new NatureDemandHelper();
  SectorHelper sectorHelper = new SectorHelper();
  NatureProjectHelper natureProjectHelper = new NatureProjectHelper();

  List<NatureDemand> natureDeList = <NatureDemand>[];
  List<Sector> sectorList = <Sector>[];
  List<NatureProject> natureProjectList = <NatureProject>[];

  bool showButton = false;
  bool showSaveButton = false;
  bool showDeleteButton = false;

  @override
  void initState() {
    super.initState();
    _getNatureDemandList();
    _getSectorList();
    _getNatureProjectList();
    _getNatureDemandText();
    _getSectorText();
    _getNatureProjectText();
  }

  void _getNatureDemandText() async {
    final NatureDemand list = await natureDeHelper.getId(demand.natureRequestId);
    if (demand != null) {
      setState(() {
        natureDemandText = list;
      });
    }
  }

  void _getSectorText() async {
    final Sector list = await sectorHelper.getId(demand.sectorId);
    if (demand != null) {
      setState(() {
        sectorText = list;
      });
    }
  }

  void _getNatureProjectText() async {
    final NatureProject list = await natureProjectHelper.getId(demand.natureProjectId);
    if (demand != null) {
      setState(() {
        natureProjectText = list;
      });
    }
  }

  void _getNatureDemandList() async {
    final List<NatureDemand> list = await natureDeHelper.getNatureDemandList();
    setState(() {
      natureDeList = list;
    });
  }

  void _getSectorList() async {
    final List<Sector> secList = await sectorHelper.getSectorList();
    setState(() {
      sectorList = secList;
    });
  }

  void _getNatureProjectList() async {
    final List<NatureProject> natureProList =
    await natureProjectHelper.getNatureProjectList();
    setState(() {
      natureProjectList = natureProList;
    });
  }

  TextEditingController codeController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController beneficiaryController = TextEditingController();
  TextEditingController natureDemandController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController natureProjectController = TextEditingController();

  AddDemandState(this.signOut, this.user, this.demand, this.appBarTitle, this.DelayPay, this.showButton, this.showSaveButton, this.userLoginId, this.status4);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .bodyText1;
    codeController.text = demand.code;
    designationController.text = demand.designation;
    descriptionController.text = demand.description;
    beneficiaryController.text = DelayPay.Name;
    natureDemandController.text = natureDemandText != null ? natureDemandText.Name : ' ';
    sectorController.text = sectorText != null ? sectorText.Name : ' ';
    natureProjectController.text = natureProjectText != null ? natureProjectText.Name : ' ';

    return WillPopScope(

        onWillPop: () {
          goToDemandsPage(context, signOut, user, demand,
              appBarTitle, natureDe, natureProject,
              sector, DelayPay, userLoginId, status4);
          return Future.value(true);
        },

        child: Scaffold(
          appBar: AppBar(
            title:
            Text(AppLocalizations.of(context).getTranslated('addDemandAppBarTitle'), style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.left),
            actions: <Widget>[
              showButton ? IconButton(
                onPressed: () {
                  debugPrint('icon clicked');
                  setState(() {
                    showSaveButton = true;
                    showDeleteButton = true;
                    showButton = false;
                  });
                },
                icon: Icon(Icons.edit),
              ) : SizedBox(),

              showDeleteButton ? IconButton(
                onPressed: () {
                  debugPrint('icon clicked');
                  _showAlertToDelete(AppLocalizations.of(context).getTranslated('deleteTitle'), AppLocalizations.of(context).getTranslated('deleteMessage'));
                },
                icon: Icon(Icons.delete_forever),
              ) : SizedBox(),

              showSaveButton ? IconButton(
                onPressed: () {
                  debugPrint('icon clicked');
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      _save();
                    }
                  });
                },
                icon: Icon(Icons.save),

              ) : SizedBox(),
            ],
          ),
          body: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                  child: ListView(
                    children: <Widget>[
                      //First Element
                      ListTile(
                        title: TextFormField(
                          readOnly: true,
                          controller: codeController,
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            debugPrint('Something changed in Code Text Field');
                            updateCode();
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).getTranslated('code'),
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))
                            //labelStyle: textStyle,
                          ),
                        ),
                      ),

                      // Second Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextFormField(
                          readOnly: showButton,
                          controller: designationController,
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'required fields';
                            }
                            return null;
                          },
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            debugPrint(
                                'Something changed in Designation Text Field');
                            updateDesignation();
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).getTranslated('designation') + ' *',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),

                      // Third Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextFormField(
                          readOnly: showButton,
                          controller: descriptionController,
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            debugPrint(
                                'Something changed in Description Text Field');
                            updateDescription();
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).getTranslated('description'),
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),

                      // Fourth Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextFormField(
                          readOnly: showButton,
                          controller: beneficiaryController,
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'required fields';
                            }
                            return null;
                          },
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onTap: () {

                            if (showButton == true) {

                            }
                            else{
                              bool test = true;
                              goToBeneficiariesPage(context, signOut,
                                  appBarTitle, user, test, demand,
                                  userLoginId, status4);
                            }
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).getTranslated('beneficiary') + ' *',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),

                      //Fifth Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: showButton ? TextFormField(
                          readOnly: showButton,
                          controller: natureDemandController,
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'required fields';
                            }
                            return null;
                          },
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onChanged: (value) {

                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).getTranslated('demand nature') + ' *',
                              labelStyle: TextStyle(fontSize: 18)
                          ),
                        )
                            : DropdownButtonFormField<NatureDemand>(
                          //isExpanded: true,
                          decoration: InputDecoration(
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: AppLocalizations.of(context).getTranslated('demand nature') + ' *',
                            labelStyle: TextStyle(fontSize: 18),
                            contentPadding: EdgeInsets.symmetric(vertical: 9),
                          ),
                          value: natureDeList.isEmpty ? natureDe
                              : natureDeHelper.getNatureDemand(demand.natureRequestId, natureDeList),
                          iconSize: 24,
                          elevation: 16,
                          validator: (value) {
                            if (value == null) {
                              return 'required fields';
                            }
                            return null;
                          },
                          onChanged: (NatureDemand valueSelectedByUser) {
                            natureDe = valueSelectedByUser;
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              demand.natureRequestId = valueSelectedByUser.id;
                            });
                          },
                          items: natureDeList
                              .map((natureDe) =>
                              DropdownMenuItem<NatureDemand>(
                                child: natureDe.Name != null?
                                Text(natureDe.Name) : Text(''),
                                value: natureDe,
                              ))
                              .toList(),
                        ),
                      ),

                      //Sixth Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: showButton ? TextFormField(
                          readOnly: showButton,
                          controller: sectorController,
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'required fields';
                            }
                            return null;
                          },
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onChanged: (value) {

                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).getTranslated('sector') + ' *',
                              labelStyle: TextStyle(fontSize: 18)
                          ),
                        )
                            : DropdownButtonFormField<Sector>(
                          //isExpanded: true,
                          decoration: InputDecoration(
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: AppLocalizations.of(context).getTranslated('sector') + ' *',
                            labelStyle: TextStyle(fontSize: 18),
                            contentPadding: EdgeInsets.symmetric(vertical: 9),
                          ),
                          value: sectorList.isEmpty ? sector
                              : sectorHelper.getSector(demand.sectorId, sectorList),
                          iconSize: 24,
                          elevation: 16,
                          validator: (value) {
                            if (value == null) {
                              return 'required fields';
                            }
                            return null;
                          },
                          onChanged: (Sector valueSelectedByUser) {
                            sector = valueSelectedByUser;
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              demand.sectorId = valueSelectedByUser.id;
                            });
                          },
                          items: sectorList
                              .map((sec) =>
                              DropdownMenuItem<Sector>(
                                child: sec.Name != null ? 
                                Text(sec.Name) : Text(''),
                                value: sec,
                              ))
                              .toList(),
                        ),
                      ),

                      //Seventh Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: showButton ? TextFormField(
                          readOnly: showButton,
                          controller: natureProjectController,
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return 'required fields';
                            }
                            return null;
                          },
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onChanged: (value) {

                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).getTranslated('project nature') + ' *',
                              labelStyle: TextStyle(fontSize: 18)
                          ),
                        )
                            : DropdownButtonFormField<NatureProject>(
                          //isExpanded: true,
                          decoration: InputDecoration(
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: AppLocalizations.of(context).getTranslated('project nature') + ' *',
                            labelStyle: TextStyle(fontSize: 18),
                            contentPadding: EdgeInsets.symmetric(vertical: 9),
                          ),
                          value: natureProjectList.isEmpty ? natureProject
                              : natureProjectHelper.getNatureProject(demand.natureProjectId, natureProjectList),
                          iconSize: 24,
                          elevation: 16,
                          validator: (value) {
                            if (value == null) {
                              return 'required fields';
                            }
                            return null;
                          },
                          onChanged: (NatureProject valueSelectedByUser) {
                            natureProject = valueSelectedByUser;
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              demand.natureProjectId = valueSelectedByUser.id;
                            });
                          },
                          items: natureProjectList
                              .map((naturePro) =>
                              DropdownMenuItem<NatureProject>(
                                child: naturePro.Name != null?
                                Text(naturePro.Name) : Text(''),
                                value: naturePro,
                              ))
                              .toList(),
                        ),
                      ),
                    ],
                  ))),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the code of Demand object
  void updateCode() {
    demand.code = codeController.text;
  }

// Update the designation of Demand object
  void updateDesignation() {
    demand.designation = designationController.text;
  }

// Update the description of Demand object
  void updateDescription() {
    demand.description = descriptionController.text;
  }

  // Update the beneficiary of Demand object
  void updateBeneficiary() {
    demand.beneficiaryId = DelayPay.idBeneficiary;
  }

  // Save data to database
  void _save() async {
    // moveToLastScreen();

    demand.userId_ = userLoginId;
    goToDemandsPage(context, signOut, user, demand,
        appBarTitle, natureDe, natureProject,
        sector, DelayPay, userLoginId, status4);

    int result;
    if (demand.id != null) {
      // Case 1: Update operation
      result = await helper.updateDemand(demand);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertDemand(demand);
    }
    if (result != 0) {
      // Success
      _showAlertDialog(AppLocalizations.of(context).getTranslated('alertStatus'), AppLocalizations.of(context).getTranslated('saveMessageSuccessful'));
    } else {
      // Failure
      _showAlertDialog(AppLocalizations.of(context).getTranslated('alertStatus'), AppLocalizations.of(context).getTranslated('saveMessageError'));
    }
  }

  void _delete() async {
    //moveToLastScreen();
    //navigateToDemands();

    // Case 1: If user is trying to delete the NEW Demand i.e. he has come to
    // the detail page by pressing the icon of NoteList page.
    if (demand.id == null) {
      _showAlertDialog(AppLocalizations.of(context).getTranslated('alertStatus'), AppLocalizations.of(context).getTranslated('noDeletedDemandError'));
      //showAlert(context);
      return;
    }

    // Case 2: User is trying to delete the old demand that already has a valid ID.
    int result;
    if (result != 0) {
      result = await helper.deleteDemand(demand.id);
      _showAlertDialog(AppLocalizations.of(context).getTranslated('alertStatus'), AppLocalizations.of(context).getTranslated('deleteMessageSuccessful'));
      //showAlert(context);
    } else {
      _showAlertDialog(AppLocalizations.of(context).getTranslated('alertStatus'), AppLocalizations.of(context).getTranslated('deleteMessageError'));
      //showAlert(context);
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _showAlertToDelete(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).getTranslated('yes')),
          onPressed: () {

            _delete();
            goToDemandsPage(context, signOut, user, demand,
                appBarTitle, natureDe, natureProject,
                sector, DelayPay, userLoginId, status4);
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).getTranslated('cancel')),
          onPressed: () {
            goToDemandsPage(context, signOut, user, demand,
                appBarTitle, natureDe, natureProject,
                sector, DelayPay, userLoginId, status4);
          },
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}