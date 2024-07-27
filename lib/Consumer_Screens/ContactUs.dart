import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Consumer_mainpage.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'craftyhands90@gmail.com',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      try {
        await launchUrl(emailLaunchUri);
      } catch (e) {
        print('Error launching email app: $e');
        // Provide an alternative method, e.g., open a web-based email service
        _openWebEmail();
      }
    } else {
      print('Could not launch email app');
      // Provide an alternative method, e.g., open a web-based email service
      _openWebEmail();
    }
  }

  void _makePhoneCall() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '03335206478',
    );
    if (await canLaunchUrl(phoneLaunchUri)) {
      try {
        await launchUrl(phoneLaunchUri);
      } catch (e) {
        print('Error launching phone dialer: $e');
        // Provide an alternative method, e.g., display a message with the phone number
        _displayPhoneNumber();
      }
    } else {
      print('Could not launch phone dialer');
      // Provide an alternative method, e.g., display a message with the phone number
      _displayPhoneNumber();
    }
  }

  void _openWebEmail() {
    // Open a web-based email service, e.g., Gmail web
    launchUrl(Uri.parse('(link unavailable)'));
  }

  void _displayPhoneNumber() {
    // Display a message with the phone number
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Phone Number'),
          content: Text('03335206478'),
        );
      },
    );
  }


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
        appBar:
        AppBar(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ConsumerMainPageScreen()),
                );
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
                  fontFamily: 'Montserrat'
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'For Contact:',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Montserrat'
                ),
              ),
              SizedBox(height: 25.0),
              GestureDetector(
                onTap: _sendEmail,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Email: ',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                      TextSpan(
                        text: 'craftyhands90@gmail.com',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              GestureDetector(
                onTap: _makePhoneCall,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "03335206478",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
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
                    fontFamily:'Montserrat'
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
