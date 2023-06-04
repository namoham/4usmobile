import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mobile4us_new_version/dao/app_helpers/PaymentState_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/activity_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/delayLevel_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/demand_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/familyResources_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/familySituation_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/gender_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/identity_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/locality_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/nationality_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/natureDemand_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/natureProject_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/occupation_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/parameters_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/povertyDegree_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/profession_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/province_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/region_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/sector_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/studyLevel_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/userType_helper.dart';
import 'package:mobile4us_new_version/dao/app_helpers/user_helper.dart';
import 'package:mobile4us_new_version/models/activity.dart';
import 'package:mobile4us_new_version/models/apiModels/api_error.dart';
import 'package:mobile4us_new_version/models/apiModels/api_response.dart';
import 'package:mobile4us_new_version/models/companies.dart';
import 'package:mobile4us_new_version/models/delayLevel.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/familyResources.dart';
import 'package:mobile4us_new_version/models/familySituation.dart';
import 'package:mobile4us_new_version/models/gender.dart';
import 'package:mobile4us_new_version/models/identity.dart';
import 'package:mobile4us_new_version/models/locality.dart';
import 'package:mobile4us_new_version/models/nationality.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:mobile4us_new_version/models/occupation.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:mobile4us_new_version/models/paymentState.dart';
import 'package:mobile4us_new_version/models/povertyDegree.dart';
import 'package:mobile4us_new_version/models/profession.dart';
import 'package:mobile4us_new_version/models/province.dart';
import 'package:mobile4us_new_version/models/region.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:mobile4us_new_version/models/studyLevel.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/models/userType.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

DemandHelper helper = new DemandHelper();
PaymentStateHelper payHelper = new PaymentStateHelper();
ActivityHelper activityHelper = new ActivityHelper();
DelayLevelHelper delayLevelHelper = new DelayLevelHelper();
FamilyResourcesHelper familyResHelper = new FamilyResourcesHelper();
FamilySituationHelper familySitHelper = new FamilySituationHelper();
GenderHelper genderHelper = new GenderHelper();
IdentityHelper identityHelper = new IdentityHelper();
LocalityHelper localityHelper = new LocalityHelper();
NationalityHelper nationalityHelper = new NationalityHelper();
NatureDemandHelper natureDeHelper = new NatureDemandHelper();
NatureProjectHelper naturePrHelper = new NatureProjectHelper();
OccupationHelper occupationHelper = new OccupationHelper();
PovertyHelper povertyHelper = new PovertyHelper();
ProfessionHelper professionHelper = new ProfessionHelper();
ProvinceHelper provinceHelper = new ProvinceHelper();
RegionHelper regionHelper = new RegionHelper();
SectorHelper sectorHelper = new SectorHelper();
StudyHelper studyHelper = new StudyHelper();
UserTypeHelper userTypeHelper = new UserTypeHelper();
UserHelper helperUser = new UserHelper();
ParameterHelper helperParameter = new ParameterHelper();
Parameters parameter;
Parameters baseUrl;

// GET INSTITUTIONS LINKS
Future<List<Company>> getCompaniesList() async {

  List<Company> compaanies;
  //baseUrl = await helperParameter.getParameterByKey('link');
  //parameter = await helperParameter.getParameterByKey('companies');

  String link = 'https://tomcat-dev.tanfid.de/tanfid_en/api/v1/companys/list/10';

  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(link, headers: {"Authorization": '123456'});

  //var res = await http.get(baseUrl.value + parameter.value + responsibleId.toString(), headers: {"Authorization": userAuth});
  print(res.statusCode);
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      print("json demand" + res.body);
      compaanies = body.map((dynamic item) => Company.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  return compaanies;
}

// authorize login
Future<ApiResponse> authenticateUser(String username, String password) async {
  ApiResponse _apiResponse = new ApiResponse();
  baseUrl = await helperParameter.getParameterByKey('link');

  final ioc = new HttpClient();
  ioc.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);

  final Map<String, dynamic> myyData = {
    'login': username,
    'password': password,
  };
  String encodedBody =
  myyData.keys.map((key) => "$key=${myyData[key]}").join("&");
  try {
    parameter = await helperParameter.getParameterByKey('4usLogin');

    final response = await http.post(
        baseUrl.value + parameter.value,
        headers: {
          "Accept": "application/json; charset=utf-8s",
          "content-type": "application/x-www-form-urlencoded"
        },
        body: encodedBody,
        encoding: Encoding.getByName("utf-8"));

    switch (response.statusCode) {
      case 200:
        json.decode(response.body);
        _apiResponse.Data = User.fromJson(json.decode(response.body));
        (_apiResponse.Data as User).password = password;
        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      case 403:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      case 500:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

// get demands
Future<List<Demand>> getDemandsByResponsible(int responsibleId, String userAuth) async {
  List<Demand> demands;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usDemand');
  //final String apiUrl = "https://tomcat-dev.tanfid.de/tanfid_er/tanfid-api/v1/demands/init/";
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
    baseUrl.value + parameter.value + responsibleId.toString(), headers: {"Authorization": userAuth});
  // print(res.statusCode);
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      print("json demand" + res.body);
      demands = body.map((dynamic item) => Demand.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (demands != null && demands.length > 0) {
    int check;
    for (final demand in demands) {
      check = await helper.checkDemand(demand.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await helper.insertDemand(demand);
      } else {
        // Case 2: Update operation
        await helper.updateDemand((demand));
      }
    }
    for (final demand in demands) {
      print(" - ${demand.id} : ${demand.code} - ${demand.designation} \n");
    }
  }
  return demands;
}

// get beneficiaries
Future<List<User>> getBeneficiariesByResponsible(int responsibleId,
    String userAuth) async {

  List<User> beneficiaries;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usBeneficiary');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host,
      int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(baseUrl.value + parameter.value +
      responsibleId.toString() + '/' + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  // print(res.statusCode);
  switch (res.statusCode) {
    case 200:
      User user =  await helperUser.getId(responsibleId);
      updateLastDate(user);
      List<dynamic> body = jsonDecode(res.body);
      print("json user" + res.body);
      beneficiaries = body.map((dynamic item) => User.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load Beneficiaries list');
      break;
  }

  if (beneficiaries != null && beneficiaries.length > 0) {
    int check;
    for (final beneficiary in beneficiaries) {
      check = await helperUser.checkUser(beneficiary.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await helperUser.insertUser(beneficiary);
      } else {
        // Case 2: Update operation
        await helperUser.updateUserwithId(beneficiary);
      }
    }
    for (final beneficiary in beneficiaries) {
      print("- ${beneficiary.id} : ${beneficiary.code} - ${beneficiary.firstName} - ${beneficiary.thirdName} \n");
    }
  }
  return beneficiaries;
}

// get payment State
Future<List<Payment>> getPaymentStateByResponsible(int responsibleId, String userAuth) async {
  List<Payment> payments;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usPayments');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      payments = body.map((dynamic item) => Payment.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (payments != null && payments.length > 0) {
    int check;
    for (final pay in payments) {
      check = await payHelper.checkPay(pay.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await payHelper.insertPay(pay);
      } else {
        // Case 2: Update operation
        await payHelper.updatePay((pay));
      }
    }
  }
  return payments;
}

// get Activity
Future<List<Activity>> getActivity(int responsibleId, String userAuth) async {
  List<Activity> activities;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usActivities');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      activities = body.map((dynamic item) => Activity.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (activities != null && activities.length > 0) {
    int check;
    for (final activity in activities) {
      check = await activityHelper.checkActivity(activity.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await activityHelper.insertActivity(activity);
      } else {
        // Case 2: Update operation
        await activityHelper.updateActivity((activity));
      }
    }
  }
  return activities;
}

// get delay Level
Future<List<DelayLevel>> getDelayLevel(int responsibleId, String userAuth) async {
  List<DelayLevel> delayLevels;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usDelayLevels');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      delayLevels = body.map((dynamic item) => DelayLevel.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (delayLevels != null && delayLevels.length > 0) {
    int check;
    for (final delayLevel in delayLevels) {
      check = await delayLevelHelper.checkDelayLevel(delayLevel.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await delayLevelHelper.insertDelayLevel(delayLevel);
      } else {
        // Case 2: Update operation
        await delayLevelHelper.updateDelayLevel((delayLevel));
      }
    }
  }
  return delayLevels;
}

// get Family Resources
Future<List<FamilyResources>> getFamilyResources(int responsibleId, String userAuth) async {
  List<FamilyResources> familyResources;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usFamilyRes');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      familyResources = body.map((dynamic item) => FamilyResources.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (familyResources != null && familyResources.length > 0) {
    int check;
    for (final familyResource in familyResources) {
      check = await familyResHelper.checkFamilyRes(familyResource.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await familyResHelper.insertFamily(familyResource);
      } else {
        // Case 2: Update operation
        await familyResHelper.updateFamily((familyResource));
      }
    }
  }
  return familyResources;
}

// get Family Situation
Future<List<FamilySituation>> getFamilySituations(int responsibleId, String userAuth) async {
  List<FamilySituation> familySituations;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usFamilySit');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      familySituations = body.map((dynamic item) => FamilySituation.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (familySituations != null && familySituations.length > 0) {
    int check;
    for (final familySituation in familySituations) {
      check = await familySitHelper.checkFamilySit(familySituation.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await familySitHelper.insertFamily(familySituation);
      } else {
        // Case 2: Update operation
        await familySitHelper.updateFamily((familySituation));
      }
    }
  }
  return familySituations;
}

// get Gender
Future<List<Gender>> getGender(int responsibleId, String userAuth) async {
  List<Gender> genders;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usGenders');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      genders = body.map((dynamic item) => Gender.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (genders != null && genders.length > 0) {
    int check;
    for (final gender in genders) {
      check = await genderHelper.checkGender(gender.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await genderHelper.insertGender(gender);
      } else {
        // Case 2: Update operation
        await genderHelper.updateGender((gender));
      }
    }
  }
  return genders;
}

// get Identity
Future<List<Identity>> getIdentities(int responsibleId, String userAuth) async {
  List<Identity> identities;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usIdentities');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      identities = body.map((dynamic item) => Identity.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (identities != null && identities.length > 0) {
    int check;
    for (final identity in identities) {
      check = await identityHelper.checkIdentity(identity.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await identityHelper.insertIdentity(identity);
      } else {
        // Case 2: Update operation
        await identityHelper.updateIdentity((identity));
      }
    }
  }
  return identities;
}

// get Locality
Future<List<Locality>> getLocalities(int responsibleId, String userAuth) async {
  List<Locality> localities;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usLocalities');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      localities = body.map((dynamic item) => Locality.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (localities != null && localities.length > 0) {
    int check;
    for (final locality in localities) {
      check = await localityHelper.checkLocality(locality.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await localityHelper.insertLocality(locality);
      } else {
        // Case 2: Update operation
        await localityHelper.updateLocality((locality));
      }
    }
  }
  return localities;
}

// get Nationality
Future<List<Nationality>> getNationalities(int responsibleId, String userAuth) async {
  List<Nationality> nationalities;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usNation');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      nationalities = body.map((dynamic item) => Nationality.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (nationalities != null && nationalities.length > 0) {
    int check;
    for (final nationality in nationalities) {
      check = await nationalityHelper.checkNationality(nationality.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await nationalityHelper.insertNationality(nationality);
      } else {
        // Case 2: Update operation
        await nationalityHelper.updateNationality((nationality));
      }
    }
  }
  return nationalities;
}

// get Demand Nature
Future<List<NatureDemand>> getNatureDemands(int responsibleId, String userAuth) async {
  List<NatureDemand> natureDemands;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usNatureDe');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      natureDemands = body.map((dynamic item) => NatureDemand.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (natureDemands != null && natureDemands.length > 0) {
    int check;
    for (final natureDemand in natureDemands) {
      check = await natureDeHelper.checkNatureDemand(natureDemand.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await natureDeHelper.insertNatureDemand(natureDemand);
      } else {
        // Case 2: Update operation
        await natureDeHelper.updateNatureDemand((natureDemand));
      }
    }
  }
  return natureDemands;
}

// get Project Nature
Future<List<NatureProject>> getNatureProjects(int responsibleId, String userAuth) async {
  List<NatureProject> natureProjects;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usNaturePr');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      natureProjects = body.map((dynamic item) => NatureProject.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (natureProjects != null && natureProjects.length > 0) {
    int check;
    for (final natureProject in natureProjects) {
      check = await naturePrHelper.checkNatureProject(natureProject.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await naturePrHelper.insertNatureProject(natureProject);
      } else {
        // Case 2: Update operation
        await naturePrHelper.updateNatureProject((natureProject));
      }
    }
  }
  return natureProjects;
}

// get Occupation
Future<List<Occupation>> getOccupations(int responsibleId, String userAuth) async {
  List<Occupation> occupations;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usOccupations');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      occupations = body.map((dynamic item) => Occupation.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (occupations != null && occupations.length > 0) {
    int check;
    for (final occupation in occupations) {
      check = await occupationHelper.checkOccupation(occupation.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await occupationHelper.insertOccupation(occupation);
      } else {
        // Case 2: Update operation
        await occupationHelper.updateOccupation((occupation));
      }
    }
  }
  return occupations;
}

// get Poverty Degree
Future<List<PovertyDegree>> getPovertyDegrees(int responsibleId, String userAuth) async {
  List<PovertyDegree> povertyDegrees;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usPovDeg');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      povertyDegrees = body.map((dynamic item) => PovertyDegree.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (povertyDegrees != null && povertyDegrees.length > 0) {
    int check;
    for (final povertyDegree in povertyDegrees) {
      check = await povertyHelper.checkPoverty(povertyDegree.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await povertyHelper.insertPoverty(povertyDegree);
      } else {
        // Case 2: Update operation
        await povertyHelper.updatePoverty((povertyDegree));
      }
    }
  }
  return povertyDegrees;
}

// get Profession
Future<List<Profession>> getProfessions(int responsibleId, String userAuth) async {
  List<Profession> professions;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usProfessions');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      professions = body.map((dynamic item) => Profession.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (professions != null && professions.length > 0) {
    int check;
    for (final profession in professions) {
      check = await professionHelper.checkProfession(profession.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await professionHelper.insertProfession(profession);
      } else {
        // Case 2: Update operation
        await professionHelper.updateProfession((profession));
      }
    }
  }
  return professions;
}

// get Province
Future<List<Province>> getProvinces(int responsibleId, String userAuth) async {
  List<Province> provinces;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usProvinces');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      provinces = body.map((dynamic item) => Province.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (provinces != null && provinces.length > 0) {
    int check;
    for (final province in provinces) {
      check = await provinceHelper.checkProvince(province.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await provinceHelper.insertProvince(province);
      } else {
        // Case 2: Update operation
        await provinceHelper.updateProvince((province));
      }
    }
  }
  return provinces;
}

// get Regions
Future<List<Region>> getRegions(int responsibleId, String userAuth) async {
  List<Region> regions;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usRegions');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      regions = body.map((dynamic item) => Region.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (regions != null && regions.length > 0) {
    int check;
    for (final region in regions) {
      check = await regionHelper.checkRegion(region.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await regionHelper.insertRegion(region);
      } else {
        // Case 2: Update operation
        await regionHelper.updateRegion((region));
      }
    }
  }
  return regions;
}

// get Sectors
Future<List<Sector>> getSectors(int responsibleId, String userAuth) async {
  List<Sector> sectors;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usSectors');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      sectors = body.map((dynamic item) => Sector.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (sectors != null && sectors.length > 0) {
    int check;
    for (final sector in sectors) {
      check = await sectorHelper.checkSector(sector.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await sectorHelper.insertSector(sector);
      } else {
        // Case 2: Update operation
        await sectorHelper.updateSector((sector));
      }
    }
  }
  return sectors;
}

// get Study Levels
Future<List<StudyLevel>> getStudyLevels(int responsibleId, String userAuth) async {
  List<StudyLevel> studyLevels;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usStudyLevels');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      studyLevels = body.map((dynamic item) => StudyLevel.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (studyLevels != null && studyLevels.length > 0) {
    int check;
    for (final studyLevel in studyLevels) {
      check = await studyHelper.checkStudy(studyLevel.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await studyHelper.insertStudy(studyLevel);
      } else {
        // Case 2: Update operation
        await studyHelper.updateStudy((studyLevel));
      }
    }
  }
  return studyLevels;
}

// get User Type
Future<List<UserType>> getUserTypes(int responsibleId, String userAuth) async {
  List<UserType> userTypes;
  baseUrl = await helperParameter.getParameterByKey('link');
  parameter = await helperParameter.getParameterByKey('4usActorTypes');
  final ioc = new HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);
  var res = await http.get(
      baseUrl.value + parameter.value + responsibleId.toString(),
      headers: {"Authorization": userAuth});
  switch (res.statusCode) {
    case 200:
      List<dynamic> body = jsonDecode(res.body);
      userTypes = body.map((dynamic item) => UserType.fromJson(item)).toList();
      break;
    case 403:
      print('403 You are not authorized to access the application');
      break;
    case 404:
      print('page not found');
      break;
    case 500:
      print('Internal Server Error');
      break;
    default:
      print('Failed to load demands list');
      break;
  }
  if (userTypes != null && userTypes.length > 0) {
    int check;
    for (final userType in userTypes) {
      check = await userTypeHelper.check(userType.id);
      if (check == 0) {
        // Case 1: Insert Operation
        await userTypeHelper.insert(userType);
      } else {
        // Case 2: Update operation
        await userTypeHelper.update((userType));
      }
    }
  }
  return userTypes;
}

// send demands
Future<ApiResponse> syncDemand(int responsibleId, Demand demand, _connectionStatus) async {
  ApiResponse _apiResponse = new ApiResponse();
  Demand syncDemand;
  baseUrl = await helperParameter.getParameterByKey('link');

  String json = jsonEncode(demand.toJson());

  try {
    if (_connectionStatus == true) {
      parameter = await helperParameter.getParameterByKey('demandApi');
      final ioc = new HttpClient();
      ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      // TODO: demand.responsibleId is 0, fix this issue
      // TODO: After fix it, change 10 with demand.responsibleId.toString()
      // print("Synchronized Demand ID Responsible : " + demand.responsibleId.toString());
      final response = await http.post(baseUrl.value + parameter.value + responsibleId.toString(),
          headers: {"Authorization": "123456", "content-type": "application/json"} ,body: json);
      switch (response.statusCode) {
        case 200:
          jsonDecode(response.body);
          _apiResponse.Data = Demand.fromJson(jsonDecode(response.body));
          syncDemand = _apiResponse.Data;
          syncDemand.synchDate_ = DateTime.now().toString();
          await helper.updateDemand(syncDemand);
          break;
        case 404:
          _apiResponse.ApiError = ApiError.fromJson(jsonDecode(response.body));
          break;
        default:
          _apiResponse.ApiError = ApiError.fromJson(jsonDecode(response.body));
          break;
      }
    } else {}
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

//send beneficiaries
Future<ApiResponse> syncBeneficiary(int responsibleId, User user, _connectionStatus) async {
  ApiResponse _apiResponse = new ApiResponse();
  User syncUser;

  baseUrl = await helperParameter.getParameterByKey('link');

  String json = jsonEncode(user.toJson());

  try {
    if (_connectionStatus == true) {
      parameter = await helperParameter.getParameterByKey('beneficiaryApi');

      ///////////////////////////////////////////
      final String image = user.photo != null ? user.photo : 'default';
      String img64 = 'default';
      if (user.photo != null) {
        if (await Permission.storage.request().isGranted) {
          var imageFile = File(user.photo);
          final bytes = imageFile.readAsBytesSync();
          img64 = base64Encode(bytes);
          print('image is :' + img64);
        }
      }
      ///////////////////////////////////////////

      final ioc = new HttpClient();
      ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      final response = await http.post(baseUrl.value + parameter.value + responsibleId.toString(),
          headers: {"Authorization": "123456", "content-type": "application/json"} ,body: json);
      switch (response.statusCode) {
        case 200:
          jsonDecode(response.body);
          _apiResponse.Data = User.fromJson(jsonDecode(response.body));
          updateLastDate(user);

          /*syncUser = _apiResponse.Data;
          syncUser.synchDate_ = DateTime.now().toString();
          if (syncUser.photo != 'default') {
            File ImgFile = await ImagePath(syncUser.photo, 'image' + syncUser.id.toString());
            ImgFile != null ? syncUser.photo = ImgFile.path : syncUser.photo = 'default';
            print('image path is :' + ImgFile.path);
          }
          await helperUser.updateUserwithId(syncUser);*/

          break;
        case 404:
          _apiResponse.ApiError = ApiError.fromJson(jsonDecode(response.body));
          break;
        default:
          _apiResponse.ApiError = ApiError.fromJson(jsonDecode(response.body));
          print(_apiResponse.ApiError.toString());
          SnackBar(
              content: Text(_apiResponse.ApiError.toString()
            //Text("Please resolve given errors")
          ));
          break;
      }
    } else {}
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<File> ImagePath(String base64Image, String imageName) async {
  if (await Permission.storage.request().isGranted) {
    final folderName = "4USImages";
    final targetDir = Directory("storage/emulated/0/$folderName");
    if ((await targetDir.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      targetDir.create();
    }
    final targetPath = join(targetDir.path, imageName);
    print(targetPath);
    File targetFile = File(targetPath);
    var result;
    await targetFile.writeAsBytes(base64.decode(base64Image), flush: true);
    return targetFile;
  }
}

Future<File> writeImageTemp(String base64Image, String imageName) async {
  final dir = await getTemporaryDirectory();
  await dir.create(recursive: true);
  final tempFile = File(path.join(dir.path, imageName));
  await tempFile.writeAsBytes(base64.decode(base64Image));
  return tempFile;
}

void updateLastDate(User user) async {
  user.synch = 1;
  user.synchDate_ = DateTime.now().toString();
  await helperUser.updateUserwithId(user);
}
