import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../initialScreens/loginScreen.dart';
import '../seller/seller_portfolio.dart';


class seller_cooking_screen extends StatefulWidget {
  @override
  _seller_cooking_screenState createState() => _seller_cooking_screenState();
}

class _seller_cooking_screenState extends State<seller_cooking_screen> {
  int _selectedIndex = 0;

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Category');

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pastel.png"),
              fit: BoxFit.cover)),
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
              "sub categories cooking",
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream:
                FirebaseFirestore.instance.collection('Category').snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                final docs = snapshot.data?.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: docs!.length,
                  itemBuilder: (_, i) {
                    final data = docs[i].data();
                    return ListView.builder(
                      itemCount: data['subcategories'].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                            trailing: Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.black,
                            ),
                            title: Text(
                              data['name'] == "Cooking"
                                  ? data['subcategories'][index]['name']
                                          .toString() ??
                                      ""
                                  : "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              if (index == 0) {
                                if (data['name'] == "Cooking") {
                                  Text(data['subcategories'].toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SellerPortfolio()));
                                }
                              } else if (index == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              }
                              Divider();
                            });
                      },
                    );
                  },
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
