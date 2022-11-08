import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // ThemeMode themeMode = ThemeMode.light;
  late ThemeMode themeMode;

  ThemeProvider(String theme) {
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void toggleTheme() {
    // var themeMode;
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    notifyListeners(); //isko function me he to call karna hoga na ..
  }

  // @override

}
