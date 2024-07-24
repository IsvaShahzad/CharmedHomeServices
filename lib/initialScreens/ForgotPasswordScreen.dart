import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'loginScreen.dart';

Future<void> sendPasswordResetEmail(String email) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isObscure = true;
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  ShowAlert() {
    return showDialog(
      context: context,


      builder: (ctx) => AlertDialog(
        title: Text("Email reset link has been sent! "),
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


  late final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/pastel.png"
              ),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 13,


          shape: RoundedRectangleBorder(

              borderRadius:  BorderRadius.only(

                  bottomRight: Radius.circular(12),

                  bottomLeft: Radius.circular(12))

          ),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Forgot password",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),

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

                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Crafty Hands✨  \nForgot Password',
                            style: TextStyle(
                              fontSize: 33,
                              color: Color(0xFFAB47BC),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      SizedBox(
                        height: 43.h,
                      ),
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                              border: Border.all(
                                color: Color(0xFFAB47BC),
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
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text('Email',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: emailController,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.withOpacity(0.1),
                                          hintText: 'Enter Email',
                                          hintStyle: TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                width: 3, color: Colors.grey),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(
                                              8.0, 10.0, 5.0, 10.0),
                                        ),
                                        validator: (value) {
                                          RegExp regex = RegExp(
                                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                          if (value == null || value.isEmpty) {
                                            return 'Please Enter Some Text ';
                                          } else if (value.length > 20) {
                                            return 'Enter less than 20 numbers';
                                          } else if (!regex.hasMatch(value)) {
                                            return 'Enter according to format';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
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
                                          child: Text('Send Link',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          onPressed: () async {
                                            await sendPasswordResetEmail(
                                                emailController.text);
                                            ShowAlert();

                                            // if (loginFormKey.currentState!.validate())
                                            //   Navigator.of(context).push(MaterialPageRoute(
                                            //       builder: (context) => ResetScreen()));
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ))
                    ])))),
      ),
    );
  }
}
