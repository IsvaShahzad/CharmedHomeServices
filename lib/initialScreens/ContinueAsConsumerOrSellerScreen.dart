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

  // ...

  void onLanguageSelected(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  // ...


  void showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Language',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            child: DropdownButton<String>(
              value: selectedLanguage,
              elevation: 8,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              items: [
                DropdownMenuItem<String>(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem<String>(
                  value: 'Urdu',
                  child: Text('Urdu'),
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
                foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(fontSize: 16),
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
            image: AssetImage("assets/images/lb.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 13,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
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
              title: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
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
                          child: Text(
                            'Continue as ',
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 13,
                              minimumSize: const Size(180, 50),
                              maximumSize: const Size(180, 50),
                              foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SellerWelcome()));
                            },
                            child: const Text(
                              'Seller ',
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
                                color: Colors.purple),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 13,
                              minimumSize: const Size(180, 50),
                              maximumSize: const Size(180, 50),
                              foregroundColor: Colors.white, backgroundColor: Color(0xFFAB47BC),

                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExploreConsumer()));
                            },
                            child: const Text(
                              'Consumer ',
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
              child: Icon(Icons.record_voice_over),
              onPressed: showLanguageDialog,
            )));
  }
}