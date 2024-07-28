import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';

class VerifyEmail extends StatefulWidget {
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isverified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isverified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isverified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(hours: 1),
            (_) => checkEmailverified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isverified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isverified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/page4.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: isverified
          ? LoginScreen()
          : WillPopScope(
        onWillPop: () async => false, // Disable the back button
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A verification email has been sent to your account!',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xffcc9a9d),
                    backgroundColor: Colors.white,
                    minimumSize: Size(screenWidth * 0.6, screenHeight * 0.07), // Responsive size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Make the button square
                    ), // Button text color
                  ),
                  icon: Icon(Icons.check_circle, size: screenWidth * 0.05, color: Color(0xffcc9a9d)),
                  label: Text(
                    "I've Verified",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // Responsive font size
                      color: Color(0xffcc9a9d),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onPressed: () async {
                    await sendVerificationEmail();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: Size(screenWidth * 0.6, screenHeight * 0.07), // Button text color
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045, // Responsive font size
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
