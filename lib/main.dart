import 'package:flutter/material.dart';
import 'package:task1/Screens/bottom_naviation.dart';
import 'package:task1/Screens/home_screen.dart';
import 'package:task1/Screens/search_screen.dart';
import 'package:task1/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(background: Colors.black),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
