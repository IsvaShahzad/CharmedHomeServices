import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../InitialScreens/ContinueAsConsumerOrSellerScreen.dart';
import 'Consumer_mainpage.dart';
import 'favourites.dart';

class ExploreConsumer extends StatefulWidget {
  @override
  State<ExploreConsumer> createState() => _ExploreConsumerState();
}

class _ExploreConsumerState extends State<ExploreConsumer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/page4.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.sp),
              bottomLeft: Radius.circular(12.sp),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.sp, // Responsive icon size
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ContinueAsScreen()),
              );
            },
          ),
        ),
        body: Container(
          child: Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w), // Responsive padding
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 200.h, // Responsive height
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Explore Consumer',
                        style: TextStyle(
                          fontSize: 32.sp, // Responsive font size
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h, // Responsive height
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xffcc9a9d),
                          elevation: 2,
                          minimumSize: Size(180.w, 45.h), // Responsive button size
                          maximumSize: Size(180.w, 45.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.sp),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConsumerMainPageScreen(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Continued as Consumer',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.sp, // Responsive font size
                                ),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 17.sp, // Responsive font size
                            fontFamily: 'Montserrat',
                          ),
                        ),
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
