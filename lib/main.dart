import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Caculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                foregroundColor:
                    const MaterialStatePropertyAll<Color>(Colors.white),
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.blueGrey.shade400))),
      ),
      home: AnimatedSplashScreen(
        backgroundColor: Colors.blueGrey,
        duration: 3000,
        splash: Image.asset("images/bmi.png"),
        nextScreen: const Home(),
        splashTransition: SplashTransition.scaleTransition,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
