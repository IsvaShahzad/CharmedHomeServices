import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';

import '../initialScreens/loginScreen.dart';
import '../main.dart';

//
class Product with ChangeNotifier {
  final String ImageURL;
  final String productName;
  final String productDescription;
  final double productPrice;


  Product({
    required this.ImageURL,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
  });
}

class FavouriteProductPageProvider extends ChangeNotifier {
  List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;


  bool isFavorite(Product product) {
    return _favoriteProducts.contains(product);
  }

  void addFavoriteProduct(Product product) {
    print('Adding product $product to favorites');

    _favoriteProducts.add(product);
    print('Favorite products: $_favoriteProducts');
    notifyListeners();
  }

  void removeFavoriteProduct(Product product) {
    print('Removing product $product from favorites');
    _favoriteProducts.remove(product);
    print('Favorite products: $_favoriteProducts');

    notifyListeners();
  }


}

class FavoriteProductsPage extends StatefulWidget {
  final String ImageURL;
  final String productName;
  final String productDescription;
  final double productPrice;

  const FavoriteProductsPage({
    required this.ImageURL,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
  });

  @override
  _FavoriteProductsPageState createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<FavouriteProductPageProvider>();
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
          elevation: 13,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
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
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Favourites  ❤ ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: model.favoriteProducts.isEmpty
                      ? Center(
                          child: Text(
                            "No products added",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount:model.favoriteProducts.length,
                          itemBuilder: (context, index) {
                            print(
                                'favoriteProducts length: ${model.favoriteProducts.length}');



                            final product = model.favoriteProducts[index];


                            return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60),
                                child: Card(
                                  elevation: 5,
                                  color: Colors
                                      .white70, // add some elevation to create a shadow effect
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // round the edges of the card
                                    side: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          product?.ImageURL ?? '',
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product.productName ?? '',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              '\Rs.${product?.productPrice ?? ''}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          product?.productDescription ?? '',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
