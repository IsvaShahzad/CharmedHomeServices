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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/page8.png'), // Update with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Column for app bar and list
          Column(
            children: [
              // App bar
              AppBar(
                backgroundColor: Colors.transparent, // Make app bar transparent
                elevation: 0, // Remove app bar shadow
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white), // Set back button color to white
                  onPressed: () {
                    Navigator.of(context).pop(); // Navigate back
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white), // Change icon color
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
              // Add padding to move the list tiles down
              SizedBox(height: 70.0), // Adjust the height value as needed
              // List view with subcategories
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: ListView.builder(
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
                        child: Card(
                          color: Colors.white,
                          elevation: 1,
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: ListTile(
                            title: Text(
                              subcategory,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.all(6.0),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
