import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'loginScreen.dart';
// import 'dart:ui' show ImageFilter;

class ResetScreen extends StatefulWidget {
  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  // LoginScreen({required Key key}) : super(key: key);
  bool _isObscure = true;
  final loginFormKey = GlobalKey<FormState>();
  var confirmPass;
  ShowAlert() {
    return showDialog(
      context: context,

      //   return BackdropFilter
      //(
      //filter: ImageFilter.blur(sigmaX:6,sigmaY: 6,
      //) );
      //}
      builder: (ctx) => AlertDialog(
        title: Text("Password Updated Successfully"),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                elevation: 3,
                minimumSize: const Size(150, 50),
                maximumSize: const Size(150, 50),
                shape: StadiumBorder(),
              ),
              child: Text('OK',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          )
        ],
      ),
    );
  }

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: loginFormKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: (Container(
                              width: 200,
                              height: 150,
                              decoration: BoxDecoration(),
                              child: Image.asset('assets/images/homeservicespic.PNG'))),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Home Services Reset Password',
                              style: TextStyle(
                                fontSize: 35,
                                color: Color(0xFFFFA500),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SizedBox(
                          height: 63.h,
                        ),
                        Container(
                            height: 315,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFFF8C00),
                                  width: 1.5,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            child: SingleChildScrollView(
                                child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 25.0),
                                          child: Text('Password',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          child: TextFormField(
                                            controller: passwordController,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w600,
                                            ),
                                            obscureText: _isObscure,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              hintText: ' Enter Password',
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
                                            validator: (value) {
                                              confirmPass = value;
                                              if (value == null || value.isEmpty) {
                                                return "Please Enter Some Text";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                        ),
                                        Text('Confirm Password',
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
                                            controller: confirmpasswordController,
                                            obscureText: _isObscure,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              hintText: ' Enter Password',
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
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w600),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please Enter Some Text ';
                                              }
                                              if (value !=
                                                  passwordController.text) {
                                                return 'Passwords do not match!';
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
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
                                              child: Text('Update',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18)),
                                              onPressed: () {
                                                if (loginFormKey.currentState!
                                                    .validate())
                                                  ShowAlert();
                                                // Navigator.of(context).push(
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             ShowAlert(context)));
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ))))
                      ])))),
    );
  }
}
