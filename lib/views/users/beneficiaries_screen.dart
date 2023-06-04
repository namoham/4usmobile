import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/dao/app_helpers/PaymentState_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/delayLevel_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/delayPayment_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/user_helper.dart';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/delayLevel.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/paymentState.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/utils/alertDialog.dart';
import 'package:mobile4us_new_version/utils/assets_path.dart';
import 'package:mobile4us_new_version/utils/hexColor.dart';
import 'package:mobile4us_new_version/views/demand/add_demand.dart';
import 'package:mobile4us_new_version/views/location/location_screen.dart';
import 'package:mobile4us_new_version/views/users/AddBeneficiary_screen.dart';
import 'beneficiaryDetail.dart';

class BeneficiariesScreen extends StatefulWidget {

  final VoidCallback signOut;
  final String appBarTitle;
  final User user;
  final DelayLevel;
  final Demand demand;
  int userLoginId;
  bool status4;


  final bool test;
  BeneficiariesScreen(this.signOut, this.appBarTitle, this.user, this.DelayLevel, this.test, this.demand, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return BeneficListState(this.signOut, this.appBarTitle, this.user, this.DelayLevel, this.test, this.demand, this.userLoginId, this.status4);
  }
}

class BeneficListState extends State<BeneficiariesScreen> {

  UserHelper helper = new UserHelper();
  PaymentStateHelper paymentHel = new PaymentStateHelper();
  DelayLevelHelper helDelay = new DelayLevelHelper();
  DelayPaymentHelper helDelayPayment = new DelayPaymentHelper();
  PaymentStateHelper helPayment = new PaymentStateHelper();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<DelayPayment> delayPaymentList;

  List<DelayPayment> userOnIdList = <DelayPayment>[];
  List<DelayPayment> userOnIdentityList = <DelayPayment>[];
  List<DelayLevel> delayList = <DelayLevel>[];

  int count = 0;

  String appBarTitle;
  User user;
  DelayLevel delayLevel;
  DelayPayment delayPayment;
  Payment payment;
  DelayPayment delev;
  Demand demand;

  VoidCallback signOut;
  bool test = false;
  int userLoginId;
  bool status4;

  String image;

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<DelayPayment> filteredNames = new List<DelayPayment>();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Beneficiaries',
      style: TextStyle(fontSize: 20.0));

  bool _canShowButton = true;

  BeneficListState(this.signOut, this.appBarTitle, this.user, this.delayLevel,
      this.test, this.demand, this.userLoginId, this.status4)
  {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = delayPaymentList;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {

    super.initState();

    helDelayPayment.getDelayPaymentList().then((userFromServer) {
      setState(() {
        delayPaymentList = userFromServer;
        filteredNames = delayPaymentList;
      });
    });
    _getDelayList();
  }

  void _getDelayList() async {
    final List<DelayLevel> _list = await helDelay.getDelayList();
    setState(() {
      delayList = _list;
    });
  }

  void _geList(int delayLevel) async {
    final List<DelayPayment> _listOnId = await helDelayPayment.gList(delayLevel);
    setState(() {
      userOnIdList = _listOnId;
      filteredNames = userOnIdList;
    });
  }


  void _userbyIdentityList(String identity) async {
    final List<DelayPayment> _listOnIdentity = await helDelayPayment.getuserbyIdentityList(identity);
    setState(() {
      userOnIdentityList = _listOnIdentity;
      filteredNames = userOnIdentityList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (delayPaymentList == null) {
      delayPaymentList = List<DelayPayment>();
      updateListView();
    }

    return WillPopScope(

        onWillPop: () {
          goToHomePage(context, signOut, userLoginId, status4);
          return Future.value(true);
        },

        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0), // here the desired height
                child: AppBar(
                  title: _appBarTitle,
                  actions: <Widget>[
                    _canShowButton
                        ? IconButton(
                      icon: Icon(Icons.search),
                      iconSize: 30.0,
                      onPressed: () {
                        _searchPressed();
                      },
                    ) : SizedBox(),
                    test ? SizedBox() :
                    IconButton(
                      onPressed: () {
                        user = User(null, null, null, null, null, null, null, null, null,
                            null, null, null, null, null, null, null, null, null, null, null,
                            null, null, null, null, null, null, null, null , null, null, null,
                            null, null, null, null, null, null, null, null,null,
                            null, null, null, null, null, null, null, null ,null ,null, null,
                            null, null, null, null, null, null, null,null, null, null,
                            null, null, null, null, null, null,null ,null, null, null, null,
                            null, null, null, null, null, null,null ,null, null, null, null, null,
                            null, null, null, null, null,null ,null, null, null, null, null, null,
                            null, null, null, null, null, null, null, null, null, null, null, null,
                            null, null, null, null, null);
                        navigateToAdd(user, 'Add Beneficiary');
                      },
                      icon: Icon(Icons.add),
                      iconSize: 30.0,
                    ) ,
                    test ? SizedBox() :
                    IconButton(
                      onPressed: () {
                        getToLocationPage(context, signOut,
                            userLoginId, status4);
                      },
                      icon: Icon(Icons.location_on),
                      iconSize: 30.0,
                    )
                  ],
                  leading: IconButton(
                    onPressed: () async {
                      goToHomePage(context, signOut, userLoginId, status4);
                    },
                    icon: Icon(Icons.people),
                    iconSize: 30.0,
                  ),
                )),
            body: new Center(child: getBeneficiaryListView())));
  }

  ListView getBeneficiaryListView() {
    TextStyle titleStyle = Theme
        .of(context)
        .textTheme
        .subtitle1;

    return ListView.builder(
      itemCount: delayPaymentList == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          // color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 20,
              child: filteredNames[position].photo != null ? CircleAvatar(backgroundImage: FileImage(File(filteredNames[position].photo)), radius: 200.0)
                  : Image.asset(AssetsPath.logo),
            ),
            title: filteredNames[position].Name != null ? Text(
              this.filteredNames[position].Name,
              style: titleStyle,
            ) : Text('test'),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.perm_identity,
                  color: Colors.blueGrey,
                  size: 15,
                ),
                Container(
                  width: 5,
                ),
                Expanded(
                    child: Text(
                      this.filteredNames[position].identity_ != null?
                      this.filteredNames[position].identity_ : '',
                      style: titleStyle,
                    )
                ),
                Container(
                  width: 10,
                ),
                Icon(
                  Icons.phone,
                  color: Colors.blueGrey,
                  size: 15,
                ),
                Container(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    this.filteredNames[position].telephone!=null?
                    this.filteredNames[position].telephone : '',
                    style: titleStyle,
                  ),
                ),
              ],
            ) ,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Opacity(
                  opacity: filteredNames[position].isSend != '1'
                      && filteredNames[position].synch != 1 ? 1 : 0,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (filteredNames[position].isSend != '1'
                          && filteredNames[position].synch != 1)
                      {
                        var dialog = CustomAlertDialog(
                            title: "",
                            message: AppLocalizations.of(context)
                                .getTranslated('sendBeneficiaryMessage'),
                            onPostivePressed: () async {
                              user = await helper.getId(filteredNames[position].idBeneficiary);
                              setState(() {
                                filteredNames[position].isSend = '1';
                                user.isSend = '1';
                                user.dateSend = DateTime.now().toString();
                              });
                              int result;
                              if (user.id != null) {
                                // Case 1: Update operation
                                result = await helper.updateUserwithId(user);
                              }
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
                  ),
                ),
                Icon(Icons.bookmark, color: HexColor(filteredNames[position].colorCode))
              ],
            ),
            onTap: () {
              if (test == true){
                navigateToDemand(user, this.filteredNames[position], 'Demands');
              } else{
                getDetails(this.filteredNames[position].idBeneficiary);}
            },
          ),
        );
      },
    );
  }

  Color delayColor(int userId)  {

    print(userId.toString());

    Color colorIcon = Colors.grey;

    helDelayPayment.getDelayPayment(userId).then((value) {
      setState(() {
        delayPayment = value;
      });
    });
    if(delayPayment != null) {

      colorIcon = HexColor(delayPayment.colorCode);

    }

    return colorIcon;
  }

  void _searchPressed() {

    _canShowButton = false;
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .getTranslated('hintSearch'),
                      fillColor: Colors.white,
                      filled: true),
                  controller: _filter,
                  onChanged: (string) {
                    setState(() {
                      _userbyIdentityList(string);
                    });
                  },
                  onTap: () {
                    setState(() {
                    });
                  },
                )),
            PopupMenuButton<DelayLevel>(
              onSelected: (DelayLevel value) {
                setState(() {
                  delayLevel = value;
                  _geList(value.id);
                });
              },
              itemBuilder: (context) =>
                  delayList
                      .map((project) =>
                      PopupMenuItem<DelayLevel>(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.bookmark,
                                color: HexColor(project.colorCode)),
                            Text(project.name),
                          ],
                        ),
                        value: project,
                      ))
                      .toList(),
            ),
          ],
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(AppLocalizations.of(context).getTranslated('beneficiariesHomeIcon'));
        filteredNames = delayPaymentList;
        _filter.clear();
      }
    });
  }

  void navigateToAdd(User user, String appBarTitle) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddBeneficiaryScreen(signOut, appBarTitle, user, userLoginId, status4);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void getDetails(int userId) async {
    payment = await helPayment.getUserId(userId);
    if (payment != null) {
      delayLevel = await helDelay.getId(payment.levelDelayPaymentId);
    }
    user = await helper.getId(userId);
    goToBeneficiaryDetailPage(context, signOut, user,
        delayLevel, payment, userLoginId, status4);
  }

  void navigateToDemand(User user, DelayPayment delayPayment, String appBarTitle) async {
    demand.beneficiaryId = delayPayment.idBeneficiary;
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddDemand(signOut, user, demand, appBarTitle, delayPayment, false, true, userLoginId, status4);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    Future<List<DelayPayment>> userListFuture = helDelayPayment.getDelayPaymentList();
    userListFuture.then((userList) {
      setState(() {
        this.delayPaymentList = userList;
        this.count = userList.length;
      });
    });
  }
}
