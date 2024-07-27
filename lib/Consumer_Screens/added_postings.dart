// import 'package:flutter/material.dart';
// import 'package:services_android_app/Consumer_Screens/Consumer_mainpage.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import '../initialScreens/loginScreen.dart';
// import 'add_requirements_consumer.dart'; // Import the ConsumerMainPage screen
//
// class PostingDisplayedScreen extends StatefulWidget {
//   final Map<String, dynamic> addedposting;
//   final String id;
//
//   PostingDisplayedScreen({required this.addedposting, required this.id});
//
//   @override
//   _PostingDisplayedScreenState createState() => _PostingDisplayedScreenState();
// }
//
// class _PostingDisplayedScreenState extends State<PostingDisplayedScreen> {
//   int _selectedIndex = 0;
//   CollectionReference _collectionRef = FirebaseFirestore.instance.collection('AddRequirements');
//   late Stream<QuerySnapshot> _streamCategory = _collectionRef.snapshots();
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _streamCategory = _collectionRef.snapshots();
//   }
//
//   Future<void> removeRequirement(dynamic addedp) async {
//     setState(() {
//       widget.addedposting['All Requirements'].removeWhere((id) => id == addedp);
//     });
//     await FirebaseFirestore.instance
//         .collection('AddRequirements')
//         .doc(addedp.id)
//         .delete();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(widget.addedposting);
//
//     final productPrice = widget.addedposting["product price"];
//     final productName = widget.addedposting["product name"];
//     final productDescription = widget.addedposting["product description"];
//     final productQuantity = widget.addedposting["product quantity"];
//     final Deliverydate = widget.addedposting["Delivery Date"];
//     final ContactEmail = widget.addedposting["Contact email"];
//     final Mobilenumber = widget.addedposting["Mobile Number"];
//     // final ImageURL = widget.addedposting?["Image URL"];
//     String documentId;
//
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/page5.png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: ChangeNotifierProvider(
//         create: (context) => RequirementModel(
//           id: '',
//           productname: '',
//           productprice: '',
//           ImageURl: '',
//           productdescription: '',
//           productquantity: '',
//           email: '',
//           mobile: '',
//           deliverydate: '',
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(12),
//                 bottomLeft: Radius.circular(12),
//               ),
//             ),
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ConsumerMainPageScreen(), // Navigate to ConsumerMainPage
//                   ),
//                 );
//               },
//             ),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LoginScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//           body: Padding(
//             padding: EdgeInsets.only(top: 30),
//             child: widget.addedposting['All Requirements'] != null &&
//                 widget.addedposting['All Requirements'].isNotEmpty
//                 ? Column(
//               children: [
//                 Consumer<RequirementModel>(
//                   builder: (context, requirementModel, child) {
//                     return SizedBox(
//                       height: 638,
//                       child: GridView.builder(
//                         itemCount: widget.addedposting['All Requirements'].length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 18.0,
//                           crossAxisSpacing: 10.0,
//                         ),
//                         itemBuilder: (context, index) {
//                           final addedp = widget.addedposting['All Requirements'][index];
//
//                           final productName = addedp?.productname;
//                           final productPrice = addedp?.productprice;
//                           final productDescription = addedp?.productdescription;
//                           final productQuantity = addedp?.productquantity;
//                           final Deliverydate = addedp?.deliverydate;
//                           final ContactEmail = addedp?.email;
//                           final Mobilenumber = addedp?.mobile;
//
//                           return Card(
//                             elevation: 12,
//                             color: Colors.white70,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                               side: BorderSide(width: 1, color: Colors.grey),
//                             ),
//                             child: Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: EdgeInsets.all(13),
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: Text(
//                                             "  • $productName •",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               decoration: TextDecoration.underline,
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: ClipRRect(
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(horizontal: 6),
//                                             child: Align(
//                                               alignment: Alignment.center,
//                                               child: Text(
//                                                 "Detail: $productDescription \nQuantity: $productQuantity \nAmount: $productPrice \nDelivery on: $Deliverydate ",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 13,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 19),
//                                         child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: GestureDetector(
//                                             onTap: () async {
//                                               final url = 'tel:$Mobilenumber';
//                                               if (await canLaunch(url)) {
//                                                 await launch(url);
//                                               } else {
//                                                 throw 'Could not launch $url';
//                                               }
//                                             },
//                                             child: Padding(
//                                               padding: EdgeInsets.symmetric(horizontal: 1),
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.phone,
//                                                     color: Colors.black,
//                                                     size: 16,
//                                                   ),
//                                                   SizedBox(width: 8),
//                                                   Text(
//                                                     "$Mobilenumber",
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 13,
//                                                       color: Colors.blue,
//                                                       decoration: TextDecoration.underline,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 18),
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.email,
//                                               color: Color(0xFF006400),
//                                               size: 20,
//                                             ),
//                                             SizedBox(width: 6),
//                                             Expanded(
//                                               child: GestureDetector(
//                                                 onTap: () async {
//                                                   final Uri params = Uri(
//                                                     scheme: 'mailto',
//                                                     path: '$ContactEmail',
//                                                   );
//                                                   Uri emailUri = Uri.parse(params.toString());
//                                                   if (await canLaunch(emailUri.toString())) {
//                                                     await launch(emailUri.toString());
//                                                   } else {
//                                                     throw 'Could not launch $emailUri';
//                                                   }
//                                                 },
//                                                 child: Text(
//                                                   '$ContactEmail',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 13,
//                                                     color: Colors.blue,
//                                                     decoration: TextDecoration.underline,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             )
//                 : Center(
//               child: Text(
//                 'No products found',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20.0,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
