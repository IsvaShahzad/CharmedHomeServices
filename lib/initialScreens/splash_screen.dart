import 'dart:async';
import 'package:flutter/material.dart';

import 'loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // Full screen width
        height: MediaQuery.of(context).size.height, // Full screen height
        color: Colors.white,
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover, // Cover the entire container
        ),
      ),
    );
  }
}
