import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import '../../seller/cart.dart' as cartt;
import '../../Providers/seller_cart_provider.dart';
import 'seller_cartscreen.dart' as cartscreen;
import 'package:flutter/services.dart';

import '../../Detail_Screens/Packages_DetailScreen/box_detailscreen.dart';
import '../../initialScreens/loginScreen.dart';
import 'payment_screen.dart';

class ShippingScreen extends StatefulWidget {
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  List<String> provinceOptions = [
    'Punjab',
    'Sindh',
    'Balochistan',
    'Khyber PakhtunKhwa',
    'Gilgit Baltistan'
  ];
  String _selectedProvince = 'Punjab';
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
            image: AssetImage("assets/images/pastel.png"),
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
                              decoration: BoxDecoration(
                                color: Color(0xFFAB47BC),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
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
                                    child: Text(
                                      'Shipment Details',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 22.0),
                                            child: Text('First Name',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF000000),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
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
                                                    .withOpacity(0.1),
                                                hintText:
                                                    'Enter Your First name',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.purple),
                                                ),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Text('Last Name',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF000000),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              // keyboardType: TextInputType.emailAddress,
                                              controller: lastNameController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                                // fontWeight: FontWeight.w600,
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.1),
                                                hintText:
                                                    'Enter Your Last name',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.purple),
                                                ),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text('Email',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF000000),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            height: 5.h,
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
                                                    .withOpacity(0.1),
                                                hintText: 'Enter Email',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.purple),
                                                ),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text('Postal Code',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF000000),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: postalCodeController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.1),
                                                hintText: 'Enter Postal Code',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.purple),
                                                ),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text('Mobile Number',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF000000),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            height: 5.h,
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
                                                    .withOpacity(0.1),
                                                hintText:
                                                    'Enter Your Mobile number',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.purple),
                                                ),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text('Address',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0xFF000000),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Container(
                                            child: TextFormField(
                                              controller: addressController,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.1),
                                                hintText: 'Enter Adress',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Colors.purple),
                                                ),
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
                                            height: 20.h,
                                          ),
                                          Text(
                                            'Province',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5.h,
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
                                                  Colors.white.withOpacity(0.1),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                                horizontal: 10.0,
                                              ),
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Colors.orange),
                                              ),
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
                                                      fontSize: 15,
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    '* 5% additional charges are applicable *',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
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
                                                  foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                                  elevation: 3,
                                                  minimumSize:
                                                      const Size(200, 50),
                                                  maximumSize:
                                                      const Size(200, 50),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                                child: Text(
                                                    'Proceed to Payment',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
