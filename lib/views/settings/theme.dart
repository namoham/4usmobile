import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _selectedTheme;
  Typography defaultTypography;
  SharedPreferences prefs;

  ThemeData dark = _buildAppDarkTheme();

  ThemeData light = _buildAppTheme();

  ThemeProvider(bool darkThemeOn) {
    _selectedTheme = darkThemeOn ? dark : light;
  }

  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs.setBool("darkTheme", false);
    } else {
      _selectedTheme = dark;
      await prefs.setBool("darkTheme", true);
    }

    notifyListeners();
  }

  ThemeData getTheme() => _selectedTheme;
}


IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: Colors.white);
}

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _appColorScheme,
    accentColor: Colors.indigoAccent,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    // ignore: deprecated_member_use
    textSelectionColor: appPink100,
    errorColor: Colors.red,
    buttonTheme:  ButtonThemeData(
      colorScheme: _appColorScheme,
      splashColor: Colors.lightBlue,
      buttonColor: Colors.indigoAccent,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildAppTextTheme(base.textTheme),
    primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildAppTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
    headline5: base.headline5.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: defaultLetterSpacing,
        color: Colors.indigo[600],
        fontSize: 18),
    headline6: base.headline6.copyWith(
        fontSize: 20,
        letterSpacing: defaultLetterSpacing,
        color: Colors.white),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.indigo,
      letterSpacing: defaultLetterSpacing,
    ),
    bodyText1: base.bodyText1.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: primaryColor,
      letterSpacing: defaultLetterSpacing,
    ),
    bodyText2: base.bodyText2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.blueGrey,
      letterSpacing: defaultLetterSpacing,
    ),
    subtitle1: base.subtitle1.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: primaryColor,
      letterSpacing: defaultLetterSpacing,
    ),
    headline4: base.headline4.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: Colors.white,
      letterSpacing: defaultLetterSpacing,
    ),
    button: base.button.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.white,
      letterSpacing: defaultLetterSpacing,
    ),
  )
      .apply(
    fontFamily: 'Nexa',
  );
}

const ColorScheme _appColorScheme = ColorScheme(
  primary: Colors.indigoAccent,
  primaryVariant: appBrown900,
  secondary: appPink50,
  secondaryVariant: appBrown900,
  surface: appSurfaceWhite,
  background: appBackgroundWhite,
  error: appErrorRed,
  onPrimary: appBrown900,
  onSecondary: appBrown900,
  onSurface: appBrown900,
  onBackground: appBrown900,
  onError: appSurfaceWhite,
  brightness: Brightness.light,
);


ThemeData _buildAppDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    colorScheme: _appColorSchemeDark,
    accentColor: Colors.indigoAccent,
    primaryColor: primaryColorDark,
    scaffoldBackgroundColor: Colors.black12,
    // ignore: deprecated_member_use
    textSelectionColor: appPink100,
    errorColor: Colors.red,
    cardTheme: CardTheme(
      color: Colors.blueGrey[900],
      shadowColor: Colors.black12,
    ),
    buttonTheme:  ButtonThemeData(
      colorScheme: _appColorSchemeDark,
      splashColor: Colors.lightBlue,
      buttonColor: Colors.indigoAccent,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildAppTextDarkTheme(base.textTheme),
    primaryTextTheme: _buildAppTextDarkTheme(base.primaryTextTheme),
    accentTextTheme: _buildAppTextDarkTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}



TextTheme _buildAppTextDarkTheme(TextTheme base) {
  return base
      .copyWith(
    headline5: base.headline5.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: defaultLetterSpacing,
        color: Colors.white,
        fontSize: 18),
    headline6: base.headline6.copyWith(
        fontSize: 20,
        letterSpacing: defaultLetterSpacing,
        color: Colors.white),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.white,
      letterSpacing: defaultLetterSpacing,
    ),
    bodyText1: base.bodyText1.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: primaryColorDark,
      letterSpacing: defaultLetterSpacing,
    ),
    bodyText2: base.bodyText2.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.blueGrey,
      letterSpacing: defaultLetterSpacing,
    ),
    subtitle1: base.subtitle1.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: primaryColorDark,
      letterSpacing: defaultLetterSpacing,
    ),
    headline4: base.headline4.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: Colors.white,
      letterSpacing: defaultLetterSpacing,
    ),
    button: base.button.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.white,
      letterSpacing: defaultLetterSpacing,
    ),
  )
      .apply(
    fontFamily: 'Nexa',
  );
}


const ColorScheme _appColorSchemeDark = ColorScheme(
  primary: Colors.indigoAccent,
  primaryVariant: appBrown900,
  secondary: appPink50,
  secondaryVariant: appBrown900,
  surface: appSurfaceWhite,
  background: appBackgroundBlack,
  error: appErrorRed,
  onPrimary: appBrown900,
  onSecondary: appBrown900,
  onSurface: appBrown900,
  onBackground: appBrown900,
  onError: appSurfaceWhite,
  brightness: Brightness.dark,
);

const Color appPink50 = Color(0xFFFEEAE6);
const Color appPink100 = Color(0xFFFEDBD0);
const Color primaryColor = Colors.indigo;

const Color primaryColorDark = Colors.blueGrey;


const Color appBrown900 = Color(0xFF442B2D);


const Color appErrorRed = Color(0xFFC5032B);

const Color appSurfaceWhite = Color(0xFFFFFBFA);
const Color appBackgroundWhite = Colors.white;
const Color appBackgroundBlack = Colors.black;

const defaultLetterSpacing = 0.03;

