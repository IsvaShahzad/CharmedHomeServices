import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import '../../seller/cart.dart' as cartt;
import '../../Providers/seller_cart_provider.dart';
import 'seller_cartscreen.dart' as cartscreen;
import 'package:flutter/services.dart';

import 'payment_screen.dart';

class ShippingScreen extends StatefulWidget {
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  List<String> provinceOptions = [
    'London',
    'Manchester',
    'Bristol',
    'Somerset',
    'Hampshire'
  ];
  String _selectedProvince = 'London';
  bool _expressDelivery = false;

  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Cart cart = Cart(); // Replace this with your actual Cart instance

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/page4.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Form(
                key: _formKey,
                child: Container(
                    padding: EdgeInsets.only(top: 25.0),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                              padding: EdgeInsets.symmetric(vertical: 22.0),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              cartscreen.CartScreen(
                                            cart: context.read<cartt.Cart>(),
                                            cartProvider:
                                                context.read<CartProvider>(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                      width: 15), // Adjust the width as needed
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 13),

                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                height: 620,
                                width: 370,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [

                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              controller: firstNameController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.7),
                                                hintText:
                                                    'Enter Your First name',
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                fontFamily: 'Montserrat'
                                                ),
                                               border: InputBorder.none,
                                              ),
                                              textInputAction: TextInputAction.next,

                                              validator: (value) {
                                                RegExp regex = RegExp(
                                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Some Text ';
                                                } else if (value.length > 20) {
                                                  return 'Enter less than 20 numbers';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              // keyboardType: TextInputType.emailAddress,
                                              controller: lastNameController,

                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.7),
                                                hintText:
                                                    'Enter Your Last name',
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontFamily: 'Montserrat'

                                                ),
                                                border:InputBorder.none
                                              ),
                                              textInputAction: TextInputAction.next,

                                              validator: (value) {
                                                RegExp regex = RegExp(
                                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Some Text ';
                                                } else if (value.length > 20) {
                                                  return 'Enter less than 20 numbers';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              controller: emailController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.7),
                                                hintText: 'Enter Email',
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontFamily: 'Montserrat'

                                                ),
                                                border: InputBorder.none
                                              ),
                                              textInputAction: TextInputAction.next,

                                              validator: (value) {
                                                RegExp regex = RegExp(
                                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Some Text ';
                                                }  else if (!regex
                                                    .hasMatch(value)) {
                                                  return 'Enter according to format';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: postalCodeController,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF000000),
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.7),
                                                hintText: 'Enter Postal Code',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey,
                                                    fontFamily: 'Montserrat'

                                                ),
                                                border: InputBorder.none
                                              ),
                                              textInputAction: TextInputAction.next,

                                              validator: (value) {
                                                RegExp regex = RegExp(
                                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Some Text ';
                                                } else if (value.length > 20) {
                                                  return 'Enter less than 20 numbers';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: mobileController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.7),
                                                hintText:
                                                    'Enter Your Mobile number',
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontFamily: 'Montserrat'

                                                ),
                                                border: InputBorder.none
                                              ),
                                              textInputAction: TextInputAction.next,

                                              validator: (value) {
                                                RegExp regex = RegExp(
                                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Some Text ';
                                                } else if (value.length > 20) {
                                                  return 'Enter less than 20 numbers';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),

                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              controller: addressController,
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.7),
                                                hintText: 'Enter Adress',
                                                hintStyle: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontFamily: 'Montserrat'

                                                ),
                                                border: InputBorder.none,
                                              ),
                                              textInputAction: TextInputAction.next,

                                              validator: (value) {
                                                RegExp regex = RegExp(
                                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please Enter Some Text ';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          DropdownButtonFormField(
                                            value: _selectedProvince,
                                            items:
                                                provinceOptions.map((category) {
                                              return DropdownMenuItem(
                                                value: category,
                                                child: Text(category),
                                              );
                                            }).toList(),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  Colors.white.withOpacity(0.7),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 10.0,
                                              ),
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                              border: InputBorder.none
                                            ),
                                            onChanged: (selectedCategory) {
                                              setState(() {
                                                _selectedProvince =
                                                    selectedCategory.toString();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: _expressDelivery,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _expressDelivery = value!;
                                                  });
                                                },
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Express Delivery',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Montserrat'
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    '* 5% additional charges are applicable *',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                      fontFamily: 'Montserrat'
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white, backgroundColor: Color(0xffcc9a9d),

                                                  elevation: 2,
                                                  minimumSize:
                                                      const Size(210, 50),
                                                  maximumSize:
                                                      const Size(210, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                  ),
                                                ),
                                                child: Text(
                                                    'Checkout',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'Montserrat',
                                                        fontSize: 18)),
                                                onPressed: () async {
                                                  print(_formKey
                                                      .currentState); // Debug statement

                                                  if (_formKey.currentState !=
                                                          null &&
                                                      _formKey.currentState!
                                                          .validate()) {
                                                    try {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'ShippingDetails')
                                                          .doc()
                                                          .set({
                                                        'First name':
                                                            firstNameController
                                                                .text,
                                                        'Last name':
                                                            lastNameController
                                                                .text,
                                                        'Email': emailController
                                                            .text,
                                                        'Postal Code':
                                                            postalCodeController
                                                                .text,
                                                        'Mobile Number':
                                                            mobileController
                                                                .text,
                                                        'Address':
                                                            addressController
                                                                .text,
                                                        'Province':
                                                            _selectedProvince,
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }

                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                PaymentScreen()));
                                                  }
                                                }),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )))));
  }
}
