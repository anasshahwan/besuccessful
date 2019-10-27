import 'package:besuccessful/Screens/FavoriteQuote.dart';
import 'package:besuccessful/Screens/LoadingScreen.dart';
import 'package:besuccessful/Screens/QODScreen.dart';
import 'package:besuccessful/Screens/QouteCategories.dart';
import 'package:flutter/material.dart';
import 'Screens/SplashScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.id,
      routes: {

        LoadingScreen.id:(context)=>LoadingScreen(),
        QODScreen.id:(context)=>QODScreen(),
        FavoriteQuote.id:(context)=>FavoriteQuote(),
        QouteCategories.id : (context) =>QouteCategories(),
      },

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),

    );
  }
}