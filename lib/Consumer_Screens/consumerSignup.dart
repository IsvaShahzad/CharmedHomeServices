import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../initialScreens/loginScreen.dart';
import '../initialScreens/verify_email.dart';

class signupConsumer extends StatefulWidget {
  @override
  State<signupConsumer> createState() => _signupConsumerState();
}

class _signupConsumerState extends State<signupConsumer> {
  bool _isObscure = true;

  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/pastel.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 13,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }),
              ],
            ),
            body: Container(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 22.0),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Sign up consumer ',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFFAB47BC),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 578,
                      width: 370,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          border: Border.all(
                            color: Color(0xFFAB47BC),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: Text('First Name',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                child: TextFormField(
                                  // keyboardType: TextInputType.emailAddress,
                                  controller: firstNameController,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: 'Enter Your First name',
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.purple),
                                    ),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text('Last Name',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                child: TextFormField(
                                  // keyboardType: TextInputType.emailAddress,
                                  controller: lastNameController,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: 'Enter Your Last name',
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.purple),
                                    ),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text('Email',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  style: TextStyle(
                                    fontSize: 11,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.purple),
                                    ),
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
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                              ),
                              const Text('Password',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 5.h,
                              ),
                              TextFormField(
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
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Some Text ';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text('Mobile Number',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: mobileController,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: 'Enter Your Mobile number',
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.purple),
                                    ),
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
                                height: 20.h,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),
                                    elevation: 3,
                                    minimumSize: const Size(200, 50),
                                    maximumSize: const Size(200, 50),
                                    shape: StadiumBorder(),
                                  ),
                                  child: Text('Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  onPressed: () async {
                                    try {
                                      final newUser = await _auth
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);

                                      final user = (await _auth
                                              .signInWithEmailAndPassword(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text))
                                          .user;

                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user?.uid)
                                          .set({
                                        'id': user?.uid,
                                        'firstname': firstNameController.text,
                                        'lastname': lastNameController.text,
                                        'mobile': mobileController.text,
                                        'isAdmin': false,
                                        'isApproved': false,
                                        'email': user?.email,
                                      });

                                      print(newUser);
                                    } catch (e) {
                                      print(e);
                                    }

                                    // if (loginFormKey.currentState!.validate())

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                VerifyEmail()));
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoginScreen()));
                                    },
                                    child: Text('Already have an account?',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            )))));
  }
}
