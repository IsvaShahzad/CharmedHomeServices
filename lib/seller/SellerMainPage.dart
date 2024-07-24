import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../Categories/subcategory_screen.dart';
import '../Consumer_Screens/ContactUs.dart';
import '../Consumer_Screens/add_requirements_consumer.dart';
import '../Providers/seller_cart_provider.dart';
import '../initialScreens/loginScreen.dart';
import 'Packaging_Screen.dart';
import 'SellerProfilePage.dart';
import 'addProduct.dart';
import '../seller/cart.dart' as cartt;
import 'seller_checkout/seller_cartscreen.dart' as cartscreen;
import 'seller_portfolio.dart';
import 'sellerwelcome.dart';
import 'show_postings_seller.dart';

class SellerHomePage extends StatefulWidget {
  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  int _selectedIndex = 0;

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('Category');

  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddProduct()),
      );
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SellerPortfolio()));
    }
  }

  @override
  void initState() {
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
          elevation: 13,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Seller Categories",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cartscreen.CartScreen(
                      cart: context.read<cartt.Cart>(),
                      cartProvider: context.read<CartProvider>(),

                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 80),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('Category').snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    final data = docs[i].data();
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            tileColor: Colors.white24,
                            trailing: Icon(
                              Icons.arrow_forward,
                              size: 20,
                              color: Colors.black,
                            ),
                            leading: data['name'] == "Tailoring"
                                ? Image(
                              image: AssetImage('assets/images/tailoring.png'),
                              width: 80.0,
                              height: 70.0,
                            )
                                : data['name'] == "Knitting"
                                ? Image(
                              image: AssetImage('assets/images/knittingpic.png'),
                              width: 80.0,
                              height: 70.0,
                            )
                                : data['name'] == "Baking"
                                ? Image(
                              image: AssetImage('assets/images/baking.png'),
                              width: 80.0,
                              height: 70.0,
                            )
                                : data['name'] == "Cooking"
                                ? Image(
                              image: AssetImage('assets/images/cooking.png'),
                              width: 80.0,
                              height: 70.0,
                            )
                                : data['name'] == "Arts & Crafts "
                                ? Image(
                              image: AssetImage('assets/images/ac.png'),
                            )
                                : Image(
                              image: AssetImage('assets/images/ac.png'),
                            ),
                            title: Text(
                              data['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              print("i am calling tap ");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SubcategoryScreen(
                                  categories: data,
                                ),
                              ));
                            },
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits_sharp),
              label: 'Add Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Portfolio',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        drawer: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/pastel.png"),
                  fit: BoxFit.cover)),
          child: Drawer(
            backgroundColor: Colors.transparent,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 80.h,
                ),
                Container(
                  height: 25.0,
                  child: DrawerHeader(
                    child: null,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.dashboard,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Dashboard",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SellerWelcome()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.category,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Categories",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SellerHomePage()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.person,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.post_add,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Show requirements/Postings",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    final addedReqSnapshot = await FirebaseFirestore.instance
                        .collection('AddRequirements')
                        .get();
                    final addedrequirements = addedReqSnapshot.docs
                        .map((doc) => RequirementModel.fromJson(doc.data()))
                        .toList();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerShowPostings(
                          addedposting: {'All Requirements': addedrequirements},
                          id: 'id',
                        ),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.backpack_rounded,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Select Packaging",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackagingScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.switch_account,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Switch to Consumer",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.help,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Contact us /Help",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUsScreen()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  tileColor: Colors.white38,
                  trailing: Icon(
                    Icons.logout,
                    size: 18,
                    color: Colors.purple,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
