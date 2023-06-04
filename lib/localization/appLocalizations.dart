import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppLocalizations {
  Locale locale;

  AppLocalizations(this.locale);


  static AppLocalizations of( BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, String> _loadedLocalizedValues = {
  };

  Future loadLanguage() async {
    String _langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> _loadedValues = jsonDecode(_langFile);
    _loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslated(String key) {
    return _loadedLocalizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async{
    AppLocalizations appLocalization = AppLocalizations(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

