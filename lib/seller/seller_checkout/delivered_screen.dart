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
          image: AssetImage("assets/images/pastel.png"),
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
                Colors.blue,
                Colors.red,
                Colors.yellow,
                Colors.green,
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SellerHomePage(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 80.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 51),
                      child: Text(
                        'Order Placed Successfully! 🎉',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                            elevation: 15,
                            minimumSize: const Size(150, 50),
                            maximumSize: const Size(150, 50),
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SellerHomePage()));
                          },
                          child: Text('Go to Homepage'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                            elevation: 12,
                            minimumSize: const Size(160, 50),
                            maximumSize: const Size(160, 50),
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ConsumerMainPageScreen()));
                          },
                          child: Text('Continue Browsing'),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                          elevation: 12,
                          minimumSize: const Size(150, 50),
                          maximumSize: const Size(150, 50),
                          shape: StadiumBorder(),
                        ),
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
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),

                                  ],
                                ),
                                actions: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                        elevation: 6,
                                        minimumSize: const Size(140, 45),
                                        maximumSize: const Size(140, 45),
                                        shape: StadiumBorder(),
                                      ),
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
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

                        child: Text('Order Status'),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 75),
                      child: Align(
                        alignment: Alignment.center,
                        child: Card(
                          elevation: 14,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            width: 220.0, // Update the desired width
                            height: 170.0, // Update the desired height
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Rate Us',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 16.0),
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
                                    elevation: 10,
                                    minimumSize: const Size(120, 40),
                                    foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Thank you for rating! ⭐"),
                                          actions: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                                  elevation: 6,
                                                  minimumSize: const Size(140, 45),
                                                  maximumSize: const Size(140, 45),
                                                  shape: StadiumBorder(),
                                                ),
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                                    'Submit',
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
