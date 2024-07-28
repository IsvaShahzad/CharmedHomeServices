import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Detail_Screens/Packages_DetailScreen/package_detail.dart';
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


  @override
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    // Access the CartProvider
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/packaging.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SellerHomePage()),
              );
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 110.0), // Add vertical padding
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two tiles per row
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              childAspectRatio: 3 / 4, // Adjust aspect ratio for card size
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return CardWidget(
                itemName: index == 0
                    ? "Cardboard"
                    : index == 1
                    ? "Poly mailers"
                    : index == 2
                    ? "Ziplock bags"
                    : "Shrink Wrap",
                price: index == 0
                    ? 500
                    : index == 1
                    ? 250
                    : index == 2
                    ? 200
                    : 250,
                description: index == 0
                    ? "Cardboard 5x5 box"
                    : index == 1
                    ? "Plastic packing for small items"
                    : index == 2
                    ? "Packing for small items"
                    : "Heat sealed packaging",
                imageUrl: index == 0
                    ? "assets/images/cardboard.jpg"
                    : index == 1
                    ? "assets/images/polymailers.jpg"
                    : index == 2
                    ? "assets/images/ziplock.jpg"
                    : "assets/images/shrink1.jpeg",
              );
            },
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
            builder: (context) => PackageDetailScreen(
              packageName: itemName,
              packagePrice: price,
              packageDescription: description,
              packageImageURL: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "\£${price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
