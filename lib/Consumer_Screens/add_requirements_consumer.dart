import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:services_android_app/Consumer_Screens/posted_requirement_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'Consumer_mainpage.dart';

class RequirementModel with ChangeNotifier {
  Map<String, dynamic> _addedposting = {};

  final String id;
  final String productname;
  final String productprice;
  final String ImageURl;
  final String productdescription;
  final String productquantity;
  final String email;
  final String mobile;
  final String deliverydate;

  RequirementModel({
    required this.id,
    required this.productname,
    required this.productprice,
    required this.ImageURl,
    required this.productdescription,
    required this.productquantity,
    required this.email,
    required this.mobile,
    required this.deliverydate,
  });

  factory RequirementModel.fromJson(Map<String, dynamic> json) {
    return RequirementModel(
      id: Uuid().v4(),
      productname: json['product name'],
      productprice: json['product price']?.toString() ?? '',
      ImageURl: json['Image URl'],
      productdescription: json['product description'],
      productquantity: json['product quantity'],
      mobile: json['Mobile Number']?.toString() ?? '',
      email: json['Contact email'],
      deliverydate: json['Delivery Date'],
    );
  }
  Map<String, dynamic> get addedposting => _addedposting;

  void removeRequirement(String id) async {
    print('Removing requirement with ID: $id');

    await FirebaseFirestore.instance.collection('AddRequirements').doc(id).delete();

    _addedposting.remove(id);
    print(_addedposting); // print the updated _addedposting map
    notifyListeners();
  }
}

class AddRequirements extends StatefulWidget {
  @override
  _AddRequirementsState createState() => _AddRequirementsState();
}

class _AddRequirementsState extends State<AddRequirements> {
  final _formKey = GlobalKey<FormState>();

  ShowAlert() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Requirements have been posted!",
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 17),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffb38e8e),
                elevation: 1,
                minimumSize: const Size(150, 50),
                maximumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Square shape
                ),
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                ),
              ),
              onPressed: () async {
                try {
                  final addedReqSnapshot =
                  await FirebaseFirestore.instance.collection('AddRequirements').get();

                  if (addedReqSnapshot.docs.isEmpty) {
                    print('No requirements found in Firestore.');
                  } else {
                    final addedrequirements = addedReqSnapshot.docs
                        .map((doc) {
                      try {
                        return RequirementModel.fromJson(doc.data() as Map<String, dynamic>);
                      } catch (e) {
                        print('Error parsing document data: ${doc.data()}');
                        print('Exception: $e');
                        return null; // Skip documents that cannot be parsed
                      }
                    })
                        .where((requirement) => requirement != null) // Filter out null values
                        .toList();

                    if (addedrequirements.isEmpty) {
                      print('No valid requirements found after parsing.');
                    } else {
                      addedrequirements.forEach((require) {
                        print('Name: ${require?.productname}');
                        print('Price: ${require?.productprice}');
                        print('ID: ${require?.id}');
                        print('Description: ${require?.productdescription}');
                        print('Quantity: ${require?.productquantity}');
                        print('Email: ${require?.email}');
                      });

                      // Navigate to the requirements display screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddRequirements(),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  print('Error fetching requirements from Firestore: $e');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  late String _productName;
  late String _productDescription;
  late double _productPrice;
  late String _productQuantity;
  late String _Deliverydate;
  late int _mobile;
  late String _email;
  late String id;

  File? imageFile;

  final TextEditingController ProductnameController = TextEditingController();
  final TextEditingController ProductDescriptionController =
  TextEditingController();
  final TextEditingController ProductpriceController = TextEditingController();
  final TextEditingController ProductQuantityController =
  TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController Mobilecontroller = TextEditingController();
  final TextEditingController IDcontroller = TextEditingController();

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('AddRequirements');

  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();

  @override
  void initState() {
    super.initState();
    _streamCategory = _collectionRef.snapshots();
    dateinput.text = ""; // Set the initial value of the text field
  }

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

    return WillPopScope(
      onWillPop: () async {
        // Prevent the user from going back
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/page6.png', // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 70),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConsumerMainPageScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: ProductnameController,
                      decoration: InputDecoration(
                        hintText: 'Please enter product name',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        border: InputBorder.none,
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
                    SizedBox(height: 7.h),
                    TextFormField(
                      controller: ProductDescriptionController,
                      decoration: InputDecoration(
                        hintText: 'Please enter product description',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a product description';
                        }
                        return null;
                      },
                      onSaved: (value) => _productDescription = value!,
                    ),
                    SizedBox(height: 7.h),
                    TextFormField(
                      controller: ProductpriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Please enter product price',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a product price';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                      _productPrice = double.tryParse(value!) ?? 0.0,
                    ),
                    SizedBox(height: 7.h),
                    TextFormField(
                      controller: ProductQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Please enter product quantity',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a product quantity';
                        }
                        return null;
                      },
                      onSaved: (value) => _productQuantity = value!,
                    ),
                    SizedBox(height: 7.h),
                    TextFormField(
                      controller: dateinput,
                      decoration: InputDecoration(
                        hintText: 'Please enter delivery date',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a delivery date';
                        }
                        return null;
                      },
                      onSaved: (value) => _Deliverydate = value!,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            dateinput.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    SizedBox(height: 7.h),
                    TextFormField(
                      controller: Mobilecontroller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Please enter mobile number',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a mobile number';
                        }
                        return null;
                      },
                      onSaved: (value) => _mobile = int.tryParse(value!) ?? 0,
                    ),
                    SizedBox(height: 7.h),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Please enter contact email',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10.0),
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a contact email';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                    SizedBox(height: 7.h),
                    Container(
                      child: imageFile == null
                          ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xffb38e8e),
                                elevation: 1,
                                minimumSize: const Size(100, 50),
                                maximumSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: Text(
                                'Pick Image',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              onPressed: () => selectFile(),
                            ),
                          ),
                        ],
                      )
                          : GestureDetector(
                        onTap: () => selectFile(),  // Trigger image picker on tap
                        child: Container(
                          height: 100,
                          width: 180,
                          child: Center(
                            child: Image.file(imageFile!),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xffb38e8e),
                            elevation: 1,
                            minimumSize: const Size(100, 50),
                            maximumSize: const Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero, // Square shape
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              var collectionRef =
                              FirebaseFirestore.instance.collection('AddRequirements');

                              id = Uuid().v4();

                              try {
                                final firebaseStorageRef = FirebaseStorage.instance
                                    .ref()
                                    .child('AddRequirements/$id.jpg');
                                await firebaseStorageRef.putFile(imageFile!);
                                final downloadUrl =
                                await firebaseStorageRef.getDownloadURL();

                                var snapshot = await collectionRef.add({
                                  'product name': _productName,
                                  'product description': _productDescription,
                                  'product price': _productPrice,
                                  'product quantity': _productQuantity,
                                  'Delivery Date': _Deliverydate,
                                  'Mobile Number': _mobile,
                                  'Contact email': _email,
                                  'Image URl': downloadUrl,
                                  'id': id,
                                });

                                print('Requirements added to Firebase Firestore');
                                print(
                                    'Document ID: ${snapshot.id}'); // Print the document ID

                                ShowAlert();

                                ProductnameController.clear();
                                ProductDescriptionController.clear();
                                ProductpriceController.clear();
                                ProductQuantityController.clear();
                                dateinput.clear();
                                Mobilecontroller.clear();
                                emailController.clear();

                                setState(() {
                                  imageFile = null;
                                });
                              } catch (e) {
                                print('Error adding requirements to Firestore: $e');
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
