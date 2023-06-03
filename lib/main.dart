import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile4us_new_version/dao/app_helpers/parameters_helper.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:mobile4us_new_version/views/app/fingerprint_page.dart';
import 'package:mobile4us_new_version/views/app/institutions_screen.dart';
import 'package:mobile4us_new_version/views/app/login_screen.dart';
import 'package:mobile4us_new_version/views/settings/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/appLocalizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<ThemeProvider>(
        child: MyLocalisedApp(),
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
    );
  });
}

class MyLocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<MyLocalisedApp> {

  bool status4 = false;
  Parameters baseUrl;
  bool linkTest = false;

  @override
  void initState() {
    super.initState();
    getUrlValue();
    getSwitchValues();
  }

  getUrlValue() async {
    ParameterHelper helperParameter = new ParameterHelper();
    baseUrl = await helperParameter.getParameterByKey('link');;
    if (baseUrl.value != null){
      linkTest = true;
    } else{
      linkTest = false;
    }
    setState(() {});
  }

  getSwitchValues() async {
    status4 = await getSwitchState();
    setState(() {});
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState");
    print(isSwitchedFT);
    return isSwitchedFT;
  }

  @override
  Widget build(BuildContext context) {

    if (status4 == null) {
      status4 = false;
    }
    return Consumer<ThemeProvider>(

      builder:(context, value, child) {
        return MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context).getTranslated('title'),
          debugShowCheckedModeBanner: false,
          theme: value.getTheme(),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ar', ''),
            const Locale('fr', '')],
          localeResolutionCallback: (currentLocale, supportedLocales) {
            if (currentLocale != null) {
              print(currentLocale.languageCode);
              for (Locale locale in supportedLocales) {
                if (currentLocale.languageCode == locale.languageCode) {
                  return currentLocale;
                }
              }
            }
            return supportedLocales.first;
          },
          home:
          linkTest ? (status4 == true ? FingerprintPage(status4)
              : LoginPage(status4)) : InstitutionsPage(status4),
        );
      },
    );
  }
}
