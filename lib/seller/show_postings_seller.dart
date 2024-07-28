import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../InitialScreens/loginScreen.dart';



class SellerShowPostings extends StatefulWidget {
  final Map<String, dynamic> addedposting;
  final String id;


  SellerShowPostings({required this.addedposting, required this.id});

  @override
  _SellerShowPostingsState createState() => _SellerShowPostingsState();
}

class _SellerShowPostingsState extends State<SellerShowPostings> {
  int _selectedIndex = 0;

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('AddRequirements');

  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamCategory = _collectionRef.snapshots();
  }

  Future<void> removeRequirement(dynamic addedp) async {
    setState(() {
      widget.addedposting['All Requirements']
          .removeWhere((id) => id == addedp);
    });
  }

  String getAppbarTitle() => "Added Postings ✨ ";

  @override
  Widget build(BuildContext context) {
    print(widget.addedposting);

    final productPrice = widget.addedposting?["product price"];
    final productName = widget.addedposting?["product name"];
    final productDescription = widget.addedposting?["product description"];
    final productQuantity = widget.addedposting?["product quantity"];
    final Deliverydate = widget.addedposting?["Delivery Date"];
    final ContactEmail = widget.addedposting?["Contact email"];
    final Mobilenumber = widget.addedposting?["Mobile Number"];
    // final ImageURL = widget.addedposting?["Image URL"];
    String documentId;



    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/pastel.png"),
              fit: BoxFit.cover,
            )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  getAppbarTitle(),
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 30),
              child: widget.addedposting['All Requirements'] != null &&
                  widget.addedposting['All Requirements'] != null &&
                  widget.addedposting['All Requirements'].isNotEmpty
                  ? Column(children: [
                Flexible(
                  child: GridView.builder(
                    itemCount:
                    widget.addedposting['All Requirements'].length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 18.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      final addedp =
                      widget.addedposting['All Requirements'][index];

                      final productName = addedp?.productname;
                      final productPrice = addedp?.productprice;
                      final productDescription =
                          addedp?.productdescription;
                      final productQuantity = addedp?.productquantity;
                      final Deliverydate = addedp?.deliverydate;
                      final ContactEmail = addedp?.email;
                      final Mobilenumber = addedp?.mobile;

                      return Card(
                          elevation: 12,
                          color: Colors
                              .white70, // add some elevation to create a shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // round the edges of the card
                            side: BorderSide(
                                width: 1,
                                color: Colors
                                    .grey), // add a border around the card
                          ),
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(13),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "  • $productName •",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                            TextDecoration.underline,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ClipRRect(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Detail: $productDescription \nQuantity: $productQuantity \nAmount: $productPrice \nDelivery on: $Deliverydate ",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 19),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final url =
                                                'tel:$Mobilenumber';
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1),
                                            child: Row(children: [
                                              Icon(
                                                Icons.phone,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "$Mobilenumber",
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.blue,
                                                  decoration:
                                                  TextDecoration
                                                      .underline,
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: Color(0xFF006400),
                                            size: 20,
                                          ),
                                          SizedBox(width: 6),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () async {
                                                final Uri params = Uri(
                                                  scheme: 'mailto',
                                                  path: '$ContactEmail',
                                                );
                                                Uri emailUri = Uri.parse(
                                                    params.toString());
                                                if (await canLaunch(
                                                    emailUri
                                                        .toString())) {
                                                  await launch(emailUri
                                                      .toString());
                                                } else {
                                                  throw 'Could not launch $emailUri';
                                                }
                                              },
                                              child: Text(
                                                '$ContactEmail',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.blue,
                                                  decoration:
                                                  TextDecoration
                                                      .underline,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )
                          ]));
                    },
                  ),
                ),
              ])
                  : Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )));
  }
}
