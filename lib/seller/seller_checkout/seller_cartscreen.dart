import 'package:flutter/material.dart';
import 'package:services_android_app/Consumer_Screens/Consumer_mainpage.dart';
import 'delivered_screen.dart';
import '../../Providers/seller_cart_provider.dart' as cartprovider;
import '../cart.dart';
import '../cart_items.dart';
import 'shipping_screen.dart';

class CartScreen extends StatefulWidget {
  final cartprovider.CartProvider cartProvider;
  final Cart cart;

  const CartScreen({Key? key, required this.cartProvider, required this.cart})
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    updateTotal();
  }

  void updateTotal() {
    setState(() {
      total = widget.cartProvider.cart.calculateTotal();
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ConsumerMainPageScreen()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/page6.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ConsumerMainPageScreen()),
                );
              },
            ),
            elevation: 0,
          ),
          body: widget.cartProvider.cart.items.isEmpty
              ? Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Your cart is empty!\nAdd something to it🛒',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
              : Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartProvider.cart.items.length,
                    itemBuilder: (context, index) {
                      CartItem item = widget.cartProvider.cart.items[index];

                      return Dismissible(
                        key: Key(item.name),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            widget.cartProvider.removeCartItem(item);
                            updateTotal();
                          });
                          widget.cartProvider.cart.items.remove(item);
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10.0),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: item.imageUrl.startsWith('assets/')
                                  ? Image.asset(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                              )
                                  : Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                width: 70,
                                height: 70,
                              ),
                            ),
                            title: Text(
                              item.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Price: ${item.price.toStringAsFixed(0)}/-',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Text(
                                        '-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (item.quantity > 1) {
                                            widget.cartProvider
                                                .decreaseQuantity(item);
                                          } else {
                                            widget.cartProvider
                                                .removeCartItem(item);
                                          }
                                          updateTotal();
                                        });
                                      },
                                    ),
                                    Text(
                                      item.quantity.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Text(
                                        '+',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.cartProvider
                                              .increaseQuantity(item);
                                          updateTotal();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: widget.cartProvider.cart.items.isNotEmpty,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Total: ${widget.cartProvider.cart.calculateTotal().toStringAsFixed(2)}/-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Delivery: 150/-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(height: 2),
                        SizedBox(height: 10),
                        Text(
                          'Subtotal: ${(widget.cartProvider.cart.calculateTotal() + 150).toStringAsFixed(2)}/-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0,
                            color: Colors.black87,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: widget.cartProvider.cart.items.isEmpty
                      ? null
                      : () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ShippingScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffcc9a9d),
                    padding: EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    elevation: 2.0,
                    textStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
