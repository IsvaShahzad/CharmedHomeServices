import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Consumer_Screens/favourites.dart';
import '../../Detail_Screens/Baking_DetailScreen/Brownies_Detail.dart';
import '../../initialScreens/loginScreen.dart';


class BrowniesScreen extends StatefulWidget {
  final Map<String, dynamic> added;

  final String productName;
  final String id;
  final double productPrice;
  final String productDescription;
  final String ImageURL;
  final Product product;
  final String companyName;

  const BrowniesScreen({
    Key? key,
    required this.added,
    required this.productName,
    required this.id,
    required this.productPrice,
    required this.productDescription,
    required this.ImageURL,
    required this.product,
    required this.companyName,

  }) : super(key: key);

  @override
  _BrowniesScreenState createState() => _BrowniesScreenState();
}

class _BrowniesScreenState extends State<BrowniesScreen> {
  int _selectedIndex = 0;

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('addproducts');

  late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamCategory = _collectionRef.snapshots();
  }

  // String getAppbarTitle() => "Add products ${widget.added['product price']}";
  String getAppbarTitle() => "Brownies ";

  @override
  Widget build(BuildContext context) {
    print(widget.added);

    final productPrice = widget.added?["product price"];
    final productName = widget.added?["product name"];
    final productDescription = widget.added?["product description"];
    final ImageURL = widget.added?["Image URL"];




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
              fit: BoxFit.cover,
            )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  getAppbarTitle(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              actions: <Widget>[


                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      _showFavoriteOptions(context);
                    },
                  ),
                ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 30),
              child: widget.added != null &&
                  widget.added['brownieslist'] != null &&
                  widget.added['brownieslist'].isNotEmpty
                  ? GridView.builder(
                itemCount: widget.added['brownieslist'].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  final addedproductss = widget.added['brownieslist'][index];

                  final ImageURL = addedproductss.ImageURl;
                  final productName = addedproductss.productname;
                  final productPrice = addedproductss.productprice;
                  final productDescription = addedproductss.productdescription;
                  final product = addedproductss.product;
                  final companyName = addedproductss.companyName;




                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BrowniesDetailScreen(
                                productName: productName,
                                productPrice: productPrice,
                                productDescription:
                                productDescription,
                                ImageURL: ImageURL,
                                companyName: companyName,

                              )));
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.white70,// add some elevation to create a shadow effect
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // round the edges of the card
                        side: BorderSide(width: 1, color: Colors.grey), // add a border around the card
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(ImageURL),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              " $companyName\n $productName \n Rs.$productPrice",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );


                },
              )
                  : Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )


        ));
  }
}
