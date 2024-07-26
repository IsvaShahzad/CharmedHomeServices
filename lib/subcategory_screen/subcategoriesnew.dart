import 'package:flutter/material.dart';
import 'package:services_android_app/productlisting_screen/productlistscreennew.dart';
import 'package:services_android_app/seller/cart.dart'; // Update with your actual cart path
import 'package:services_android_app/Providers/seller_cart_provider.dart' as cartprovider;
import 'package:services_android_app/seller/seller_checkout/seller_cartscreen.dart';
import '../../../seller/cart.dart' as cartt;
import '../../../seller/seller_checkout/seller_cartscreen.dart' as cartscreen;
import 'package:provider/provider.dart';


import '../Providers/seller_cart_provider.dart';

class SubcategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<String> subcategories;

  // Constructor with required parameters
  SubcategoryScreen({
    required this.categoryName,
    required this.subcategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => cartscreen.CartScreen(
                    cart: Provider.of<cartt.Cart>(context, listen: false),
                    cartProvider: Provider.of<cartprovider.CartProvider>(context, listen: false),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: subcategories.length,
          itemBuilder: (context, index) {
            final subcategory = subcategories[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductListScreen(
                    categoryName: categoryName,
                    subcategoryName: subcategory,
                  ),
                ));
              },
              child: GridTile(
                child: Card(
                  elevation: 5,
                  child: Center(
                    child: Text(
                      subcategory,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
