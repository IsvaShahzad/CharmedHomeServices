import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'loginScreen.dart';
import 'verify_email.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with the current screen size
    ScreenUtil.init(
      context,
      designSize: Size(375, 812), // Design size based on your design mockup
    );
    final double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/page3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true, // Allow the body to extend behind the app bar
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove the elevation for a flat look
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
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
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 220.h),
                _buildTextFormField(
                  controller: firstNameController,
                  hintText: 'Enter Your First Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Some Text';
                    } else if (value.length > 14) {
                      return 'Enter less than 14 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                _buildTextFormField(
                  controller: lastNameController,
                  hintText: 'Enter Your Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Some Text';
                    } else if (value.length > 20) {
                      return 'Enter less than 20 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                _buildTextFormField(
                  controller: emailController,
                  hintText: 'Enter Your Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Some Text';
                    } else if (!regex.hasMatch(value)) {
                      return 'Enter according to format';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                TextFormField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 12.w,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Some Text';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                _buildTextFormField(
                  controller: mobileController,
                  hintText: 'Enter Your Mobile',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Mobile Number';
                    } else if (value.length > 12) {
                      return 'Enter less than 12 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenWidth * 0.76, // 70% of screen width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffcc9a9d),
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
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          try {
                            final newUser = await _auth
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            final user = (await _auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            ))
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

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      VerifyEmail()),
                            );
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a responsive text form field
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 11.sp,
        color: Color(0xFF000000),
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 12.w,
        ),
      ),
      validator: validator,
    );
  }
}
