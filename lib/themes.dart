import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemes {
  static const primary = Colors.red;
  static final primaryColor = Colors.red.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor, 
    colorScheme: const ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.2)
    )
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      ),
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black.withOpacity(0.3)
    )
  );
}

class ThemeNotifier extends ChangeNotifier{
  bool _darkTheme = false;
  SharedPreferences? _preferences;

  bool get darkTheme => _darkTheme;

  ThemeNotifier(){
    _loadSettingsFromPrefs();
  }

  _initializePrefs() async{
    // if (_preferences == null){
    _preferences ??= await SharedPreferences.getInstance();
    
  }

  _loadSettingsFromPrefs() async{
    await _initializePrefs();
    _darkTheme = _preferences?.getBool('darkTheme') ?? false;
    notifyListeners();
  }

  _saveSettingsToPrefs() async {
    await _initializePrefs();
    _preferences?.setBool('darkTheme', _darkTheme);
  }

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveSettingsToPrefs();
    notifyListeners();
  }
}