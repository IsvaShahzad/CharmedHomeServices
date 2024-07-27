import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'SellerMainPage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  ShowAlert() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Product has been added! ",
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 19),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFAB47BC),
                elevation: 3,
                minimumSize: const Size(150, 50),
                maximumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0), // Square shape
                ),
              ),
              child: Text('OK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Montserrat')),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SellerHomePage()));
              },
            ),
          )
        ],
      ),
    );
  }

  late String _productName;
  late String _productDescription;
  late double _productPrice;
  File? imageFile;
  List<String> categoryOptions = [
    'Cooking',
    'Arts and Crafts',
    'Knitting',
    'Tailoring',
    'Baking'
  ];
  List<String> subcategoryOptions = [
    'Frozen',
    'Home made',
    'Western',
    'Banner Making',
    'Quilting',
    'Canvas Painting',
    'sweaters',
    'Socks',
    'scarfs',
    'Coats',
    'Pants',
    'Shirt',
    'Cakes',
    'Brownies',
    'Pizza',
    'Cupcake',
  ];
  late String _selectedCategory;

  // List<String> subcategoryOptions = [];

  void updateSubcategories() {
    if (_selectedCategory == 'Cooking') {
      subcategoryOptions = ['Frozen', 'Home made', 'Western'];
    } else if (_selectedCategory == 'Arts and Crafts') {
      subcategoryOptions = ['Banner Making', 'Quilting', 'Canvas Painting'];
    } else if (_selectedCategory == 'Knitting') {
      subcategoryOptions = ['sweaters', 'Socks', 'scarfs'];
    } else if (_selectedCategory == 'Tailoring') {
      subcategoryOptions = ['Coats', 'Pants', 'Shirt'];
    } else if (_selectedCategory == 'Baking') {
      subcategoryOptions = ['Cakes', 'Brownies', 'Pizza', 'Cupcake'];
    } else {
      subcategoryOptions = [];
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCategory = categoryOptions[0];
    updateSubcategories();
  }

  // late String _selectedCategory = 'Cooking';
  late String? _selectedSubCategory = subcategoryOptions[0];

  final TextEditingController ProductnameController = TextEditingController();
  final TextEditingController CompanyController = TextEditingController();
  final TextEditingController ProductDescriptionController =
      TextEditingController();
  final TextEditingController ProductpriceController = TextEditingController();

  selectFile() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 100, maxWidth: 180);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    String filename = "";

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/page7.png"),
                fit: BoxFit.cover)),
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
                          builder: (context) => SellerHomePage()));
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.h,
                                  ),


                                  TextFormField(
                                    controller: CompanyController,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Please enter your company name',
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.7),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10.0),
                                      hintStyle: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => _productName = value!,
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    controller: ProductnameController,
                                    decoration: InputDecoration(
                                      hintText: 'Please enter product name',
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10.0),
                                        fillColor: Colors.white.withOpacity(0.7),

                                        hintStyle: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      border: InputBorder.none
                                    ),

                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a product name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => _productName = value!,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),


                                  TextFormField(
                                    controller: ProductDescriptionController,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Please enter product description',
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.7),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10.0),
                                      hintStyle: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a product description';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        _productDescription = value!,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),


                                  TextFormField(
                                    controller: ProductpriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Please enter product price',
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.7),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10.0),
                                      hintStyle: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                        border: InputBorder.none

                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a product price';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) =>
                                        _productPrice = double.parse(value!),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),


                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Category')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }

                                      snapshot.data?.docs.forEach((doc) {
                                        final categoryName = doc['name'];
                                        if (!categoryOptions
                                            .contains(categoryName)) {
                                          categoryOptions.add(categoryName);
                                        }
                                      });

                                      // Ensure that each category in categoryOptions list is unique
                                      categoryOptions =
                                          categoryOptions.toSet().toList();

                                      // Set the initial value of _selectedCategory to the first category in the list
                                      if (_selectedCategory == null &&
                                          categoryOptions.isNotEmpty) {
                                        _selectedCategory = categoryOptions[0];
                                      }

                                      return DropdownButtonFormField(
                                        value: _selectedCategory,
                                        items: categoryOptions.map((category) {
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
                                              fontSize: 13, color: Colors.grey),
                                            border: InputBorder.none

                                        ),
                                        onChanged: (selectedCategory) {
                                          setState(() {
                                            _selectedCategory =
                                                selectedCategory.toString();
                                            updateSubcategories();
                                            _selectedSubCategory =
                                                subcategoryOptions[0];
                                          });
                                        },
                                      );

                                    },
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),


                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('subcategories')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      }

                                      snapshot.data?.docs.forEach((doc) {
                                        final subCategoryName = doc['name'];
                                        if (!subcategoryOptions
                                            .contains(subCategoryName)) {
                                          subcategoryOptions
                                              .add(subCategoryName);
                                        }
                                      });

                                      // Ensure that each subcategory in subcategoryOptions list is unique
                                      subcategoryOptions =
                                          subcategoryOptions.toSet().toList();

                                      // Set the initial value of _selectedSubCategory to the first subcategory in the list
                                      if (_selectedSubCategory == null &&
                                          subcategoryOptions.isNotEmpty) {
                                        _selectedSubCategory =
                                            subcategoryOptions[0];
                                      }

                                      return DropdownButtonFormField<String>(
                                        value: _selectedSubCategory,
                                        onChanged:
                                            (String? selectedSubCategory) {
                                          setState(() {
                                            _selectedSubCategory =
                                                selectedSubCategory!;
                                          });
                                        },
                                        items: subcategoryOptions
                                            .map((String subcategory) {
                                          return DropdownMenuItem<String>(
                                            value: subcategory,
                                            child: Text(subcategory),
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
                                              fontSize: 13, color: Colors.grey),
                                          border: InputBorder.none
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  if (_selectedCategory != null) ...[
                                    Text('Product Image Sample',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'
                                        )),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 160,
                                      width: 200,
                                      child: Column(
                                        children: [
                                          if (imageFile != null)
                                            Container(
                                              child: Image.file(
                                                File(imageFile!.path),
                                              ),
                                            ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Color(0xffcc9a9d),
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(2.0),
                                                  ),
                                                ),
                                                onPressed: selectFile,
                                                child: const Text(
                                                  'Select file',style: TextStyle(
                                                  fontFamily: 'Montserrat'
                                                ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Color(0xffcc9a9d),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(2.0),
                                          ),
                                          elevation: 1,
                                          minimumSize: const Size(180, 50),
                                          maximumSize: const Size(180, 50),
                                        ),
                                        child: Text('Add Product',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              fontFamily: 'Montserrat'
                                            )),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState?.save();
                                            ShowAlert();

                                            if (imageFile != null) {
                                              try {
                                                final timestamp = DateTime.now()
                                                    .millisecondsSinceEpoch;
                                                final ref = FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child(
                                                        'images/${timestamp}_$filename');

                                                await ref.putFile(imageFile!);
                                                final url =
                                                    await ref.getDownloadURL();

                                                FirebaseFirestore.instance
                                                    .collection('addproducts')
                                                    .doc()
                                                    .set({
                                                  'company name':
                                                      CompanyController.text,
                                                  'product name':
                                                      ProductnameController
                                                          .text,
                                                  'product description':
                                                      ProductDescriptionController
                                                          .text,
                                                  'product price':
                                                      ProductpriceController
                                                          .text,
                                                  'product category':
                                                      _selectedCategory,
                                                  'product subcategory':
                                                      _selectedSubCategory,
                                                  'Image URl': url,
                                                });
                                              } catch (e) {
                                                print(e);
                                              }
                                            } else {
                                              print("Image not selected");
                                            }
                                            // print(storage);
                                          }
                                        },
                                      ),
                                    )
                                  ]
                                ]),
                          ))),
                ),
              ),
            )));
  }
}
