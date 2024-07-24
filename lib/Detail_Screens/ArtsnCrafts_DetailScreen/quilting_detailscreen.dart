import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Consumer_Screens/favourites.dart';
import '../../Providers/seller_cart_provider.dart';
import '../../initialScreens/loginScreen.dart';
import '../../seller/cart.dart';
import '../../seller/cart_items.dart';
import '../../seller/seller_portfolio.dart';
import '../../seller/cart.dart' as cartt;
import '../../seller/seller_checkout/seller_cartscreen.dart' as cartscreen;
import 'package:badges/badges.dart' as badges;



class QuiltingDetailScreen extends StatefulWidget {
  final String productName;
  final double productPrice;
  final String productDescription;
  final String ImageURL;
  final String companyName;


  const QuiltingDetailScreen({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.ImageURL,
    required this.companyName,

  }) : super(key: key);

  @override
  State<QuiltingDetailScreen> createState() => _QuiltingDetailScreenState();
}

class _QuiltingDetailScreenState extends State<QuiltingDetailScreen> {
  int _quantity = 1;
  bool _isFavorite = false;
  @override

  void navigateToSellerPortfolio(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SellerPortfolio()),
    );
  }


  void showCartMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Added to Cart'),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => cartscreen.CartScreen(
                    cart: Provider.of<cartt.Cart>(context, listen: false),
                    cartProvider: Provider.of<CartProvider>(context, listen: false),
                  ),
                ),
              );
            },
            child: Text(
              'Go to Cart',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final favoriteProductsModel =
    Provider.of<FavouriteProductPageProvider>(context, listen: false);

    void _showFavoriteOptions(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                // leading: Icon(Icons.favorite),
                title: Text('❤         Favourites '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoriteProductsPage(
                          ImageURL: widget.ImageURL,
                          productName: widget.productName,
                          productDescription: widget.productDescription,
                          productPrice: widget.productPrice,
                        )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Perform the logout action
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pastel.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.companyName ??'' ),
          centerTitle: true,
          actions: [
            Center(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => cartscreen.CartScreen(
                                cart: Provider.of<cartt.Cart>(context,
                                    listen: false),
                                cartProvider: Provider.of<CartProvider>(
                                    context,
                                    listen: false),
                              )));
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
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      _showFavoriteOptions(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 250.0,
              flexibleSpace:
              FlexibleSpaceBar(
                background: Image.network(
                  widget.ImageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11.0),
                    child: Text(
                      widget.productName,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      '${widget.productDescription}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Rs.${widget.productPrice}',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {


                        setState(() {

                          CartItem item = CartItem(
                            name: widget.productName,
                            price: widget.productPrice,
                            imageUrl: widget.ImageURL,
                            id: null,
                          );
                          Provider.of<CartProvider>(context, listen: false)
                              .addCartItem(item);

                          showCartMessage(context);
                          print(
                              'Added to cart: $item'); // Print the item to the console
                        });



                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => cartscreen.CartScreen(
                        //       cart: Provider.of<cartt.Cart>(context,
                        //           listen: false),
                        //       cartProvider: Provider.of<CartProvider>(context),
                        //     ),
                        //   ),
                        // );
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
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                        elevation: 6,
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Add some spacing between the icons
            // FloatingActionButton.extended(
            //   onPressed: () {
            //     navigateToSellerPortfolio(context);
            //   },
            //   icon: Icon(Icons.person),
            //   label: Text('Seller Portfolio'),
            //   backgroundColor: Colors.white,
            //   foregroundColor: Color(0xFFAB47BC),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20.0),
            //   ),
            // ),
            SizedBox(width: 75.0),

            FloatingActionButton(
              child: _isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });

                final product = Product(
                  ImageURL: widget.ImageURL,
                  productName: widget.productName,
                  productDescription: widget.productDescription,
                  productPrice: widget.productPrice,
                );

                // Add the product to favorites
                if (_isFavorite) {
                  favoriteProductsModel.addFavoriteProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to favorites'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  favoriteProductsModel.removeFavoriteProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Removed from favorites'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
            ),
            SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
