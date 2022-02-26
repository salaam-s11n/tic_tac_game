import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_game/provider_theme.dart';

import 'home_page.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Game',
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff00061a),
        shadowColor: const Color(0xff001456),
        splashColor: const Color(0xff4169e8),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontFamily: "RobotoCondensed",
              ),
              bodyText2: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontFamily: "RobotoCondensed",
              ),
              headline1: const TextStyle(
                  fontSize: 100,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueAccent),
              headline3: const TextStyle(
                  fontSize: 100,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.purple),
              headline2: const TextStyle(
                  fontSize: 22,
                  fontFamily: "RobotoCondensed",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              headline4: const TextStyle(
                fontSize: 22,
                fontFamily: "RobotoCondensed",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff),
              ),
            ),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xffffffff),
        shadowColor: const Color(0xff4169e8),
        splashColor: const Color(0xff4169e8),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color(0xff00061a),
                fontSize: 60,
                fontFamily: "RobotoCondensed",
              ),
              bodyText2: const TextStyle(
                color: Color(0xff00061a),
                fontSize: 50,
                fontFamily: "RobotoCondensed",
              ),
              headline1: const TextStyle(
                  fontSize: 100,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff00061a)),
              headline3: const TextStyle(
                  fontSize: 100,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Colors.pink),
              headline2: const TextStyle(
                fontSize: 22,
                fontFamily: "RobotoCondensed",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Color(0xff00061a),
              ),
              headline4: const TextStyle(
                fontSize: 22,
                fontFamily: "RobotoCondensed",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff),
              ),
            ),
      ),
      home: const MyHomePage(),
    );
  }
}
