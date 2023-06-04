import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/dao/app_helpers/parameters_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/parameters.dart';

class ParameterPage extends StatefulWidget {

  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  ParameterPage(this.signOut, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return _ParameterPageState(this.signOut, this.userLoginId, this.status4);
  }
}


class _ParameterPageState extends State<ParameterPage> {


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  Parameters parameter;
  Parameters BaseParameter;

  ParameterHelper parameterHelper = new ParameterHelper();
  List<Parameters> parametersList = <Parameters>[];
  String value = "";

  void _getParametersList() async {
    final List<Parameters> list = await parameterHelper.getParameterList();
    setState(() {
      parametersList = list;
    });
  }

  void _getBaseUrlText() async {
    int id =1;
    final Parameters text = await parameterHelper.getParameterById(id);
    setState(() {
      BaseParameter = text;
      value = BaseParameter.value;
    });
  }

  TextEditingController valueController = TextEditingController();

  TextEditingController baseValueController = TextEditingController();

  _ParameterPageState(this.signOut, this.userLoginId, this.status4);

  @override
  void initState() {
    super.initState();
    _getParametersList();
    _getBaseUrlText();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .bodyText1;

    baseValueController.text = value;
    print('user login id is : ' + userLoginId.toString());

    return WillPopScope(

        onWillPop: () {
          goToAppSettingsPage(context, signOut, userLoginId, status4);
          return Future.value(true);
        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context)
                    .getTranslated('Parameters')),
          ),
          body: Form(
              key: formKey,
              child: Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                  child: ListView(
                    children: <Widget>[
                      //First Element
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: DropdownButtonFormField<Parameters>(
                          //isExpanded: true,
                          decoration: InputDecoration(
                            isDense: true,
                            hasFloatingPlaceholder: true,
                            labelText: AppLocalizations.of(context)
                                .getTranslated('Key'),
                            labelStyle: TextStyle(fontSize: 18),
                            contentPadding: EdgeInsets.symmetric(vertical: 9),
                          ),
                          value: parameter,
                          iconSize: 24,
                          elevation: 16,
                          validator: (value) {
                            if (value == null) {
                              return 'required fields';
                            }
                            return null;
                          },
                          onChanged: (Parameters valueSelectedByUser) {
                            parameter = valueSelectedByUser;
                            setState(() {
                              debugPrint('User selected $valueSelectedByUser');
                              parameter.key = valueSelectedByUser.key;
                            });
                          },
                          items: parametersList
                              .map((parameter) =>
                              DropdownMenuItem<Parameters>(
                                child: parameter.key != null?
                                Text(parameter.key) : Text(''),
                                value: parameter,
                              ))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: ListTile(
                          title: TextFormField(
                            readOnly: true,
                            controller: baseValueController,
                            style: textStyle,
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              debugPrint('Something changed in value Text Field');
                              parameter.value = baseValueController.text;
                            },
                            decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .getTranslated('BaseUrl'),
                                labelStyle: TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          controller: valueController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'required fields';
                            }
                            return null;
                          },
                          style: textStyle,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            debugPrint('Something changed in value Text Field');
                            parameter.value = valueController.text;
                          },
                          decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)
                                  .getTranslated('Value'),
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, right: 20.0, left: 20.0),
                        child: RaisedButton(
                          onPressed: () {
                            debugPrint('icon clicked');
                            setState(() {
                              if (formKey.currentState.validate()) {
                                _save();
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff374ABE),
                                    Color(0xff64B6FF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius:
                                BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 250.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)
                                    .getTranslated('Save'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ));
  }
  void _save() async {

    goToAppSettingsPage(context, signOut, userLoginId, status4);
    int result;
    result = await parameterHelper.updateParameter(parameter);
    if (result != 0) {
      // Success
      _showAlertDialog(AppLocalizations.of(context)
          .getTranslated('Status'), AppLocalizations.of(context)
          .getTranslated('SuccessSaveParameter'));
    } else {
      // Failure
      _showAlertDialog(AppLocalizations.of(context)
          .getTranslated('Status'), AppLocalizations.of(context)
          .getTranslated('FailSaveParameter'));
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
}