import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mypetcare_userprofile/screen/myhomepage.dart';
import 'package:animated_splash/animated_splash.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage()));
      },
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplash(
          imagePath: 'assets/images/petcare.jpeg',
          home: MyHomePage(),
          duration: 2500,
          type: AnimatedSplashType.BackgroundProcess,
        ));
  }
}
