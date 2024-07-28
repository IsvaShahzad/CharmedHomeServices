import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../initialScreens/loginScreen.dart';
import '../Providers/seller_cart_provider.dart';
import '../seller/cart.dart';
import '../seller/seller_checkout/seller_cartscreen.dart' as cartscreen;
import '../Consumer_Screens/Consumer_Profile.dart';
import '../subcategory_screen/subcategoriesnew.dart';
import 'posted_requirement_screen.dart';
import 'explore_consumer_screen.dart';
import 'add_requirements_consumer.dart';
import 'added_postings.dart';
import 'ContactUs.dart';
import '../../seller/sellerwelcome.dart';
import 'package:services_android_app/seller/cart.dart' as cartt;

class ConsumerMainPageScreen extends StatefulWidget {
  @override
  _ConsumerMainPageScreenState createState() => _ConsumerMainPageScreenState();
}

class _ConsumerMainPageScreenState extends State<ConsumerMainPageScreen> {
  int _selectedIndex = 0;

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Category');

  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();

  String userFirstName = 'User'; // Default username if none is found

  @override
  void initState() {
    super.initState();
    _streamCategory = _collectionRef.snapshots();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => cartscreen.CartScreen(
            cart: Provider.of<Cart>(context, listen: false),
            cartProvider: Provider.of<CartProvider>(context, listen: false),
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConsumerProfile()),
      );
    }
  }

  Future<void> _saveCategoriesToFirestore() async {
    // Implementation for saving categories
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Returning false prevents the screen from being popped
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mainpage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor:
              Colors.transparent, // Make Scaffold background transparent
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                "",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width *
                0.03), // Adjust padding based on screen width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, $userFirstName!",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.06, // Adjust font size based on screen width
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.02), // Adjust spacing based on screen width
                Text(
                  'What would you like to explore today?',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.04, // Adjust font size based on screen width
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width *
                        0.08), // Adjust spacing based on screen width

                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _streamCategory,
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width >
                                    600
                                ? 3
                                : 2, // Adjust number of columns based on screen width
                            crossAxisSpacing: MediaQuery.of(context)
                                    .size
                                    .width *
                                0.01, // Adjust spacing based on screen width
                            mainAxisSpacing: MediaQuery.of(context).size.width *
                                0.01, // Adjust spacing based on screen width
                            childAspectRatio: 1.13,
                          ),
                          itemCount: docs.length,
                          itemBuilder: (_, i) {
                            final data = docs[i].data() as Map<String, dynamic>;

                            // Ensure 'subcategories' field is a List and not null
                            final subcategories =
                                (data['subcategories'] as List<dynamic>?)
                                        ?.map((sub) => sub['name'].toString())
                                        .toList() ??
                                    [];

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SubcategoryScreen(
                                    categoryName: data['name'], // Category name
                                    subcategories: subcategories,
                                    // Pass the list of subcategories
                                  ),
                                ));
                              },
                              child: Card(
                                elevation: 1.5,
                                child: GridTile(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      data['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  footer: GridTileBar(
                                    backgroundColor: Colors.black38,
                                    title: Text(
                                      data['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                        fontSize: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.04, // Adjust font size based on screen width
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: MediaQuery.of(context).size.width *
                        0.07, // Adjust icon size based on screen width
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: MediaQuery.of(context).size.width *
                        0.07, // Adjust icon size based on screen width
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width *
                        0.07, // Adjust icon size based on screen width
                  ),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white54,
              backgroundColor: Color(0xfff4b7be),
              onTap: _onItemTapped,
              selectedLabelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width *
                    0.035, // Adjust font size based on screen width
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                fontSize: MediaQuery.of(context).size.width *
                    0.035, // Adjust font size based on screen width
              ),
              type: BottomNavigationBarType
                  .fixed, // Ensures the bottom navigation bar is displayed correctly on various screen sizes
              elevation: 5, // Adjust elevation if needed
            ),
          ),
          drawer: Drawer(
            child: Container(
              decoration: BoxDecoration(
                color: Color(
                    0xfff4b7be), // Set the background color to pink hex code
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
                            color: Color(
                                0xfff4b7be), // Header color set to #FFA7A6
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 45, // Smaller radius for the avatar
                                backgroundImage:
                                    AssetImage('assets/images/avatarimage.png'),
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
                          height:
                              1, // To ensure the space between header and items is consistent
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffffd7d7), // Lighter pink for the tile
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
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
                            fontSize: 15),
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                      trailing: Icon(
                        Icons.home,
                        size: 19,
                        color: Color(0xff712643),
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 15),
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
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
                            fontSize: 15),
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
                              builder: (context) =>
                                  RequirementsDisplayScreen()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8), // Adjust space between items
                  Container(
                    color: Color(0xffffd7d7), // Lighter pink for the tile
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                      trailing: Icon(
                        Icons.add,
                        size: 19,
                        color: Color(0xff712643),
                      ),
                      title: Text(
                        "Add Requirements / Postings",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddRequirements(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8), // Adjust space between items
                  Container(
                    color: Color(0xffffd7d7), // Lighter pink for the tile
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                      trailing: Icon(
                        Icons.switch_account,
                        size: 19,
                        color: Color(0xff712643),
                      ),
                      title: Text(
                        "Switch to Seller",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 15),
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
                      trailing: Icon(
                        Icons.help,
                        size: 19,
                        color: Color(0xff712643),
                      ),
                      title: Text(
                        "Contact Us/ Help",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ContactUsScreen(userRole: 'consumer'),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 8), // Adjust space between items
                  Container(
                    color: Color(0xffffd7d7), // Lighter pink for the tile
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 17.0),
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
                            fontSize: 15),
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
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
      ),
    );
  }
}
