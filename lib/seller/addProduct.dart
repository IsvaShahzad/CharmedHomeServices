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
        title: Text("Product has been added! "),
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
  final TextEditingController ProductDescriptionController = TextEditingController();
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
              image: AssetImage("assets/images/pastel.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 13,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SellerHomePage()));
              },
            ),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                'Add Product✨',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 637,
                decoration: BoxDecoration(
                    color: Colors.white30,
                    border: Border.all(
                      color: Color(0xFFAB47BC),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 25.h,
                                ),
                                Text('Add a new product to your inventory!',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold)),
                                Padding(padding: EdgeInsets.only(top: 18)),
                                Text('Company/Business name',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  controller: CompanyController,
                                  decoration: InputDecoration(
                                    hintText: 'Please enter your company name',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10.0),
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.purple),
                                    ),
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
                                  height: 20.h,
                                ),
                                Text('Product name',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  controller: ProductnameController,
                                  decoration: InputDecoration(
                                    hintText: 'Please enter product name',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10.0),
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.purple),
                                    ),
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
                                  height: 20.h,
                                ),
                                Text(
                                  'Product Description',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  controller: ProductDescriptionController,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Please enter product description',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10.0),
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.purple),
                                    ),
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
                                  height: 20.h,
                                ),
                                Text('Product Price',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                TextFormField(
                                  controller: ProductpriceController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Please enter product price',
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10.0),
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.orange),
                                    ),
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
                                  height: 20.h,
                                ),
                                Text(
                                  'Product Category',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.h,
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
                                            Colors.white.withOpacity(0.1),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 10.0,
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.orange),
                                        ),
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
                                    SizedBox(height: 20.0);
                                    Text(
                                      'Product Subcategory',
                                      style: TextStyle(fontSize: 16.0),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Product Subcategory',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
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
                                        subcategoryOptions.add(subCategoryName);
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
                                      onChanged: (String? selectedSubCategory) {
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
                                            Colors.white.withOpacity(0.1),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 10.0,
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.orange),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                if (_selectedCategory != null) ...[
                                  Text('Product Image Sample',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.bold)),
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
                                                foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                              onPressed: selectFile,
                                              child: const Text(
                                                'Select file',
                                              )),
                                        )
                                      ],
                                    ),
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
                                        minimumSize: const Size(180, 50),
                                        maximumSize: const Size(180, 50),
                                      ),
                                      child: Text('Add Product',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          )),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
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
                                                'company name': CompanyController.text,
                                                'product name':
                                                    ProductnameController.text,
                                                'product description':
                                                    ProductDescriptionController
                                                        .text,
                                                'product price':
                                                    ProductpriceController.text,
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
                                            print("image not selected");
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
          )),
    );
  }
}
