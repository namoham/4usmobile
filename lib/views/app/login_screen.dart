import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile4us_new_version/dao/app_helpers/user_helper.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/apiModels/api_error.dart';
import 'package:mobile4us_new_version/models/apiModels/api_response.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/service/api.dart';
import 'package:mobile4us_new_version/service/response/login_response.dart';
import 'package:mobile4us_new_version/views/home/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  bool status4;

  LoginPage(this.status4);

  @override
  _LoginPageState createState() => new _LoginPageState(this.status4);
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  bool _isLoading = false;

  int userLoginId;
  bool status4;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;
  bool _passwordVisible;
  final teUsername = TextEditingController();
  final tePassword = TextEditingController();

  FocusNode _focusNodeUsername = new FocusNode();
  FocusNode _focusNodePass = new FocusNode();

  LoginResponse _response;

  ApiResponse _apiResponse = new ApiResponse();
  List<Demand> demandList;
  UserHelper helper = new UserHelper();
  User user;

  _LoginPageState(this.status4) {
    _response = new LoginResponse(this);
  }

  void _submit() {
    _focusNodePass.requestFocus();
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String username, pass;
    username = preferences.getString("user");
    pass = preferences.getString("pass");

    user = await helper.getLogin(username, pass);
    userLoginId = user != null ? user.id : null;
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    getPref();
  }

  @override
  void dispose() {
    teUsername.dispose();
    tePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
        var loginBtn = Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            //Theme.of(context).buttonTheme.shape,
            onPressed: _submit,
            child: new Text(
              AppLocalizations.of(context).getTranslated('login'),
              textScaleFactor: 1.1,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
        var importDbBtn = Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            //Theme.of(context).buttonTheme.shape,
            onPressed: () {
              debugPrint('button clicked');
              _pickFile();
            },
            child: new Text(
              AppLocalizations.of(context).getTranslated('importDatabase'),
              textScaleFactor: 1.1,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        );
        var loginForm = new ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            App4usImageAsset(),
            Container(
              height: 50,
            ),
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(20),
                    child: new TextFormField(
                      focusNode: _focusNodeUsername,
                      onSaved: (val) => _username = val,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)
                              .getTranslated('required');
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.headline5,
                      decoration: new InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: AppLocalizations.of(context)
                            .getTranslated('username'),
                        labelStyle: Theme.of(context).textTheme.headline5,
                        hintText: AppLocalizations.of(context)
                            .getTranslated('hintUsername'),
                        hintStyle: TextStyle(fontSize: 14),
                        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new TextFormField(
                      focusNode: _focusNodePass,
                      onSaved: (val) => _password = val,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)
                              .getTranslated('required');
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.headline5,
                      obscureText: !_passwordVisible,
                      decoration: new InputDecoration(
                        icon: Icon(Icons.lock_outline),
                        labelText: AppLocalizations.of(context)
                            .getTranslated('password'),
                        labelStyle: Theme.of(context).textTheme.headline5,
                        hintText: AppLocalizations.of(context)
                            .getTranslated('hintPassword'),
                        hintStyle: TextStyle(fontSize: 14),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,

                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: loginBtn,
                ),
                Container(
                  width: 20,
                ),
                Expanded(
                  child: importDbBtn,
                ),
              ],
            ),
          ],
        );

        return WillPopScope(
            onWillPop: () {
              SystemNavigator.pop();
              return Future.value(true);
            },
            child: Scaffold(
              key: scaffoldKey,
              body: new Container(
                child: new Center(
                  child: loginForm,
                ),
              ),
            ));
        break;

      case LoginStatus.signIn:

        return HomeScreen(signOut, userLoginId, status4);
        break;
    }
  }

  void _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
      print(file.path);
      Directory AppDoc = await getApplicationDocumentsDirectory();
      String path = AppDoc.path;
      print(path);
      var res;
      res = await file.copy("$path/data_4us.db");
      if (result != null) {
        _showSnackBar(AppLocalizations.of(context)
            .getTranslated('DatabaseImported'));
      } else {
        _showSnackBar(AppLocalizations.of(context)
            .getTranslated('DatabaseImportFail'));
      }
    } else {
      // User canceled the picker
    }
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      savePref(1, user.login, user.password);
      userLoginId = user.id;
      if (user.authorizationCode != null) {
        _loginStatus = LoginStatus.signIn;
      } else {
        _apiResponse = await authenticateUser(_username, _password);
        if ((_apiResponse.ApiError as ApiError) == null) {
          _saveAndRedirectToHome();
        } else {
          _showSnackBar((_apiResponse.ApiError as ApiError).error);
        }
      }
    } else {
      _showSnackBar(
          AppLocalizations.of(context).getTranslated('loginFailedMessage'));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", (_apiResponse.Data as User).id.toString());
    if ((_apiResponse.Data as User).id != null) {
      await helper.updateUser((_apiResponse.Data as User));
      getBeneficiariesByResponsible((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getDemandsByResponsible((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getPaymentStateByResponsible((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getActivity((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getDelayLevel((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getFamilyResources((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getFamilySituations((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getGender((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getIdentities((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getLocalities((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getNationalities((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getNatureDemands((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getNatureProjects((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getOccupations((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getPovertyDegrees((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getProfessions((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getProvinces((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getRegions((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getSectors((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getStudyLevels((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
      getUserTypes((_apiResponse.Data as User).id,
          (_apiResponse.Data as User).authorizationCode);
    } else {
      print('error');
    }
    _loginStatus = LoginStatus.signIn;
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

