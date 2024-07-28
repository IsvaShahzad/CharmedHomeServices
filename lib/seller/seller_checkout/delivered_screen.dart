import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Consumer_Screens/Consumer_mainpage.dart';
import '../SellerMainPage.dart';

class DeliveredScreen extends StatefulWidget {
  @override
  _DeliveredScreenState createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends State<DeliveredScreen> {
  late ConfettiController _confettiController;
  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void triggerConfetti() {
    _confettiController.play();
  }

  double _rating = 0;
  final CollectionReference ratingsCollection = FirebaseFirestore.instance.collection('ratings');

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
        body: Stack(
          children: [
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -3.1415 / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              shouldLoop: true,
              colors: const [
                Color(0xffcc9a9d),
                Color(0xffdcfffb),
                Color(0xffc1bbdd),
                Color(0xffc1bbdd),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 100.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Order Placed Successfully!',
                        // textAlign: TextAlign.center, // Center the text within its bounds
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color(0xffcc9a9d),

                          elevation: 1,
                          minimumSize: const Size(230, 50),
                          maximumSize: const Size(230, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0), // Circular square shape
                          ),                      ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ConsumerMainPageScreen()));
                        },
                        child: Text('Continue Browsing', style: TextStyle(
                          fontFamily: 'Montserrat'
                        ),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.center,
                      child: Text('Or', style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold
                      ),),
                    ),

                    SizedBox(height: 15),

                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color(0xffcc9a9d),

                          elevation: 1,
                          minimumSize: const Size(230, 50),
                          maximumSize: const Size(230, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0), // Circular square shape
                          ),                      ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Column(
                                  children: [
                                    Text(
                                      "Your order will be delivered in 40 minutes!⏳",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.black87,
                                        fontFamily: 'Montserrat'
                                      ),
                                    ),

                                  ],
                                ),
                                actions: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Color(0xffcc9a9d),

                                        elevation: 6,
                                        minimumSize: const Size(140, 45),
                                        maximumSize: const Size(140, 45),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0.0), // Square shape
                                        ),
                                      ),
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          fontFamily: 'Montserrat'
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },

                        child: Text('Order Status', style: TextStyle(
                          fontFamily: 'Montserrat'
                        ),),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Align(
                        alignment: Alignment.center,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            width: 250.0, // Update the desired width
                            height: 220.0, // Update the desired height
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Rate Us',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    fontFamily: 'Montserrat'
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                RatingBar.builder(
                                  initialRating: _rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  unratedColor: Colors.grey,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      _rating = rating;
                                    });
                                  },
                                ),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 1,
                                    minimumSize: const Size(120, 40),
                                    foregroundColor: Colors.white, backgroundColor: Color(0xffcc9a9d),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Thank you for rating! ⭐", style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 19
                                          ),),
                                          actions: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white, backgroundColor: Color(0xffcc9a9d),

                                                  elevation: 1,
                                                  minimumSize: const Size(140, 45),
                                                  maximumSize: const Size(140, 45),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                ),
                                                onPressed: () {
                                                  // Store the rating in Firebase
                                                  double rating = _rating;

                                                  // Create a new document in the ratings collection
                                                  ratingsCollection.add({
                                                    'rating': rating,
                                                    // Add other relevant data here
                                                  }).then((value) {
                                                    // Document added successfully
                                                    print('Rating stored in Firestore!');
                                                    Navigator.pop(context);
                                                  }).catchError((error) {
                                                    // An error occurred while adding the document
                                                    print('Failed to store rating: $error');
                                                    // Handle the error appropriately
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },

                                  child: const Text(
                                    'Submit',style: TextStyle(
                                    fontFamily: 'Montserrat'
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
