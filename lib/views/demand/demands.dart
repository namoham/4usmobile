import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/dao/app_helpers/delayPayment_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/demandList_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/demand_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/natureDemand_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/natureProject_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/sector_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/user_helper.dart';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:mobile4us_new_version/models/demandList.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/utils/alertDialog.dart';
import 'package:mobile4us_new_version/utils/assets_path.dart';
import 'package:mobile4us_new_version/views/demand/add_demand.dart';
import 'package:mobile4us_new_version/views/home/home_page.dart';
import 'demandDetail.dart';

class DemandList extends StatefulWidget {
  final VoidCallback signOut;
  final int userLoginId;
  bool status4;

  final String appBarTitle;
  final Demand demand;
  final User user;
  final NatureDemand natureDemand;
  final NatureProject natureProject;
  final Sector sector;
  final DelayPayment DelayPay;

  DemandList(this.signOut, this.user, this.demand, this.appBarTitle, this.natureDemand, this.natureProject, this.sector, this.DelayPay, this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return DemandListState(
        this.signOut,
        this.user,
        this.demand,
        this.appBarTitle,
        this.natureDemand,
        this.natureProject,
        this.sector,
        this.DelayPay,
        this.userLoginId,
        this.status4);
  }
}

class DemandListState extends State<DemandList> {
  DemandHelper helper = new DemandHelper();
  UserHelper userHelper = new UserHelper();
  NatureDemandHelper natureHelper = new NatureDemandHelper();
  SectorHelper sectorHelper = new SectorHelper();
  NatureProjectHelper natureProHelper = new NatureProjectHelper();
  DemandListHelper listHelper = new DemandListHelper();

  DelayPaymentHelper delayHelper = new DelayPaymentHelper();
  DatabaseHelper databaseHelper = new DatabaseHelper();
  List<DeList> demandList;
  int count = 0;
  User user;
  NatureDemand natureDemand;
  NatureProject natureProject;
  Sector sector;
  String appBarTitle;
  Demand demand;
  DelayPayment delayPayment;
  DeList demList;
  VoidCallback signOut;
  int userLoginId;
  bool status4;

  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<DeList> filteredNames = new List<DeList>();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Demands',
    style: TextStyle(fontSize: 20.0),
  );
  bool _canShowButton = true;

  DemandListState(this.signOut, this.user, this.demand, this.appBarTitle,
      this.natureDemand, this.natureProject, this.sector, this.delayPayment, this.userLoginId, this.status4) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = demandList;
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
    listHelper.getDemandList().then((demandFromServer) {
      setState(() {
        demandList = demandFromServer;
        filteredNames = demandList;
      });
    });
  }

  void _getUser(id) async {
    userHelper.getId(id).then((user2) {
      setState(() {
        this.user = user2;
      });
    });
  }

  void _getuser1(id) async {
    final User list = await userHelper.getId(id);
    setState(() {
      user = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (demandList == null) {
      demandList = List<DeList>();
      updateListView();
    }

    return WillPopScope(
        onWillPop: () {
          goToHomePage(context, signOut, userLoginId, status4);
          return Future.value(true);
        },
        child: new Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: _appBarTitle,
            actions: <Widget>[
              _canShowButton
                  ? IconButton(
                      icon: Icon(Icons.search),
                      iconSize: 30.0,
                      onPressed: () {
                        debugPrint('icon clicked');
                        _searchPressed();
                      },
                    )
                  : SizedBox(),
              IconButton(
                onPressed: () {
                  debugPrint('icon clicked');
                  navigateToAdd();
                },
                icon: Icon(Icons.add),
                iconSize: 30.0,
              )
            ],
            leading: IconButton(
              onPressed: () async {
                goToHomePage(context, signOut, userLoginId, status4);
              },
              icon: Icon(Icons.home),
              iconSize: 30.0,
            ),
          ),
          body: getDemandListView(),
          resizeToAvoidBottomInset: false,
        ));
  }

  ListView getDemandListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: demandList == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          //color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 20,
              child: Image.asset(AssetsPath.logo),
            ),
            title: Text(
              this.filteredNames[position].designation,
              style: titleStyle,
            ),
            subtitle: Text(
              'Beneficiary: ' + filteredNames[position].Name,
              style: titleStyle,
            ),
            trailing: Opacity(
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
                                .getTranslated('sendDemandMessage'),
                            onPostivePressed: () async {
                              demand = await helper.getId(filteredNames[position].idDemand);
                              setState(() {
                                filteredNames[position].isSend = '1';
                                demand.isSend = '1';
                                demand.dateSend = DateTime.now().toString();
                              });
                              int result;
                              if (demand.id != null) {
                                // Case 1: Update operation
                                result = await helper.updateDemand(demand);
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
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToEdit(
                  filteredNames[position].idBeneficiary,
                  filteredNames[position].idDemand,
                  filteredNames[position].sectorId,
                  filteredNames[position].natureRequestId,
                  filteredNames[position].natureProjectId);
            },
          ),
        );
      },
    );
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
                hintText:
                    AppLocalizations.of(context).getTranslated('hintSearch'),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () => _filter.clear(),
                  icon: Icon(Icons.clear),
                ),
                prefixIcon: new Icon(Icons.search, color: Colors.indigo),
              ),
              controller: _filter,
              onChanged: (string) {
                setState(() {
                  filteredNames = demandList
                      .where((d) => d.designation
                          .toLowerCase()
                          .contains(string.toLowerCase()))
                      .toList();
                });
              },
              onTap: () {
                setState(() {});
              },
            )),
          ],
        );
      } else {
        this._appBarTitle = new Text(
            AppLocalizations.of(context).getTranslated('demandsHomeIcon'));
        filteredNames = demandList;
        _filter.clear();
      }
    });
  }

  void navigateToAdd() async {
    demand = Demand('',
        '', '', 0, 0, 0, 0, 0, 0,'', 0, 0, '', 0, '', 0, 0, 0);
    user = User(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, '', '', '', '', '', '', '','','','','','','','', '', '', '',
        '', '','','','','','','','','', '', '', '','','','','','','','', '', '', '', '',
        '','','', '','','','','','', '', '', '','','','','','','','', '', '', '', '', '',
        '','','','','','','','', '', '', '', '', '','','','','','', '', '');
    delayPayment = DelayPayment('', '',
        '', '', '', '', '', '');

    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddDemand(signOut, user, demand, '', delayPayment, false, true, userLoginId, status4);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    Future<List<DeList>> demandListFuture = listHelper.getDemandList();
    demandListFuture.then((demandList) {
      setState(() {
        this.demandList = demandList;
        this.count = demandList.length;
      });
    });
  }

  void navigateToEdit(int userId, int demandId, int sectorId, int natureDeId,
      int naturePrId) async {

    bool showButton = true;
    bool showsaveButton = false;
    user = await userHelper.getId(userId);
    delayPayment = await delayHelper.getDelayPayment(userId);
    demand = await helper.getId(demandId);
    goToAddDemandPage(context, signOut, user, demand, 'add',
        delayPayment, showButton, showsaveButton,
        userLoginId, status4);
  }
}
