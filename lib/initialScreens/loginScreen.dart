import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../seller/sellerwelcome.dart';
import 'ContinueAsConsumerOrSellerScreen.dart';
import 'profilepicpicker.dart';
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
        // backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pastel.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: loginFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 160.h,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Crafty Hands ✨ \nLogin to Continue',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFFAB47BC),
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                        height: 432,
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            border: Border.all(
                              color: Color(0xFFAB47BC),
                              width: 1.5,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 22.0),
                                  child: Text('Email',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.1),
                                      hintText: 'Enter Email',
                                      hintStyle: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.purple),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      RegExp regex = RegExp(
                                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter your Email ';
                                      }else if (!regex.hasMatch(value)) {
                                        return 'Enter according to format';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                ),
                                const Text('Password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.1),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      hintText: ' Enter Password',
                                      hintStyle: TextStyle(
                                          fontSize: 13, color: Colors.grey),
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
                                        fontSize: 13,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w600),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Your Password ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Color(0xFFF44336),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordScreen()));
                                      }),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                          elevation: 3,
                                          minimumSize: const Size(200, 50),
                                          maximumSize: const Size(200, 50),
                                          shape: StadiumBorder(),
                                        ),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (loginFormKey.currentState
                                                  ?.validate() ==
                                              true) {
                                            try {
                                              final user = await _auth
                                                  .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                              print(user);
                                              _showLoggedInSnackbar();
                                              // Navigate to the next screen only if the user is registered
                                              if (user != null) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ContinueAsScreen()),
                                                );
                                              }
                                            } catch (e) {
                                              print(e);
                                              // Display an error message to the user
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'User not found. Please check your email and password.'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          }
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text('or',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.red,
                                      )),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                        elevation: 3,
                                        minimumSize: const Size(200, 50),
                                        maximumSize: const Size(200, 50),
                                      ),
                                      child: Text('Sign Up',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          )),
                                      onPressed: () async {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Registration()));
                                      }),
                                )
                              ]),
                        )))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
