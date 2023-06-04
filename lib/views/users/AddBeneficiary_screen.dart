import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile4us_new_version/dao/app_helpers/activity_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/familyResources_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/familySituation_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/gender_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/identity_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/locality_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/nationality_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/occupation_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/povertyDegree_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/profession_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/province_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/region_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/studyLevel_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/userType_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/user_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/activity.dart';
import 'package:mobile4us_new_version/models/familyResources.dart';
import 'package:mobile4us_new_version/models/familySituation.dart';
import 'package:mobile4us_new_version/models/gender.dart';
import 'package:mobile4us_new_version/models/identity.dart';
import 'package:mobile4us_new_version/models/locality.dart';
import 'package:mobile4us_new_version/models/nationality.dart';
import 'package:mobile4us_new_version/models/occupation.dart';
import 'package:mobile4us_new_version/models/povertyDegree.dart';
import 'package:mobile4us_new_version/models/profession.dart';
import 'package:mobile4us_new_version/models/province.dart';
import 'package:mobile4us_new_version/models/region.dart';
import 'package:mobile4us_new_version/models/studyLevel.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/models/userType.dart';
import 'package:mobile4us_new_version/utils/assets_path.dart';
import 'package:mobile4us_new_version/views/location/selectBusinessLocation.dart';
import 'package:mobile4us_new_version/views/location/select_location_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:preload_page_view/preload_page_view.dart';
import 'beneficiaries_screen.dart';
import 'package:email_validator/email_validator.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  final VoidCallback signOut;
  int userLoginId;
  bool status4;

  final String appBarTitle;
  final User user;

  AddBeneficiaryScreen(this.signOut, this.appBarTitle, this.user,
      this.userLoginId, this.status4);

  @override
  State<StatefulWidget> createState() {
    return AddState(this.signOut, this.user, this.appBarTitle, this.userLoginId,
        this.status4);
  }
}

class AddState extends State<AddBeneficiaryScreen> with SingleTickerProviderStateMixin{
  VoidCallback signOut;
  int userLoginId;
  bool status4;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;
  PreloadPageController _pageController = PreloadPageController(
      initialPage: 0, keepPage: true, viewportFraction: 0.99);
  bool _canChange = true;
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  UserHelper helper = new UserHelper();
  String appBarTitle;
  User user;

  DateTime date;
  File imFile;

  UserTypeHelper helType = new UserTypeHelper();
  GenderHelper helGender = new GenderHelper();
  NationalityHelper helNation = new NationalityHelper();
  ActivityHelper helActivity = new ActivityHelper();
  IdentityHelper helIdType = new IdentityHelper();
  RegionHelper helRegion = new RegionHelper();
  ProvinceHelper helProvince = new ProvinceHelper();
  LocalityHelper helLocality = new LocalityHelper();
  StudyHelper helStudy = new StudyHelper();
  PovertyHelper helPoverty = new PovertyHelper();
  ProfessionHelper helProfession = new ProfessionHelper();
  OccupationHelper helOccupation = new OccupationHelper();
  FamilySituationHelper helFamily = new FamilySituationHelper();
  FamilyResourcesHelper halFamResource = new FamilyResourcesHelper();

  UserType userType;
  Gender gender;
  Nationality nationality;
  Activity activity;
  Identity identity;
  Region region;
  Region bRegion;
  Province province;
  Province bProvince;
  Locality locality;
  Locality bLocality;
  StudyLevel studyLevel;
  PovertyDegree povertyDegree;
  Profession profession;
  Occupation occupation;
  FamilySituation familySituation;
  FamilyResources familyResources;

  List<UserType> typeList = <UserType>[];
  List<Gender> genderList = <Gender>[];
  List<Nationality> nationList = <Nationality>[];
  List<Activity> activityList = <Activity>[];
  List<Identity> identityList = <Identity>[];
  List<Region> regionList = <Region>[];
  List<Region> bRegionList = <Region>[];
  List<Province> provinceList = <Province>[];
  List<Locality> localityList = <Locality>[];
  List<Province> bProvinceList = <Province>[];
  List<Locality> bLocalityList = <Locality>[];
  List<StudyLevel> studyList = <StudyLevel>[];
  List<PovertyDegree> povertyList = <PovertyDegree>[];
  List<Profession> professionList = <Profession>[];
  List<Occupation> occupationList = <Occupation>[];
  List<FamilySituation> familyList = <FamilySituation>[];
  List<FamilyResources> famResourceList = <FamilyResources>[];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        changePage(_tabController.index, page: true);
      }
    });
    super.initState();

    _getTypeList();
    _getGenderList();
    _getNationalityList();
    _getActivityList();
    _getIdentityList();
    _getRegionList();
    _provList(user.regionAdresse);
    _locaList(user.provinceAddress);
    _getBregionList();
    _BprovList(user.regionBusinessAddress);
    _BlocaList(user.provinceBusinessAddress);
    _getStudyList();
    _getPovertyList();
    _getProfessionList();
    _getOccupationList();
    _getFamilySituationList();
    _getFamilyResourcesList();

  }

  void _submit() {
    if (_formKey.currentState.validate()) {
      _save();
    }
    else if (!_formKey.currentState.validate()) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
              content: Text("${hintList.join(", ")} " + AppLocalizations
                  .of(context).getTranslated('fieldsEmpty'))
              //Text("Please resolve given errors")
          ));
      return;
    }
    _formKey.currentState.save();
  }

  void changePage(index, {page = false, tab = false}) async {
    if (page) {
      _canChange = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      _canChange = true;
    } else {
      _tabController.animateTo(index);
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController thirdNameController = TextEditingController();
  TextEditingController fourthNameController = TextEditingController();
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController arabicBirthPlaceController = TextEditingController();
  TextEditingController informationController = TextEditingController();
  TextEditingController bankaccountController = TextEditingController();
  TextEditingController legacyController = TextEditingController();
  TextEditingController numberChildrenChargeController =
  TextEditingController();
  TextEditingController numberChildrenSchoolersController =
  TextEditingController();
  TextEditingController spouseactivityController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  TextEditingController deliverydateController = TextEditingController();
  TextEditingController deliveryplaceController = TextEditingController();
  TextEditingController deliveryplaceDLController = TextEditingController();
  TextEditingController dateEndValidityController = TextEditingController();
  TextEditingController additionalAdresseController = TextEditingController();
  TextEditingController arabicAdditionalAddressController =
  TextEditingController();
  TextEditingController mapsAddressController = TextEditingController();
  TextEditingController additionalBusinessAddressController =
  TextEditingController();
  TextEditingController arabicAdditionalBusinessAddressController =
  TextEditingController();
  TextEditingController mapsCordsBusinessAddressController =
  TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController telephoneTwoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController monthly_incomeController = TextEditingController();
  TextEditingController AverageIndividualExpensePerDayController = TextEditingController();
  TextEditingController blackListDateController = TextEditingController();
  TextEditingController ExternalFundingController = TextEditingController();

  AddState(this.signOut, this.user, this.appBarTitle, this.userLoginId,
      this.status4);

  String dropdownOfficeValue = '';
  String dropdownRiskValue = '';

  File _imageFile;
  Image image;

  bool showSaveIcon;

  List<String> hintList = [];

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    firstNameController.text = user.firstName;
    secondNameController.text = user.middleName;
    thirdNameController.text = user.thirdName;
    fourthNameController.text = user.fourthName;
    arabicNameController.text = user.NameDL;
    birthDateController.text = user.Birth_Date;
    birthPlaceController.text = user.Birth_Place;
    arabicBirthPlaceController.text = user.BirthplaceDL;
    informationController.text = user.information;
    bankaccountController.text = user.Bank_account;
    legacyController.text = user.legacy;
    numberChildrenChargeController.text = user.numberChildrenCharge;
    numberChildrenSchoolersController.text = user.numberChildrenSchoolers;
    spouseactivityController.text = user.Spouse_activity;
    identityController.text = user.identity_;
    deliverydateController.text = user.Delivery_date;
    deliveryplaceController.text = user.Delivery_place;
    deliveryplaceDLController.text = user.placeDeliveryDL;
    dateEndValidityController.text = user.dateEndValidity;
    additionalAdresseController.text = user.additionalAdresse;
    arabicAdditionalAddressController.text = user.additionalDLAddress;
    mapsAddressController.text = user.mapsAddress;
    additionalBusinessAddressController.text = user.additionalBusinessAddress;
    arabicAdditionalBusinessAddressController.text =
        user.additionalDLBusinessAddress;
    mapsCordsBusinessAddressController.text = user.mapsCordsBusinessAddress;
    telephoneController.text = user.telephone;
    telephoneTwoController.text = user.telephoneTwo;
    emailController.text = user.email;
    faxController.text = user.fax;
    monthly_incomeController.text = user.monthly_income;
    AverageIndividualExpensePerDayController.text =
        user.AverageIndividualExpensePerDay;
    blackListDateController.text = user.blackListDate;
    ExternalFundingController.text = user.External_funding;
    user.photo != null ? _imageFile = File(user.photo) : _imageFile == null;
    user.state_ == 1 || user.state_ == null
        ? showSaveIcon = true
        : showSaveIcon = false;
    user.synch == 0 || user.synch == null
        ? showSaveIcon = true
        : showSaveIcon = false;
    return WillPopScope(
        onWillPop: () {
          goToBeneficiariesPage(context, signOut,
              appBarTitle, user, false,
              null, userLoginId, status4);
          return Future.value(true);
        },
        child: DefaultTabController(
            length: 4,
            child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  bottom: TabBar(
                    labelColor: Colors.white,
                    controller: _tabController,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: AppLocalizations.of(context)
                            .getTranslated('profile'),
                      ),
                      Tab(
                          text: AppLocalizations.of(context)
                              .getTranslated('identity')),
                      Tab(
                          text: AppLocalizations.of(context)
                              .getTranslated('contact')),
                      Tab(
                          text: AppLocalizations.of(context)
                              .getTranslated('other')),
                    ],
                  ),
                  title: Text(AppLocalizations.of(context)
                      .getTranslated('beneficiary')),
                  actions: <Widget>[
                    showSaveIcon
                        ? IconButton(
                      onPressed: () {
                        debugPrint('icon clicked');
                        _submit();
                      },
                      icon: Icon(Icons.save),
                    )
                        : SizedBox(),
                  ],
                ),
                body: Form(
                  key: _formKey,
                  autovalidate: true,
                  child: PreloadPageView(
                    preloadPagesCount: 5,
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) {
                      if (_canChange) {
                        changePage(index);
                      }
                    },
                    children: [
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    // First element
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0,
                                            bottom: 15.0,
                                            left: 80.0,
                                            right: 80.0),
                                        child: FlatButton(
                                          onPressed: () {
                                            debugPrint('icon clicked');
                                            captureImage(ImageSource.camera);
                                          },
                                          padding: EdgeInsets.all(0.0),
                                          child: _buildImage(),
                                        )),

                                    // Second Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: DropdownButtonFormField<UserType>(
                                        decoration: InputDecoration(
                                          isDense: true,
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                          labelText: AppLocalizations.of(context)
                                              .getTranslated('actorType'),
                                          labelStyle: TextStyle(fontSize: 16),
                                          contentPadding:
                                          EdgeInsets.symmetric(vertical: 9),
                                        ),
                                        value: typeList.isEmpty
                                            ? userType
                                            : helType.getType(
                                            user.typeActorId, typeList),
                                        iconSize: 24,
                                        elevation: 16,
                                        validator: (value) {
                                          if (value == null) {
                                            if(!hintList.contains(AppLocalizations.of(context)
                                                .getTranslated('actorType'))){
                                              hintList.add(AppLocalizations.of(context)
                                                  .getTranslated('actorType'));
                                            }
                                            return AppLocalizations.of(
                                                context)
                                                .getTranslated(
                                                'required Field');
                                          }
                                          if (hintList.contains(AppLocalizations.of(context)
                                              .getTranslated('actorType'))) {
                                            hintList.removeWhere((element) =>
                                            element == AppLocalizations.of(context)
                                                .getTranslated('actorType'));
                                          }
                                          return null;
                                        },
                                        onChanged: (UserType value) {
                                          userType = value;
                                          setState(() {
                                            debugPrint('User selected $value');
                                            user.typeActorId = value.id;
                                          });
                                        },
                                        items: typeList
                                            .map((project) =>
                                            DropdownMenuItem<UserType>(
                                              child: project.Name != null?
                                              Text(project.Name)
                                              :Text(''),
                                              value: project,
                                            ))
                                            .toList(),
                                      ),
                                    ),

                                    // Third Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  labelText:
                                                  AppLocalizations.of(context)
                                                      .getTranslated('firstName'),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                              controller: firstNameController,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  if(!hintList.contains(
                                                      AppLocalizations.of(context)
                                                          .getTranslated('firstName')))
                                                  {
                                                    hintList.add(
                                                        AppLocalizations.of(context)
                                                        .getTranslated('firstName'));
                                                  }
                                                  return AppLocalizations.of(context)
                                                      .getTranslated('requiredField');
                                                }
                                                if (hintList.contains(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('firstName')
                                                )) {
                                                  hintList.removeWhere((element)
                                                  => element ==
                                                      AppLocalizations.of(context)
                                                          .getTranslated('firstName'));
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                user.firstName =
                                                    firstNameController.text;
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(
                                                        context)
                                                        .getTranslated('secondName'),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0))),
                                                controller: secondNameController,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    if(!hintList.contains(
                                                        AppLocalizations.of(context)
                                                            .getTranslated('secondName'))){
                                                      hintList.add(
                                                          AppLocalizations.of(context)
                                                              .getTranslated('secondName'));
                                                    }
                                                    return AppLocalizations.of(
                                                        context).getTranslated(
                                                        'requiredField');
                                                  }
                                                  if (hintList.contains(
                                                      AppLocalizations.of(context)
                                                          .getTranslated('secondName')
                                                  )) {
                                                    hintList.removeWhere((element)
                                                    => element ==
                                                        AppLocalizations.of(context)
                                                            .getTranslated('secondName'));
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  debugPrint(
                                                      'Something changed in Username Text Field');
                                                  user.middleName =
                                                      secondNameController.text;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Fourth Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(
                                                        context)
                                                        .getTranslated('thirdName'),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0))),
                                                controller: thirdNameController,
                                                onChanged: (value) {
                                                  debugPrint(
                                                      'Something changed in Username Text Field');
                                                  user.thirdName =
                                                      thirdNameController.text;
                                                }),
                                          ),
                                          Container(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                                decoration: InputDecoration(
                                                    labelText: AppLocalizations.of(
                                                        context)
                                                        .getTranslated('fourthName'),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0))),
                                                controller: fourthNameController,
                                                onChanged: (value) {
                                                  debugPrint(
                                                      'Something changed in Username Text Field');
                                                  user.fourthName =
                                                      fourthNameController.text;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Fifth Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('fullName'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          controller: arabicNameController,
                                          onChanged: (value) {
                                            debugPrint(
                                                'Something changed in Username Text Field');
                                            user.NameDL = arabicNameController.text;
                                          }),
                                    ),

                                    // 6th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: DropdownButtonFormField<Gender>(
                                              decoration: InputDecoration(
                                                isDense: true,
                                                floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                                labelText:
                                                AppLocalizations.of(context)
                                                    .getTranslated('gender'),
                                                labelStyle: TextStyle(fontSize: 16),
                                                contentPadding:
                                                EdgeInsets.symmetric(vertical: 9),
                                              ),
                                              value: genderList.isEmpty
                                                  ? gender
                                                  : helGender.getgender(
                                                  user.sexId, genderList),
                                              iconSize: 24,
                                              elevation: 16,
                                              validator: ( value) {
                                                if (value == null) {
                                                  if(!hintList.contains(
                                                      AppLocalizations.of(context)
                                                          .getTranslated('gender')
                                                  )){
                                                    hintList.add(
                                                        AppLocalizations.of(context)
                                                            .getTranslated('gender')
                                                    );
                                                  }
                                                  return AppLocalizations.of(
                                                      context)
                                                      .getTranslated(
                                                      'requiredField');
                                                }
                                                if (hintList.contains(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('gender')
                                                )) {
                                                  hintList.removeWhere((element)
                                                  => element ==
                                                      AppLocalizations.of(context)
                                                          .getTranslated('gender'));
                                                }
                                                return null;
                                              },
                                              onChanged: (Gender value) {
                                                gender = value;
                                                setState(() {
                                                  debugPrint('User selected $value');
                                                  user.sexId = value.id;
                                                });
                                              },
                                              items: genderList
                                                  .map((project) =>
                                                  DropdownMenuItem<Gender>(
                                                    child: project.Name != null?
                                                    Text(project.Name)
                                                    :Text(''),
                                                    value: project,
                                                  ))
                                                  .toList(),
                                            ),
                                          ),
                                          Container(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child:
                                            DropdownButtonFormField<Nationality>(
                                              decoration: InputDecoration(
                                                isDense: true,
                                                floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                                labelText:
                                                AppLocalizations.of(context)
                                                    .getTranslated('nationality'),
                                                labelStyle: TextStyle(fontSize: 16),
                                                contentPadding:
                                                EdgeInsets.symmetric(vertical: 9),
                                              ),
                                              value: nationList.isEmpty
                                                  ? nationality
                                                  : helNation.getNation(
                                                  user.nationalityId, nationList),
                                              iconSize: 24,
                                              elevation: 16,
                                              validator: ( value) {
                                                if (value == null) {
                                                  if(!hintList.contains(
                                                      AppLocalizations.of(context)
                                                          .getTranslated('nationality')
                                                  )){
                                                    hintList.add(
                                                        AppLocalizations.of(context)
                                                            .getTranslated('nationality')
                                                    );
                                                  }
                                                  return AppLocalizations.of(
                                                      context)
                                                      .getTranslated(
                                                      'requiredField');
                                                }
                                                if (hintList.contains(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('nationality')
                                                )) {
                                                  hintList.removeWhere((element)
                                                  => element ==
                                                      AppLocalizations.of(context)
                                                          .getTranslated('nationality'));
                                                }
                                                return null;
                                              },
                                              onChanged: (Nationality value) {
                                                nationality = value;
                                                setState(() {
                                                  debugPrint('User selected $value');
                                                  user.nationalityId = value.id;
                                                });
                                              },
                                              items: nationList
                                                  .map((project) =>
                                                  DropdownMenuItem<Nationality>(
                                                    child: project.Name != null?
                                                    Text(project.Name)
                                                    :Text(""),
                                                    value: project,
                                                  ))
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // 7th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              enableInteractiveSelection: false,
                                              decoration: InputDecoration(
                                                  labelText: AppLocalizations.of(
                                                      context)
                                                      .getTranslated('dateOfBirth'),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                              controller: birthDateController,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  if(!hintList.contains(
                                                      AppLocalizations.of(context)
                                                          .getTranslated('dateOfBirth')
                                                  )){
                                                    hintList.add(
                                                        AppLocalizations.of(context)
                                                            .getTranslated('dateOfBirth')
                                                    );
                                                  }
                                                  return AppLocalizations.of(context)
                                                      .getTranslated('requiredField');
                                                }
                                                if (hintList.contains(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('dateOfBirth'))) {
                                                  hintList.removeWhere((element)
                                                  => element ==
                                                      AppLocalizations.of(context)
                                                          .getTranslated('dateOfBirth'));
                                                }
                                                return null;
                                              },
                                              onTap: () async {
                                                FocusScope.of(context)
                                                    .requestFocus(new FocusNode());
                                                await _selectDate(context);
                                                birthDateController.text =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(date);
                                                user.Birth_Date =
                                                    birthDateController.text;
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                                decoration: InputDecoration(
                                                    labelText:
                                                    AppLocalizations.of(context)
                                                        .getTranslated(
                                                        'placeOfBirth'),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0))),
                                                controller: birthPlaceController,
                                                onChanged: (value) {
                                                  user.Birth_Place =
                                                      birthPlaceController.text;
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // 8th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'مكان الميلاد',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(5.0))),
                                        controller: arabicBirthPlaceController,
                                        onChanged: (value) {
                                          user.BirthplaceDL =
                                              arabicBirthPlaceController.text;
                                        },
                                      ),
                                    ),

                                    // 9th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('informations'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          controller: informationController,
                                          onChanged: (value) {
                                            user.information =
                                                informationController.text;
                                          }),
                                    ),

                                    // 10th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: DropdownButtonFormField<Activity>(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                          labelText: AppLocalizations.of(context)
                                              .getTranslated('activity'),
                                          labelStyle: TextStyle(fontSize: 16),
                                          contentPadding:
                                          EdgeInsets.symmetric(vertical: 9),
                                        ),
                                        value: activityList.isEmpty
                                            ? activity
                                            : helActivity.getActivity(
                                            user.activityActorId, activityList),
                                        iconSize: 24,
                                        elevation: 16,
                                        validator: (value) {
                                          if (value == null) {
                                            if(!hintList.contains(
                                                AppLocalizations.of(context)
                                                    .getTranslated('activity')
                                            )){
                                              hintList.add(
                                                  AppLocalizations.of(context)
                                                      .getTranslated('activity')
                                              );
                                            }
                                            return AppLocalizations.of(context)
                                                .getTranslated('requiredField');
                                          }
                                          if (hintList.contains(
                                              AppLocalizations.of(context)
                                                  .getTranslated('activity')
                                          )) {
                                            hintList.removeWhere((element)
                                            => element ==
                                                AppLocalizations.of(context)
                                                    .getTranslated('activity'));
                                          }
                                          return null;
                                        },
                                        onChanged: (Activity newValue) {
                                          activity = newValue;
                                          setState(() {
                                            debugPrint('User selected $newValue');
                                            user.activityActorId = newValue.id;
                                          });
                                        },
                                        items: activityList
                                            .map((project) =>
                                            DropdownMenuItem<Activity>(
                                              child: project.Name != null?
                                              Text(project.Name)
                                              :Text(''),
                                              value: project,
                                            ))
                                            .toList(),
                                      ),
                                    ),

                                    // 11th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('bankAccount'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            WhitelistingTextInputFormatter.digitsOnly
                                          ],
                                          controller: bankaccountController,
                                          onChanged: (value) {
                                            user.Bank_account =
                                                bankaccountController.text;
                                          }),
                                    ),

                                    // 12th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('legacy'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          controller: legacyController,
                                          onChanged: (value) {
                                            user.legacy = legacyController.text;
                                          }),
                                    ),

                                    // 13th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated(
                                                  'numberOfDependantChildren'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            WhitelistingTextInputFormatter.digitsOnly
                                          ],
                                          controller: numberChildrenChargeController,
                                          onChanged: (value) {
                                            user.numberChildrenCharge =
                                                numberChildrenChargeController.text;
                                          }),
                                    ),

                                    // 14th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated(
                                                  'numberOfChildrenInSchool'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            WhitelistingTextInputFormatter.digitsOnly
                                          ],
                                          controller:
                                          numberChildrenSchoolersController,
                                          onChanged: (value) {
                                            user.numberChildrenSchoolers =
                                                numberChildrenSchoolersController
                                                    .text;
                                          }),
                                    ),

                                    // 15th Element
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 15.0, bottom: 15.0),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('spouseActivity'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          controller: spouseactivityController,
                                          onChanged: (value) {
                                            user.Spouse_activity =
                                                spouseactivityController.text;
                                          }),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      // First element
                                      Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: DropdownButtonFormField<Identity>(
                                            decoration: InputDecoration(
                                              isDense: true,
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.auto,
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('idType'),
                                              labelStyle: TextStyle(fontSize: 16),
                                              contentPadding:
                                              EdgeInsets.symmetric(vertical: 9),
                                            ),
                                            value: identityList.isEmpty
                                                ? identity
                                                : helIdType.getIdentity(
                                                user.typeIdentityId, identityList),
                                            iconSize: 24,
                                            elevation: 16,
                                            validator: (value) {
                                              if (value == null) {
                                                if(!hintList.contains(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('idType'))){
                                                  hintList.add(
                                                      AppLocalizations.of(context)
                                                          .getTranslated('idType')
                                                  );
                                                }
                                                return AppLocalizations.of(context)
                                                    .getTranslated('requiredField');
                                              }
                                              if (hintList.contains(
                                                  AppLocalizations.of(context)
                                                      .getTranslated('idType')
                                              )) {
                                                hintList.removeWhere((element)
                                                => element ==
                                                    AppLocalizations.of(context)
                                                        .getTranslated('idType'));
                                              }
                                              return null;
                                            },
                                            onChanged: (Identity newValue) {
                                              identity = newValue;
                                              setState(() {
                                                user.typeIdentityId = newValue.id;
                                              });
                                            },
                                            items: identityList
                                                .map((project) =>
                                                DropdownMenuItem<Identity>(
                                                  child: project.Name != null?
                                                  Text(project.Name)
                                                  : Text(''),
                                                  value: project,
                                                ))
                                                .toList(),
                                          )),

                                      // second Element
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                                labelText: AppLocalizations.of(context)
                                                    .getTranslated('identityNumber'),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5.0))),
                                            inputFormatters: <TextInputFormatter>[
                                              WhitelistingTextInputFormatter.digitsOnly
                                            ],
                                            controller: identityController,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                if(!hintList.contains(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('identityNumber')
                                                )){
                                                  hintList.add(
                                                      AppLocalizations.of(context)
                                                          .getTranslated('identityNumber')
                                                  );
                                                }
                                                return AppLocalizations.of(context)
                                                    .getTranslated('requiredField');
                                              }
                                              if (hintList.contains(
                                                  AppLocalizations.of(context)
                                                      .getTranslated('identityNumber')
                                              )) {
                                                hintList.removeWhere((element)
                                                => element ==
                                                    AppLocalizations.of(context)
                                                        .getTranslated('identityNumber'));
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              user.identity_ = identityController.text;
                                            }),
                                      ),

                                      // third Element
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                          enableInteractiveSelection: false,
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('deliveryDate'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          controller: deliverydateController,
                                          onTap: () async {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            await _selectDate(context);
                                            deliverydateController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            user.Delivery_date =
                                                deliverydateController.text;
                                          },
                                        ),
                                      ),

                                      // 4th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                                labelText: AppLocalizations.of(context)
                                                    .getTranslated('deliveryPlace'),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5.0))),
                                            controller: deliveryplaceController,
                                            onChanged: (value) {
                                              user.Delivery_place =
                                                  deliveryplaceController.text;
                                            }),
                                      ),

                                      // 5th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                                labelText: 'مكان اصدارها',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(5.0))),
                                            controller: deliveryplaceDLController,
                                            onChanged: (value) {
                                              user.placeDeliveryDL =
                                                  deliveryplaceDLController.text;
                                            }),
                                      ),

                                      // 6th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                          enableInteractiveSelection: false,
                                          decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('validUntil'),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5.0))),
                                          controller: dateEndValidityController,
                                          onTap: () async {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            await _selectDate(context);
                                            dateEndValidityController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            user.dateEndValidity = dateEndValidityController.text;
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                              )
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        // First element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .getTranslated('homeAddress'),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        ButtonTheme(
                                            height: 50.0,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  getToSelectLocationPage(
                                                      context, signOut,
                                                      'Add Beneficiary', user,
                                                      userLoginId, status4);
                                                },
                                                color: Colors.indigo,
                                                child: Column(children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('select'),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                  ),
                                                ]))),

                                        // Second Element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('region')),
                                              Container(
                                                width: 75.0,
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<Region>(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                    labelStyle: TextStyle(fontSize: 22),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(vertical: 9),
                                                  ),
                                                  value: regionList.isEmpty
                                                      ? region
                                                      : helRegion.getReg(
                                                      user.regionAdresse, regionList),
                                                  //icon: Icon(Icons.arrow_downward),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged: _onRegionSelected,
                                                  items: regionList
                                                      .map((project) => DropdownMenuItem(
                                                    child: project.Name != null?
                                                    Text(project.Name)
                                                    : Text(''),
                                                    value: project,
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Third Element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('province')),
                                              Container(
                                                width: 65.0,
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<Province>(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                    labelStyle: TextStyle(fontSize: 22),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(vertical: 9),
                                                  ),
                                                  value: provinceList.isEmpty
                                                      ? province
                                                      : helProvince.getProv(
                                                      user.provinceAddress,
                                                      provinceList),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged: _onProvinceSelected,
                                                  items: provinceList
                                                      .map((project) => DropdownMenuItem(
                                                    child: Text(project.Name),
                                                    value: project,
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 4th Element
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('locality')),
                                              Container(
                                                width: 70.0,
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<Locality>(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                    labelStyle: TextStyle(fontSize: 22),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(vertical: 9),
                                                  ),
                                                  isExpanded: true,
                                                  value: localityList.isEmpty
                                                      ? locality
                                                      : helLocality.getLocal(
                                                      user.localityAddress,
                                                      localityList),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged: _onLocalitySelected,
                                                  items: localityList
                                                      .map((project) => DropdownMenuItem(
                                                    child: Text(project.Name),
                                                    value: project,
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 5th Element
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('complement')),
                                              Container(
                                                width: 40.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    controller:
                                                    additionalAdresseController,
                                                    onChanged: (value) {
                                                      user.additionalAdresse =
                                                          additionalAdresseController
                                                              .text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 6th Element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text('تكملة'),
                                              Container(
                                                width: 90.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    controller:
                                                    arabicAdditionalAddressController,
                                                    onChanged: (value) {
                                                      user.additionalDLAddress =
                                                          arabicAdditionalAddressController
                                                              .text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 7th Element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('GPSCoordinates')),
                                              Container(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    controller: mapsAddressController,
                                                    onChanged: (value) {
                                                      user.mapsAddress =
                                                          mapsAddressController.text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 8th Element
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 50.0, bottom: 15.0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .getTranslated('businessAddress'),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        ButtonTheme(
                                            height: 50.0,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  getToSelectBusinessLocation(
                                                      context, signOut,
                                                      'Add Beneficiary', user,
                                                      userLoginId, status4);
                                                },
                                                color: Colors.indigo,
                                                child: Column(children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .getTranslated('select'),
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                  ),
                                                ]))),

                                        // 9th Element
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('region')),
                                              Container(
                                                width: 75.0,
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<Region>(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                    labelStyle: TextStyle(fontSize: 22),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(vertical: 9),
                                                  ),
                                                  value: bRegionList.isEmpty
                                                      ? bRegion
                                                      : helRegion.getReg(
                                                      user.regionBusinessAddress,
                                                      bRegionList),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged: _onBregionSelected,
                                                  items: bRegionList
                                                      .map((project) => DropdownMenuItem(
                                                    child: project.Name != null?
                                                    Text(project.Name)
                                                    : Text(''),
                                                    value: project,
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Third Element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('province')),
                                              Container(
                                                width: 65.0,
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<Province>(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                    labelStyle: TextStyle(fontSize: 22),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(vertical: 9),
                                                  ),
                                                  value: bProvinceList.isEmpty
                                                      ? bProvince
                                                      : helProvince.getProv(
                                                      user.provinceBusinessAddress,
                                                      bProvinceList),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged: _onBprovinceSelected,
                                                  items: bProvinceList
                                                      .map((project) => DropdownMenuItem(
                                                    child: Text(project.Name),
                                                    value: project,
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 4th Element
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('locality')),
                                              Container(
                                                width: 70.0,
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<Locality>(
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.auto,
                                                    labelStyle: TextStyle(fontSize: 22),
                                                    contentPadding:
                                                    EdgeInsets.symmetric(vertical: 9),
                                                  ),
                                                  isExpanded: true,
                                                  value: bLocalityList.isEmpty
                                                      ? bLocality
                                                      : helLocality.getLocal(
                                                      user.localityBusinessAddress,
                                                      bLocalityList),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged: _onBlocalitySelected,
                                                  items: bLocalityList
                                                      .map((project) => DropdownMenuItem(
                                                    child: Text(project.Name),
                                                    value: project,
                                                  ))
                                                      .toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 5th Element
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('complement')),
                                              Container(
                                                width: 40.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    controller:
                                                    additionalBusinessAddressController,
                                                    onChanged: (value) {
                                                      user.additionalBusinessAddress =
                                                          additionalBusinessAddressController
                                                              .text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 6th Element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text('تكملة'),
                                              Container(
                                                width: 90.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    controller:
                                                    arabicAdditionalBusinessAddressController,
                                                    onChanged: (value) {
                                                      user.additionalDLBusinessAddress =
                                                          arabicAdditionalBusinessAddressController
                                                              .text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 7th Element

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('GPSCoordinates')),
                                              Container(
                                                width: 20.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    controller:
                                                    mapsCordsBusinessAddressController,
                                                    onChanged: (value) {
                                                      user.mapsCordsBusinessAddress =
                                                          mapsCordsBusinessAddressController
                                                              .text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('phone')),
                                              Container(
                                                width: 85.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      WhitelistingTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    controller: telephoneController,
                                                    onChanged: (value) {
                                                      user.telephone =
                                                          telephoneController.text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('secondPhone')),
                                              Container(
                                                width: 35.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      WhitelistingTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    controller: telephoneTwoController,
                                                    onChanged: (value) {
                                                      user.telephoneTwo =
                                                          telephoneTwoController.text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('email')),
                                              Container(
                                                width: 90.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    keyboardType:
                                                    TextInputType.emailAddress,
                                                    controller: emailController,
                                                    validator: (value) {
                                                      if (!EmailValidator.validate(value)) {
                                                        if(!hintList.contains(
                                                            AppLocalizations.of(context)
                                                                .getTranslated('email')
                                                        )){
                                                          hintList.add(
                                                              AppLocalizations.of(context)
                                                                  .getTranslated('email')
                                                          );
                                                        }
                                                        return AppLocalizations.of(context)
                                                            .getTranslated(
                                                            'emailValidMassage');
                                                      }
                                                      if (hintList.contains(
                                                          AppLocalizations.of(context)
                                                              .getTranslated('email')
                                                      )) {
                                                        hintList.removeWhere((element)
                                                        => element ==
                                                            AppLocalizations.of(context)
                                                                .getTranslated('email'));
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (value) {
                                                      user.email = emailController.text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 15.0, bottom: 15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(AppLocalizations.of(context)
                                                  .getTranslated('fax')),
                                              Container(
                                                width: 100.0,
                                              ),
                                              Expanded(
                                                child: TextFormField(
                                                    decoration: InputDecoration(),
                                                    controller: faxController,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      WhitelistingTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    onChanged: (value) {
                                                      debugPrint(
                                                          'Something changed in Fax Text Field');
                                                      user.fax = faxController.text;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                )
                            )

                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      // First element
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<StudyLevel>(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated('studyLevel'),
                                            labelStyle: TextStyle(fontSize: 16),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: studyList.isEmpty
                                              ? studyLevel
                                              : helStudy.getStudy(
                                              user.StudyLevelId, studyList),
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (StudyLevel newValue) {
                                            studyLevel = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.StudyLevelId = newValue.id;
                                            });
                                          },
                                          items: studyList
                                              .map((project) =>
                                              DropdownMenuItem<StudyLevel>(
                                                child: project.Name != null?
                                                Text(project.Name)
                                                :Text(''),
                                                value: project,
                                              ))
                                              .toList(),
                                        ),
                                      ),

                                      // second Element
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<PovertyDegree>(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated('degreeOfPoverty'),
                                            labelStyle: TextStyle(fontSize: 16),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: povertyList.isEmpty
                                              ? povertyDegree
                                              : helPoverty.getPoverty(
                                              user.DegreePovertyId, povertyList),
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (PovertyDegree newValue) {
                                            povertyDegree = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.DegreePovertyId = newValue.id;
                                            });
                                          },
                                          items: povertyList
                                              .map((project) =>
                                              DropdownMenuItem<PovertyDegree>(
                                                child: project.Name != null?
                                                Text(project.Name)
                                                : Text(''),
                                                value: project,
                                              ))
                                              .toList(),
                                        ),
                                      ),

                                      // third Element
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<Profession>(
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated('profession'),
                                            labelStyle: TextStyle(fontSize: 16),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: professionList.isEmpty
                                              ? profession
                                              : helProfession.getProfession(
                                              user.professionId, professionList),
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (Profession newValue) {
                                            profession = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.professionId = newValue.id;
                                            });
                                          },
                                          items: professionList
                                              .map((project) =>
                                              DropdownMenuItem<Profession>(
                                                child: project.Name != null?
                                                Text(project.Name)
                                                : Text(''),
                                                value: project,
                                              ))
                                              .toList(),
                                        ),
                                      ),

                                      // 4th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('monthlyIncome'),
                                            ),
                                            controller: monthly_incomeController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              WhitelistingTextInputFormatter.digitsOnly
                                            ],
                                            onChanged: (value) {
                                              debugPrint(
                                                  'Something changed in Username Text Field');
                                              user.monthly_income =
                                                  monthly_incomeController.text;
                                            }),
                                      ),

                                      // 5th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated(
                                                  'averageDailyExpenses'),
                                            ),
                                            controller:
                                            AverageIndividualExpensePerDayController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              WhitelistingTextInputFormatter.digitsOnly
                                            ],
                                            onChanged: (value) {
                                              debugPrint(
                                                  'Something changed in Username Text Field');
                                              user.AverageIndividualExpensePerDay =
                                                  AverageIndividualExpensePerDayController
                                                      .text;
                                            }),
                                      ),

                                      // 6th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<Occupation>(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated('occupation'),
                                            labelStyle: TextStyle(fontSize: 16),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: occupationList.isEmpty
                                              ? occupation
                                              : helOccupation.getOccup(
                                              user.typeOccupationId,
                                              occupationList),
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (Occupation newValue) {
                                            occupation = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.typeOccupationId = newValue.id;
                                            });
                                          },
                                          items: occupationList
                                              .map((project) =>
                                              DropdownMenuItem<Occupation>(
                                                child: project.Name != null?
                                                Text(project.Name)
                                                : Text(''),
                                                value: project,
                                              ))
                                              .toList(),
                                        ),
                                      ),

                                      // 7th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<FamilySituation>(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated('familySituation'),
                                            labelStyle: TextStyle(fontSize: 16),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: familyList.isEmpty
                                              ? familySituation
                                              : helFamily.getSituation(
                                              user.situationFamilyId, familyList),
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (FamilySituation newValue) {
                                            familySituation = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.situationFamilyId = newValue.id;
                                            });
                                          },
                                          items: familyList
                                              .map((project) =>
                                              DropdownMenuItem<FamilySituation>(
                                                child: project.Name != null? 
                                                Text(project.Name)
                                                : Text(''),
                                                value: project,
                                              ))
                                              .toList(),
                                        ),
                                      ),

                                      // 8th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<FamilyResources>(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated(
                                                'existingFamilyResources'),
                                            labelStyle: TextStyle(fontSize: 16),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: famResourceList.isEmpty
                                              ? familyResources
                                              : halFamResource.getResources(
                                              user.resourcesFamilyId,
                                              famResourceList),
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (FamilyResources newValue) {
                                            familyResources = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.resourcesFamilyId = newValue.id;
                                            });
                                          },
                                          items: famResourceList
                                              .map((project) =>
                                              DropdownMenuItem<FamilyResources>(
                                                child: project.Name != null?
                                                Text(project.Name)
                                                : Text(''),
                                                value: project,
                                              ))
                                              .toList(),
                                        ),
                                      ),

                                      // 9th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated('officeCredit'),
                                            labelStyle: TextStyle(fontSize: 22),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: user.OfficeCredit == null
                                              ? dropdownOfficeValue
                                              : user.OfficeCredit,
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (String newValue) {
                                            dropdownOfficeValue = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.OfficeCredit = newValue;
                                            });
                                          },
                                          items: <String>['', 'Yes', 'No']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),

                                      // 10th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            isDense: true,
                                            floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                            labelText: AppLocalizations.of(context)
                                                .getTranslated('blackList'),
                                            labelStyle: TextStyle(fontSize: 22),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 9),
                                          ),
                                          value: user.blackList == null
                                              ? dropdownRiskValue
                                              : user.blackList,
                                          iconSize: 24,
                                          elevation: 16,
                                          onChanged: (String newValue) {
                                            dropdownRiskValue = newValue;
                                            setState(() {
                                              debugPrint('User selected $newValue');
                                              user.blackList = newValue;
                                            });
                                          },
                                          items: <String>['', 'Yes', 'No']
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        ),
                                      ),

                                      // 11th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                            enableInteractiveSelection: false,
                                            decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('date'),
                                            ),
                                            controller: blackListDateController,
                                            onTap: () async {
                                              // Below line stops keyboard from appearing
                                              FocusScope.of(context)
                                                  .requestFocus(new FocusNode());
                                              // Show Date Picker Here
                                              await _selectDate(context);
                                              blackListDateController.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(date);
                                              user.blackListDate =
                                                  blackListDateController.text;
                                              //setState(() {});
                                            },
                                            onChanged: (value) {
                                              debugPrint(
                                                  'Something changed in Username Text Field');
                                              user.blackListDate =
                                                  blackListDateController.text;
                                            }),
                                      ),

                                      // 12th Element

                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15.0),
                                        child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: AppLocalizations.of(context)
                                                  .getTranslated('externalFinancing'),
                                            ),
                                            controller: ExternalFundingController,
                                            onChanged: (value) {
                                              debugPrint(
                                                  'Something changed in Username Text Field');
                                              user.External_funding =
                                                  ExternalFundingController.text;
                                            }),
                                      ),
                                    ],
                                  )
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {

    user.Name = firstNameController.text +
        ' ' +
        secondNameController.text +
        ' ' +
        thirdNameController.text +
        ' ' +
        fourthNameController.text;
    print(user.Name);

    user.userId_ = userLoginId;
    print(user.userId_);

    goToBeneficiariesPage(context, signOut, appBarTitle,
        user, false, null, userLoginId, status4);

    int result;
    user.synch = 0;
    if (user.id != null) {
      // Case 1: Update operation
      result = await helper.updateUserwithId(user);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertUser(user);
    }

    if (result != 0) {
      // Success
      _showAlertDialog(
          AppLocalizations.of(context).getTranslated('alertStatus'),
          AppLocalizations.of(context)
              .getTranslated('benefsaveMessageSuccessful'));
    } else {
      // Failure
      _showAlertDialog(
          AppLocalizations.of(context).getTranslated('alertStatus'),
          AppLocalizations.of(context).getTranslated('benefsaveMessageError'));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFFB0BEC5),
              accentColor: const Color(0xFFB0BEC5),
              colorScheme: ColorScheme.light(primary: const Color(0xFFB0BEC5)),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
        initialDate: date ?? now,
        firstDate: DateTime(1980),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      print('hello $picked');
      setState(() {
        date = picked;
      });
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _getTypeList() async {
    final List<UserType> _listType = await helType.getTypeList();
    setState(() {
      typeList = _listType;
    });
  }

  void _getGenderList() async {
    final List<Gender> _listGender = await helGender.getGenderList();
    setState(() {
      genderList = _listGender;
    });
  }

  void _getNationalityList() async {
    final List<Nationality> _listNation = await helNation.getNationalityList();
    setState(() {
      nationList = _listNation;
    });
  }

  void _getActivityList() async {
    final List<Activity> _listActivity = await helActivity.getActivityList();
    setState(() {
      activityList = _listActivity;
    });
  }

  void _getIdentityList() async {
    final List<Identity> _listIdentity = await helIdType.getIdentityList();
    setState(() {
      identityList = _listIdentity;
    });
  }

  // Adresse
  void _getRegionList() async {

    final List<Region> _listRegion = await helRegion.getRegionList();
    setState(() {
      regionList = _listRegion;
    });
  }

  void _provList(int id) async {
    if (id != null) {
      final List<Province> _listPrpvince =
      await helProvince.getProvinceBaseOnRegionList(id);
      setState(() {
        provinceList = _listPrpvince;
      });
    } else {
      Iterable.empty();
    }
  }

  Future<List<Province>> _getProvinceList(int id) async {

    if (id != null) {
      final List<Province> _listPrpvince =
      await helProvince.getProvinceBaseOnRegionList(id);
      return _listPrpvince;
    } else {
      return Iterable.empty();
    }
  }

  void _locaList(int id) async {
    if (id != null) {
      final List<Locality> _listLocality =
      await helLocality.getLocalityBaseOnRegionList(id);
      setState(() {
        localityList = _listLocality;
      });
    } else {
      Iterable.empty();
    }
  }

  Future<List<Locality>> _getLocalityList(int id) async {

    if (id != null) {
      final List<Locality> _listLocality =
      await helLocality.getLocalityBaseOnRegionList(id);
      return _listLocality;
    } else {
      return Iterable.empty();
    }
  }

  void _onRegionSelected(Region selectedRegion) async {
    try {
      _showLoadingDialog();
      final _provinceList = await _getProvinceList(selectedRegion.id);
      setState(() {
        this.region = selectedRegion;
        user.regionAdresse = selectedRegion.id;
        province = null;
        provinceList.clear();
        provinceList = _provinceList;
      });
      Navigator.pop(context);
    } catch (e) {
      //TODO: handle error
      rethrow;
    }
  }

  void _onProvinceSelected(Province selectedProvince) async {
    try {
      _showLoadingDialog();
      final _localityList = await _getLocalityList(selectedProvince.id);
      setState(() {
        this.province = selectedProvince;
        user.provinceAddress = selectedProvince.id;
        locality = null;
        localityList.clear();
        localityList = _localityList;
      });
      Navigator.pop(context);
    } catch (e) {
      //TODO: handle error
      rethrow;
    }
  }

  void _onLocalitySelected(Locality selectedProvince) {
    setState(() {
      this.locality = selectedProvince;
      user.localityAddress = selectedProvince.id;
    });
  }

  // Buisness Adresse
  void _getBregionList() async {
    await Future.delayed(Duration(seconds: 2));
    final List<Region> _listRegion = await helRegion.getRegionList();
    setState(() {
      bRegionList = _listRegion;
    });
  }

  void _BprovList(int id) async {
    if (id != null) {
      final List<Province> _listPrpvince =
      await helProvince.getProvinceBaseOnRegionList(id);
      setState(() {
        bProvinceList = _listPrpvince;
      });
    } else {
      Iterable.empty();
    }
  }

  Future<List<Province>> _getBprovinceList(int id) async {

    if (id != null) {
      final List<Province> _listPrpvince =
      await helProvince.getProvinceBaseOnRegionList(id);
      return _listPrpvince;
    } else {
      return Iterable.empty();
    }
  }

  void _BlocaList(int id) async {
    if (id != null) {
      final List<Locality> _listLocality =
      await helLocality.getLocalityBaseOnRegionList(id);
      setState(() {
        bLocalityList = _listLocality;
      });
    } else {
      Iterable.empty();
    }
  }

  Future<List<Locality>> _getBlocalityList(int id) async {

    if (id != null) {
      final List<Locality> _listLocality =
      await helLocality.getLocalityBaseOnRegionList(id);
      return _listLocality;
    } else {
      return Iterable.empty();
    }
  }

  void _onBregionSelected(Region selectedRegion) async {
    try {
      _showLoadingDialog();
      final _provinceList = await _getBprovinceList(selectedRegion.id);
      setState(() {
        this.bRegion = selectedRegion;
        user.regionBusinessAddress = selectedRegion.id;
        bProvince = null;
        bProvinceList.clear();
        bProvinceList = _provinceList;
      });
      Navigator.pop(context);
    } catch (e) {
      //TODO: handle error
      rethrow;
    }
  }

  void _onBprovinceSelected(Province selectedProvince) async {
    try {
      _showLoadingDialog();
      final _localityList = await _getLocalityList(selectedProvince.id);
      setState(() {
        this.bProvince = selectedProvince;
        user.provinceBusinessAddress = selectedProvince.id;
        bLocality = null;
        bLocalityList.clear();
        bLocalityList = _localityList;
      });
      Navigator.pop(context);
    } catch (e) {
      //TODO: handle error
      rethrow;
    }
  }

  void _onBlocalitySelected(Locality selectedProvince) {
    setState(() {
      this.bLocality = selectedProvince;
      user.localityBusinessAddress = selectedProvince.id;
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////

  void _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CupertinoActivityIndicator(animating: true),
          ),
        );
      },
    );
  }

  void _getStudyList() async {
    final List<StudyLevel> _listStudy = await helStudy.getStudyList();
    setState(() {
      studyList = _listStudy;
    });
  }

  void _getPovertyList() async {
    final List<PovertyDegree> _listPoverty = await helPoverty.getPovertyList();
    setState(() {
      povertyList = _listPoverty;
    });
  }

  void _getProfessionList() async {
    final List<Profession> _listProfession =
    await helProfession.getProfessionList();
    setState(() {
      professionList = _listProfession;
    });
  }

  void _getOccupationList() async {
    final List<Occupation> _listOccupation =
    await helOccupation.getOccupationList();
    setState(() {
      occupationList = _listOccupation;
    });
  }

  void _getFamilySituationList() async {
    final List<FamilySituation> _list = await helFamily.getFamilyList();
    setState(() {
      familyList = _list;
    });
  }

  void _getFamilyResourcesList() async {
    final List<FamilyResources> _list = await halFamResource.getFamilyList();
    setState(() {
      famResourceList = _list;
    });
  }

  Future<File> writeImageTemp(String base64Image, String imageName) async {
    final dir = await getTemporaryDirectory();
    await dir.create(recursive: true);
    final tempFile = File(path.join(dir.path, imageName));
    await tempFile.writeAsBytes(base64.decode(base64Image));
    return tempFile;
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);

      user.photo = imageFile.path;

      print("You captured image : ");
      print(user.photo);

      setState(() {
        _imageFile = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile,
        height: 150,
        width: 150,
      );
    } else {
      return Image.asset(
        'images/4us.png',
        height: 150,
        width: 150,
      );
    }
  }
}

class App4usImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage(AssetsPath.image_4us);
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );
    return Container(
      child: image,
    );
  }
}
