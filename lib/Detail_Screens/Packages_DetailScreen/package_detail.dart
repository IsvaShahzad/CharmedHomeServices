import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart';
import '../../Providers/seller_cart_provider.dart';
import '../../seller/cart_items.dart';
import '../../seller/cart_provider.dart';
import 'package:provider/provider.dart';
import '../../seller/cart.dart' as cartt;
import '../../seller/seller_checkout/seller_cartscreen.dart' as cartscreen;
import 'package:badges/badges.dart' as badges;


class PackageDetailScreen extends StatefulWidget {
  final String packageName;
  final double packagePrice;
  final String packageDescription;
  final String packageImageURL;

  const PackageDetailScreen({
    Key? key,
    required this.packageName,
    required this.packagePrice,
    required this.packageDescription,
    required this.packageImageURL,
  }) : super(key: key);

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  int _quantity = 1;
  bool _isFavorite = false;

  Cart cart = Cart();

  void showCartMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Added to Cart', style: TextStyle(
        fontFamily: 'Montserrat',
      ),),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => cartscreen.CartScreen(
                        cart: Provider.of<cartt.Cart>(context, listen: false),
                        cartProvider:
                            Provider.of<CartProvider>(context, listen: false),
                      ),
                    ),
                  );
                },
                child: badges.Badge(
                  child: Icon(Icons.shopping_bag_outlined),
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Text(
                        cartProvider.counter.toString(),
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 60.0),
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   // image: AssetImage("assets/images/pastel.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    widget.packageImageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 11.0),
                      child: Text(
                        widget.packageName,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                            fontFamily: 'Montserrat'

                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11.0),
                      child: Text(
                        ' ${widget.packageDescription}',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                          'Rs.${widget.packagePrice.toInt()}',
                        style: TextStyle(
                          fontSize: 17.0,
                            fontFamily: 'Montserrat'

                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            CartItem item = CartItem(
                              name: widget.packageName,
                              price: widget.packagePrice,
                              imageUrl: widget.packageImageURL,
                              id: null,
                            );
                            Provider.of<CartProvider>(context, listen: false)
                                .addCartItem(item);

                            showCartMessage(context);
                            print(
                                'Added to cart: $item'); // Print the item to the console
                          });
                          Provider.of<CartProvider>(context, listen: false).updateCounter();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => cartscreen.CartScreen(
                                    cart: Provider.of<cartt.Cart>(context, listen: false),
                                    cartProvider:
                                    Provider.of<CartProvider>(context, listen: false),

                                  )));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shopping_cart),
                            SizedBox(width: 8.0),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Montserrat'
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color(0xffcc9a9d),

                          elevation: 1,
                          minimumSize: const Size(240, 50),
                          maximumSize: const Size(240, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
