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
      builder: (ctx) => Builder(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0), // Square shape
          ),
          title: Text(
            "Portfolio updated! ",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffcc9a9d),
                  elevation: 3,
                  minimumSize: const Size(150, 50),
                  maximumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0), // Square shape
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Montserrat'),
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
          image: AssetImage("assets/images/portfolio.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextFormField(
                      controller: _nameController,
                      enabled:
                          !_status, // Disable editing if the status is true
                      decoration: InputDecoration(
                          hintText: 'Enter your name',
                          filled: true, // Enable fill color
                          fillColor: Colors.white.withOpacity(0.8),
                          border: InputBorder.none // Set fill color here
                          ),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    child: TextFormField(
                      controller: _occupationController,
                      enabled:
                          !_status, // Disable editing if the status is true
                      decoration: InputDecoration(
                          hintText: 'Enter your occupation',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your occupation';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    child: TextFormField(
                      controller: _experienceController,
                      enabled:
                          !_status, // Disable editing if the status is true
                      decoration: InputDecoration(
                          hintText: 'Enter your experience',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your experience';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    child: TextFormField(
                      controller: _descriptionController,
                      enabled:
                          !_status, // Disable editing if the status is true
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Enter a description',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    child: TextFormField(
                      controller: _productsController,
                      enabled:
                          !_status, // Disable editing if the status is true
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Enter your products',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your products';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    child: TextFormField(
                      controller: _emailController,
                      enabled:
                          !_status, // Disable editing if the status is true
                      decoration: InputDecoration(
                          hintText: 'Enter your email',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    child: TextFormField(
                      controller: _phoneController,
                      enabled:
                          !_status, // Disable editing if the status is true
                      decoration: InputDecoration(
                        hintText: 'Enter your number',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffcc9a9d),
                        elevation: 3,
                        minimumSize: const Size(150, 50),
                        maximumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0), // Square shape
                        ),                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Montserrat'),
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
