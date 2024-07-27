import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

import '../Consumer_Screens/explore_consumer_screen.dart';
import '../seller/sellerwelcome.dart';
import 'loginScreen.dart';

class ContinueAsScreen extends StatefulWidget {
  @override
  State<ContinueAsScreen> createState() => _ContinueAsScreenState();
}

class _ContinueAsScreenState extends State<ContinueAsScreen> {
  FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();
  String selectedLanguage = 'English'; // Default language

  Future<void> speakText(String text, String languageCode) async {
    Translation translation =
    await translator.translate(text, from: 'en', to: languageCode);
    String translatedText = translation.text;
    await flutterTts.setLanguage(languageCode);
    await flutterTts.speak(translatedText);
  }

  void onLanguageSelected(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  void showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Language',
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
          content: Container(
            child: DropdownButton<String>(
              value: selectedLanguage,
              elevation: 8,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
              items: [
                DropdownMenuItem<String>(
                  value: 'English',
                  child: Text(
                    'English',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: 'Urdu',
                  child: Text(
                    'Urdu',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                ),
              ],
              onChanged: (value) {
                Navigator.of(context).pop(); // Close the dialog
                onLanguageSelected(value!);
                speakText(
                  'Choose the seller account or the consumer account to continue',
                  value == 'Urdu' ? 'ur' : 'en',
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffcc9a9d),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.sp),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(fontSize: 16.sp, fontFamily: 'Montserrat'),
              ),
            ),
          ],
        );
      },
    );
  }

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
          backgroundColor: Colors.transparent,
          elevation: 0,
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
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
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
                      height: 150.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Continue as ',
                        style: TextStyle(
                            fontSize: 35.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          minimumSize: Size(190.w, 50.h), // Responsive size
                          maximumSize: Size(190.w, 50.h),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xffcc9a9d),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.sp),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerWelcome()));
                        },
                        child: Text(
                          'Seller ',
                          style: TextStyle(
                              fontFamily: 'Montserrat', fontSize: 17.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Or',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          minimumSize: Size(190.w, 50.h), // Responsive size
                          maximumSize: Size(190.w, 50.h),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xffcc9a9d),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.sp),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExploreConsumer()));
                        },
                        child: Text(
                          'Consumer ',
                          style: TextStyle(
                              fontFamily: 'Montserrat', fontSize: 17.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.record_voice_over, color: Colors.grey),
          onPressed: showLanguageDialog,
          elevation: 2.0, // Adjust elevation here; default is usually 6.0
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.sp), // Responsive shape
          ),
        ),
      ),
    );
  }
}
