import 'package:flutter/material.dart';
import 'package:mobile4us_new_version/dao/app_helpers/parameters_helper.dart';
import 'package:mobile4us_new_version/models/delayLevel.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:mobile4us_new_version/models/paymentState.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:mobile4us_new_version/views/app/login_screen.dart';
import 'package:mobile4us_new_version/views/demand/add_demand.dart';
import 'package:mobile4us_new_version/views/demand/demandDetail.dart';
import 'package:mobile4us_new_version/views/demand/demands.dart';
import 'package:mobile4us_new_version/views/home/home_page.dart';
import 'package:mobile4us_new_version/views/home/linked_devices.dart';
import 'package:mobile4us_new_version/views/home/scanner.dart';
import 'package:mobile4us_new_version/views/location/location_screen.dart';
import 'package:mobile4us_new_version/views/location/selectBusinessLocation.dart';
import 'package:mobile4us_new_version/views/location/select_location_screen.dart';
import 'package:mobile4us_new_version/views/location/userLocation.dart';
import 'package:mobile4us_new_version/views/reports/chartList.dart';
import 'package:mobile4us_new_version/views/reports/pie_chart/pie_chart_page.dart';
import 'package:mobile4us_new_version/views/reports/pie_chart/pie_chart_page2.dart';
import 'package:mobile4us_new_version/views/reports/pie_chart/pie_chart_page3.dart';
import 'package:mobile4us_new_version/views/settings/Lock_screen.dart';
import 'package:mobile4us_new_version/views/settings/Parameter_Screen.dart';
import 'package:mobile4us_new_version/views/settings/settings.dart';
import 'package:mobile4us_new_version/views/simulation/simulationPremium.dart';
import 'package:mobile4us_new_version/views/users/AddBeneficiary_screen.dart';
import 'package:mobile4us_new_version/views/users/beneficiaries_screen.dart';
import 'package:mobile4us_new_version/views/users/beneficiaryDetail.dart';

/// Login
void goToLoginPage(BuildContext context, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return LoginPage(status4);
  }));
}

/// Home
void goToHomePage(BuildContext context, VoidCallback signOut,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return HomeScreen(signOut, userLoginId, status4);
  }));
}

void goToLinkedDevicesPage(BuildContext context, VoidCallback signOut,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AppLinkedDevices(signOut, userLoginId, status4);
  }));
}

void goToScannerPage(BuildContext context){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Scanner();
  }));
}

/// Beneficiaries
void goToBeneficiariesPage(BuildContext context, VoidCallback signOut,
    String appBarTitle, User user, bool test, Demand demand,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return BeneficiariesScreen(signOut, appBarTitle, user, null,
        test, demand, userLoginId, status4);
  }));
}

void goToAddBeneficiaryPage(BuildContext context, VoidCallback signOut,
    String appBarTitle, User user, int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AddBeneficiaryScreen(signOut, appBarTitle, user,
         userLoginId, status4);
  }));
}

void goToBeneficiaryDetailPage(BuildContext context, VoidCallback signOut,
    User user, DelayLevel delayLevel, Payment payment,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return BeneficiariesDetails(signOut, user, delayLevel,
        payment, userLoginId, status4);
  }));
}

/// Demands
void goToDemandsPage(BuildContext context, VoidCallback signOut,
    User user, Demand demand, String appBarTitle, NatureDemand natureDe,
    NatureProject natureProject, Sector sector, DelayPayment delayPay,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return DemandList(signOut, user, demand, appBarTitle, natureDe,
        natureProject, sector, delayPay, userLoginId, status4);
  }));
}

void goToAddDemandPage(BuildContext context, VoidCallback signOut,
    User user, Demand demand, String appBarTitle, DelayPayment delayPayment,
    bool showButton, bool showSaveButton, int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AddDemand(signOut, user, demand, appBarTitle, delayPayment,
        showButton, showSaveButton, userLoginId, status4);
  }));
}

void goToDemandDetailsPage(BuildContext context, VoidCallback signOut,
    User user, Demand demand, String appBarTitle, NatureDemand natureDemand,
    NatureProject natureProject, Sector sector, DelayPayment delayPayment,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return DemandDetails(signOut, user, demand, natureDemand, natureProject,
        sector, delayPayment, userLoginId, status4);
  }));
}

/// Reports
void goToReportsPage(BuildContext context, VoidCallback signOut,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return chartsListScreen(signOut, userLoginId, status4);
  }));
}

void goToPieChart1Page(BuildContext context, VoidCallback signOut,
    int userLoginId, String chartQuery){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return PieChartPageTest(signOut, userLoginId, chartQuery);
  }));
}

void goToPieChart2Page(BuildContext context, VoidCallback signOut,
    int userLoginId, String chartQuery){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return PieChartPage2(signOut, userLoginId, chartQuery);
  }));
}

void goToPieChart3Page(BuildContext context, VoidCallback signOut,
    int userLoginId, String chartQuery){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return PieChartPage3(signOut, userLoginId, chartQuery);
  }));
}

/// Simulations
void goToSimulationPage(BuildContext context){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return CalculatePremium();
  }));
}

/// locations
void getToLocationPage(BuildContext context, VoidCallback signOut,
    int userLoginId, bool status4) async {

  Parameters parameter = await ParameterHelper()
      .getParameterByKey('latitudeLongitude');
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MyLocation(signOut, userLoginId, status4, parameter);
  }));
}

void getToSelectLocationPage(BuildContext context, VoidCallback signOut,
    String appBarTitle, User user, int userLoginId, bool status4) async {

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return MyLocationSelect(signOut, appBarTitle, user, userLoginId, status4);
  }));
}

void getToSelectBusinessLocation(BuildContext context, VoidCallback signOut,
    String appBarTitle, User user, int userLoginId, bool status4) async {

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return BusinessLocationSelect(signOut,
        appBarTitle, user, userLoginId, status4);
  }));
}

void getToUserLocationPage(BuildContext context, VoidCallback signOut,
    String appBarTitle, User user, int userLoginId, bool status4) async {

  Navigator.push(context, MaterialPageRoute(builder: (context) {
      return UserLocation(signOut, appBarTitle, user, userLoginId, status4);
    }));
}

/// Settings
void goToAppSettingsPage(BuildContext context, VoidCallback signOut,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AppSettings(signOut, userLoginId, status4);
  }));
}

void goToAppLockPage(BuildContext context, VoidCallback signOut,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return AppLockPage(signOut, userLoginId, status4);
  }));
}

void goToParameterPage(BuildContext context, VoidCallback signOut,
    int userLoginId, bool status4){

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return ParameterPage(signOut, userLoginId, status4);
  }));
}

