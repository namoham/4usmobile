import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/companies.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:mobile4us_new_version/service/api.dart';
import 'package:mobile4us_new_version/dao/app_helpers/parameters_helper.dart';

class InstitutionsPage extends StatefulWidget {

  bool status4;

  InstitutionsPage(this.status4);

  @override
  _InstitutionsPageState createState() => new _InstitutionsPageState(this.status4);
}

enum SingingCharacter { lafayette, jefferson }

class _InstitutionsPageState extends State<InstitutionsPage> {

  bool status4;
  List<Company> compaanies;
  int length = 0;

  @override
  void initState() {

    super.initState();

    getCompaniesList();
  }

  _InstitutionsPageState(this.status4);

  String _character;
  Parameters parameters;

  @override
  Widget build(BuildContext context) {

    if (compaanies == null) {
      //compaanies = List<Company>();
      updateListView();
    }

    return WillPopScope(
            onWillPop: () {
              SystemNavigator.pop();
              return Future.value(true);
            },
            child: Scaffold(
              body: new Container(
                child: new Center(
                  child:
                  ListView(
                    padding: EdgeInsets.all(20.0),
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(20.0),
                      ),
                      App4usImageAsset(),
                      Container(
                        height: 50,
                      ),
                      length >0 ?
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(compaanies[0].name),
                              leading: Radio(
                                value: compaanies[0].link,
                                groupValue: _character,
                                onChanged: (value) {
                                  setState(() {
                                    _character = compaanies[0].link;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text(compaanies[1].name),
                              leading: Radio(
                                value: compaanies[1].link,
                                groupValue: _character,
                                onChanged: (value) {
                                  setState(() {
                                    _character = compaanies[1].link;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                      : Card(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("test"),
                              leading: Radio(
                                value: "test",
                                groupValue: "test",
                                onChanged: (value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              // ignore: deprecated_member_use
                              child: new RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                onPressed: () {
                                  insertLinks();
                                  },
                                child: new Text(
                                  AppLocalizations.of(context)
                                      .getTranslated('validate'),
                                  textScaleFactor: 1.1,
                                  style: Theme.of(context).textTheme.button,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
    }

  void updateListView() {
    Future<List<Company>> listFuture = getCompaniesList();
    listFuture.then((list) {
      setState(() {
        compaanies = list;
        length = compaanies.length;
      });
    });
  }

  void insertLinks() async{
    if (parameters != null){

    } else {
      parameters = await helperParameter.getParameterByKey('link');

      parameters.value = _character;
    }
    await ParameterHelper().updateParameter(parameters);

    goToLoginPage(context, status4);

  }

}

class App4usImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/logo.png');
    Image image = Image(
      image: assetImage,
      width: 200.0,
      height: 200.0,
    );
    return Container(
      child: image,
    );
  }
}
