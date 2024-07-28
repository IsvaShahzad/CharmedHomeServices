import 'package:flutter/material.dart';
import 'package:services_android_app/seller/SellerMainPage.dart';
import 'Consumer_mainpage.dart';

class ContactUsScreen extends StatefulWidget {
  final String userRole;

  ContactUsScreen({required this.userRole}); // Add a constructor to accept the user role

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/page5.png"),
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
              bottomRight: Radius.circular(13),
              bottomLeft: Radius.circular(12),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0), // Adjust this value to move the icon upwards
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xffb38e8e),
              ),
              onPressed: () {
                if (widget.userRole == 'consumer') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConsumerMainPageScreen()),
                  );
                } else if (widget.userRole == 'seller') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SellerHomePage()),
                  );
                }
              },
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.0),
              Text(
                "We're dedicated to assisting you. For any questions or support, please contact us using the information provided.",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'For Contact:',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                'Email: charmedservices@gmail.com',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'Phone: 03335206478',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 50.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '* Assistance is available 24/7 *',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}
