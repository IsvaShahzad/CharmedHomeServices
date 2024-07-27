import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../seller/sellerwelcome.dart';
import 'ContinueAsConsumerOrSellerScreen.dart';
import 'ForgotPasswordScreen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isObscure = true;
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  late String email;
  late String password;
  late bool isLogin;

  void _showLoggedInSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logged in successfully!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize screen util
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690), // Set the base design size of your app
      minTextAdapt: true,
      splitScreenMode: true,
    );

    // Get screen width and height
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        // Prevent back button functionality
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/loginimage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: loginFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: screenHeight *
                            0.37), // Adjusted height for responsiveness
                    Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                // Email TextField
                                Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.7),
                                      hintText: 'Enter Email',
                                      hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(15.0),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      RegExp regex = RegExp(
                                        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
                                      );
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter your Email';
                                      } else if (!regex.hasMatch(value)) {
                                        return 'Enter according to format';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                ),
                                SizedBox(height: 10.h),
                                // Password TextField
                                Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.7),
                                      hintText: 'Enter Password',
                                      hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(15.0),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Your Password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Color(0xFFF44336),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.1), // White shadow with opacity
                                          spreadRadius: 0.5,
                                          offset: Offset(2, 2), // Shadow position
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      height: 42.h,
                                      width: screenWidth * 0.76, // 70% of screen width
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xffcc9a9d),
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(2.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18.sp,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (loginFormKey.currentState?.validate() == true) {
                                            try {
                                              final user = await _auth.signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password: passwordController.text,
                                              );
                                              print(user);
                                              _showLoggedInSnackbar();
                                              // Navigate to the next screen only if the user is registered
                                              if (user != null) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) => ContinueAsScreen(),
                                                  ),
                                                );
                                              }
                                            } catch (e) {
                                              print(e);
                                              // Display an error message to the user
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('User not found. Please check your email and password.'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'or',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 42.h,
                                    width: screenWidth * 0.76, // 70% of screen width
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.white,
                                        elevation: 0.5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18.sp,
                                          fontFamily: 'Montserrat',
                                          color: Color(0xffffa7a6),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Registration(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
