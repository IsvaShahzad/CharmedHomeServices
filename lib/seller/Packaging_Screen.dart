import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Detail_Screens/Packages_DetailScreen/box_detailscreen.dart';
import '../Providers/seller_cart_provider.dart';
import 'SellerMainPage.dart';

class PackagingScreen extends StatefulWidget {
  @override
  _PackagingScreenState createState() => _PackagingScreenState();
}

class _PackagingScreenState extends State<PackagingScreen> {
  int _selectedIndex = 0;

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('addproducts');

  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _streamCategory = _collectionRef.snapshots();
  }

  String getAppbarTitle() => "Packages 📦 ";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    // Access the CartProvider
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pastel.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              getAppbarTitle(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SellerHomePage()),
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 75),
            children: <Widget>[
              Container(
                width: double.infinity,
                child: CardWidget(
                  itemName: "Box",
                  price: 500,
                  description: "Cardboard 5x5 box",
                  imageUrl: "assets/images/box.png",
                ),
              ),

              Container(
                width: double.infinity,
                child: CardWidget(
                  itemName: "Poly mailers",
                  price: 250,
                  description: "Plastic packing for small items",
                  imageUrl: "assets/images/pm.png",
                ),
              ),
              Container(
                width: double.infinity,
                child: CardWidget(
                  itemName: "Ziplock bags",
                  price: 200,
                  description: "Packing for small items",
                  imageUrl: "assets/images/zipbag.png",
                ),
              ),

              Container(
                width: double.infinity,
                child: CardWidget(
                  itemName: "Lean box",
                  price: 250,
                  description: "Cardbox box",
                  imageUrl: "assets/images/leanbox.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CardWidget extends StatelessWidget {
  final String itemName;
  final double price;
  final String description;
  final String imageUrl;

  CardWidget({
    required this.itemName,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Box_DetailScreen(
              packageName: itemName,
              packagePrice: price,
              packageDescription: description,
              packageImageURL: imageUrl,

            ),
          ),
        );
      },

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Card(
          elevation: 5,
          color: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "$itemName\n$price\n$description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
