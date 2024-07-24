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
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email app.';
    }
  }

  void _makePhoneCall() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '03335206478',
    );

    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      throw 'Could not launch phone dialer.';
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
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text('Contact Us'),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ConsumerMainPageScreen()),
              );
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Text(
                'We are always here to deliver. In case of further queries, please contact us using the information provided.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 40.0),
              Text(
                'For Contact:',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
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
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'craftyhands90@gmail.com',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 17.0,
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
