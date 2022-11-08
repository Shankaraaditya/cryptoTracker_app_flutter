// ignore_for_file: use_key_in_widget_constructors

import 'package:cryptotracker_app_flutter/Pages/homepage.dart';
import 'package:cryptotracker_app_flutter/constants/Themes.dart';
import 'package:cryptotracker_app_flutter/models/local_storage.dart';
import 'package:cryptotracker_app_flutter/provider/markets_provider.dart';
import 'package:cryptotracker_app_flutter/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String currentTheme = await LocalStorage.getTheme() ?? "light";

  runApp( MyApp(theme: currentTheme,));
}

class MyApp extends StatelessWidget {
  final String theme;

  const MyApp({required this.theme});

  //  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider(),
          ),
          // iska consumer home page me column me expanded ke andar ka contenet hai

          //...list of all providers to be called

          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(theme),
          )
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              theme: lightTheme, // to make theme in the app video no 4 ;
              darkTheme: darkTheme,
              // themeMode: ThemeMode.light, // themeMOde ye batata hai ki app currently kis theme me hai...
              themeMode: themeProvider.themeMode,
              home: HomePage(),
            );
          },
        ));
  }
}
