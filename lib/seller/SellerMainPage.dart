import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:services_android_app/Consumer_Screens/Consumer_mainpage.dart';
import 'package:services_android_app/Consumer_Screens/explore_consumer_screen.dart';
import 'package:services_android_app/Consumer_Screens/posted_requirement_screen.dart';
import '../Consumer_Screens/ContactUs.dart';
import '../Consumer_Screens/add_requirements_consumer.dart';
import '../Consumer_Screens/added_postings.dart';
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
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Category');
  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();
  String userFirstName = 'User'; // Default username if none is found

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _saveCategoriesToFirestore(); // Save categories on init
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          userFirstName = userDoc['firstname'] ?? 'User';
        });
      }
    }
  }

  Future<void> _saveCategoriesToFirestore() async {
    // Implementation for saving categories
  }

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
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/mainpage.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
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
          padding: EdgeInsets.all(10),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(top: 130), // Add padding here
          child:
          GridView.count(
            crossAxisCount: 2,

            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: <Widget>[
              _buildGridTile(
                title: 'Add Products',
                icon: Icons.add,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProduct()),
                  );
                },
                imageUrl: 'assets/images/addproduct.jpg',
              ),
              _buildGridTile(
                title: 'Help',
                icon: Icons.help,
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
                      builder: (context) => ContactUsScreen()
                    ),
                  );
                },
                imageUrl: 'assets/images/help.jpg',
              ),
              _buildGridTile(
                title: 'Packaging',
                icon: Icons.check_box,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PackagingScreen()),
                  );
                },
                imageUrl:
                'assets/images/packaging.avif', // Replace with your asset image path
              ),
              _buildGridTile(
                title: 'Portfolio',
                icon: Icons.folder,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SellerPortfolio()),
                  );
                },
                imageUrl: 'assets/images/portfolio.jpeg',
              ),
            ],
          ),
        ),
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
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Color(0xfff4b7be), // Background color of the bottom navigation bar
          selectedItemColor: Colors.white, // Color of the selected item
          unselectedItemColor: Color(0xffffd7d7), // Color of the unselected items
        ),

        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xfff4b7be), // Set the background color to pink hex code
            ),
            child: ListView(
              padding: EdgeInsets.zero, // Ensure no padding at the top
              children: <Widget>[
                Container(
                  color: Color(0xfff4b7be), // Header color set to #FFA7A6
                  child: Column(
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xfff4b7be), // Header color set to #FFA7A6
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 45, // Smaller radius for the avatar
                              backgroundImage: AssetImage('assets/images/avatarimage.png'),
                              // Use NetworkImage for online images
                              // backgroundImage: NetworkImage('https://example.com/avatar.png'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Welcome, $userFirstName',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Smaller font size
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // This Container is used to prevent the default divider line below the DrawerHeader
                      Container(
                        color: Color(0xffffa7a6),
                        height: 1, // To ensure the space between header and items is consistent
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffffd7d7), // Lighter pink for the tile
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                    trailing: Icon(
                      Icons.dashboard,
                      size: 19,
                      color: Color(0xff712643),
                    ),
                    title: Text(
                      "Dashboard",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerWelcome(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8), // Adjust space between items
                Container(
                  color: Color(0xffffd7d7), // Lighter pink for the tile
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                    trailing: Icon(
                      Icons.home,
                      size: 19,
                      color: Color(0xff712643),

                    ),
                    title: Text(
                      "Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15


                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConsumerMainPageScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8), // Adjust space between items
                Container(
                  color: Color(0xffffd7d7), // Lighter pink for the tile
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                    trailing: Icon(
                      Icons.post_add,
                      size: 19,
                      color: Color(0xff712643),
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15

                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8), // Adjust space between items
                Container(
                  color: Color(0xffffd7d7), // Lighter pink for the tile
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                    trailing: Icon(
                      Icons.calendar_view_month_rounded,
                      size: 19,
                      color: Color(0xff712643),
                    ),
                    title: Text(
                      "View Posted Requirements",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15

                      ),
                    ),
                    onTap: () async {
                      // final addedReqSnapshot = await FirebaseFirestore.instance
                      //     .collection('AddRequirements')
                      //     .get();
                      // final addedrequirements = addedReqSnapshot.docs
                      //     .map((doc) => RequirementModel.fromJson(doc.data()))
                      //     .toList();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequirementsDisplayScreen()
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 8), // Adjust space between items
                Container(
                  color: Color(0xffffd7d7), // Lighter pink for the tile
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                    trailing: Icon(
                      Icons.switch_account,
                      size: 19,
                      color: Color(0xff712643),
                    ),
                    title: Text(
                      "Select Packaging",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15

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
                ),
                SizedBox(height: 8), // Adjust space between items
                Container(
                  color: Color(0xffffd7d7), // Lighter pink for the tile
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                    trailing: Icon(
                      Icons.help,
                      size: 19,
                      color: Color(0xff712643),
                    ),
                    title: Text(
                      "Switch to Consumer",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15

                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExploreConsumer(),
                        ),
                      );
                    },
                  ),
                ),


                SizedBox(height: 8), // Adjust space between items
                Container(
                  color: Color(0xffffd7d7), // Lighter pink for the tile
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                    trailing: Icon(
                      Icons.logout,
                      size: 19,
                      color: Color(0xff712643),
                    ),
                    title: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15

                      ),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ),
                // No Divider here
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required String imageUrl,
  }) {
    return Material(
      elevation: 8.0, // Adjust the elevation as needed
      borderRadius: BorderRadius.circular(2.0),
      child: InkWell(
        onTap: onTap,
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover, // Ensures the image covers the entire tile
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38, // Background color of the strip
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2.0),
                    bottomRight: Radius.circular(2.0),
                  ),
                ),
                padding: EdgeInsets.all(8.0), // Padding around the text
                child: Row(
                  children: <Widget>[
                    Icon(icon, color: Colors.white),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, // Ensure text does not overflow
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

