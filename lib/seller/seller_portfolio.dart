import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SellerMainPage.dart';

class SellerPortfolio extends StatefulWidget {
  @override
  _SellerPortfolioState createState() => _SellerPortfolioState();
}

class _SellerPortfolioState extends State<SellerPortfolio> {
  String name = '';
  String picture = '';
  String workDone = '';
  List<String> products = [];

  final _formKey = GlobalKey<FormState>();
  bool _status = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _productsController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  bool _isSeller = false; // Flag to determine if the user is a seller

  Future ShowAlert() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Portfolio updated! "),
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
              child: Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SellerPortfolio(),
                ));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadSavedData();
    checkUserRole(); // Check the user role when the widget initializes
  }

  void loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _occupationController.text = prefs.getString('occupation') ?? '';
      _experienceController.text = prefs.getString('experience') ?? '';
      _descriptionController.text = prefs.getString('description') ?? '';
      _productsController.text = prefs.getString('products') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
    });
  }

  void checkUserRole() {
    // Logic to check if the user is a seller
    // Replace this with your own logic to determine the user role
    setState(() {
      _isSeller = true; // Set to true if the user is a seller
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pastel.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 13,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SellerHomePage()));
            },
          ),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'Seller Portfolio 💼',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            if (_isSeller) // Only show edit button if the user is a seller
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _status =
                        false; // Enable editing when the edit button is pressed
                  });
                },
              ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Text(
                    'Details:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: _nameController,
                        enabled:
                            !_status, // Disable editing if the status is true
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Occupation:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: _occupationController,
                        enabled:
                            !_status, // Disable editing if the status is true
                        decoration: InputDecoration(
                          hintText: 'Enter your occupation',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your occupation';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Experience:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: _experienceController,
                        enabled:
                            !_status, // Disable editing if the status is true
                        decoration: InputDecoration(
                          hintText: 'Enter your experience',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your experience';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: _descriptionController,
                        enabled:
                            !_status, // Disable editing if the status is true
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Enter a description',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Products:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: _productsController,
                        enabled:
                            !_status, // Disable editing if the status is true
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Enter your products',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your products';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: _emailController,
                        enabled:
                            !_status, // Disable editing if the status is true
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Phone number:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: TextFormField(
                        controller: _phoneController,
                        enabled:
                            !_status, // Disable editing if the status is true
                        decoration: InputDecoration(
                          hintText: 'Enter your number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
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
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      onPressed: _status
                          ? null
                          : savePortfolio, // Save only if the status is false
                    ),
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void savePortfolio() async {
    if (_formKey.currentState!.validate()) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', _nameController.text);
        await prefs.setString('occupation', _occupationController.text);
        await prefs.setString('experience', _experienceController.text);
        await prefs.setString('description', _descriptionController.text);
        await prefs.setString('products', _productsController.text);
        await prefs.setString('email', _emailController.text);
        await prefs.setString('phone', _phoneController.text);

        // Get a reference to the Firestore collection
        CollectionReference portfolioCollection =
            FirebaseFirestore.instance.collection('portfolio seller');

        // Create a document with an auto-generated ID
        await portfolioCollection.add({
          'sellername': _nameController.text,
          'occupation': _occupationController.text,
          'experience': _experienceController.text,
          'description': _descriptionController.text,
          'products': _productsController.text,
          'email': _emailController.text,
          'mobile': _phoneController.text,
        });

        print('Portfolio data saved to Firestore');
        ShowAlert();
      } catch (e) {
        print('Error saving portfolio data: $e');
      }
    }
  }
}
