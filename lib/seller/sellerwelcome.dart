import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../initialScreens/ContinueAsConsumerOrSellerScreen.dart';
import '../initialScreens/loginScreen.dart';
import 'SellerMainPage.dart';

class SellerWelcome extends StatefulWidget {
  @override
  State<SellerWelcome> createState() => _SellerWelcomeState();
}

class _SellerWelcomeState extends State<SellerWelcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/lb.png"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 13,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ContinueAsScreen()));
              },
            ),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Container(
            child: Form(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 240.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text('Explore seller ',
                                  style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    minimumSize: const Size(180, 50),
                                    maximumSize: const Size(180, 50),
                                    foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SellerHomePage()));

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Continued as Seller'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Next ',
                                  )),
                            )
                          ]),
                    ))),
          )),
    );
  }
}
