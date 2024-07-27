import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:services_android_app/Consumer_Screens/Consumer_mainpage.dart';
import 'package:services_android_app/Consumer_Screens/explore_consumer_screen.dart';
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
        MaterialPageRoute(builder: (context) => SellerPortfolio()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "",
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
          padding: EdgeInsets.all(10),
          child: GridView.count(
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
                }, imageUrl: '',
              ),
              _buildGridTile(
                title: 'Show Requirements/Postings',
                icon: Icons.calendar_view_month_rounded,
                onTap: () async {
                  final addedReqSnapshot = await FirebaseFirestore.instance
                      .collection('AddRequirements')
                      .get();
                  final addedrequirements = addedReqSnapshot.docs
                      .map((doc) => RequirementModel.fromJson(doc.data()))
                      .toList();

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PostingDisplayedScreen(
                  //       addedposting: {
                  //         'All Requirements': addedrequirements,
                  //       },
                  //       id: 'id',
                  //     ),
                  //   ),
                  // );
                }, imageUrl: '',
              ),
              _buildGridTile(
                title: 'Added Products',
                icon: Icons.check_box,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConsumerMainPageScreen()),
                  );
                },
                imageUrl: 'assets/images/baking.jpeg', // Replace with your asset image path
              ),

              _buildGridTile(
                title: 'Portfolio',
                icon: Icons.folder,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SellerPortfolio()),
                  );
                }, imageUrl: '',
              ),


            ],
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
          backgroundColor: Color(0xffffa7a6), // Background color of the bottom navigation bar
          selectedItemColor: Colors.white, // Color of the selected item
          unselectedItemColor: Color(0xffffd7d7), // Color of the unselected items
        ),

        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffffa7a6), // Set the background color to pink hex code
            ),
            child: ListView(
              padding: EdgeInsets.zero, // Ensure no padding at the top
              children: <Widget>[
                Container(
                  color: Color(0xffffa7a6), // Header color set to #FFA7A6
                  child: Column(
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color(0xffffa7a6), // Header color set to #FFA7A6
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
                              'Welcome $userFirstName',
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
                      "View posted requirements",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          fontSize: 15

                      ),
                    ),
                    onTap: () async {
                      final addedReqSnapshot = await FirebaseFirestore.instance
                          .collection('AddRequirements')
                          .get();
                      final addedrequirements = addedReqSnapshot.docs
                          .map((doc) => RequirementModel.fromJson(doc.data()))
                          .toList();

                      // Navigator.push(
                      //   context,
                        // MaterialPageRoute(
                        //   builder: (context) => PostingDisplayedScreen(
                        //     addedposting: {
                        //       'All Requirements': addedrequirements,
                        //     },
                        //     id: 'id',
                        //   ),
                        // ),
                      // );
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
                      "Contac us/Help",
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
                        MaterialPageRoute(builder: (context) => ContactUsScreen()),
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
                      "Log out",
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
    required String imageUrl, // Make imageUrl a required parameter
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GridTile(
        child: Container(
          // Set the size constraints for the container
          constraints: BoxConstraints.expand(),
          child: AspectRatio(
            aspectRatio: 1, // Use 1:1 aspect ratio for a square grid tile
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover, // Ensures the image covers the entire tile
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(title),
          leading: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }



  Widget _buildConsumerGridTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 50),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
