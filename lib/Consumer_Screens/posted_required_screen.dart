import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:services_android_app/Consumer_Screens/Consumer_mainpage.dart';

class RequirementsDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          // Disable the back button behavior
          return false;
        },
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/page5.png', // Replace with your asset image path
                fit: BoxFit.cover,
              ),
            ),
            // Back icon
            Positioned(
              top: 40, // Adjust the position if needed
              left: 10, // Adjust the position if needed
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
            ),
            // Overlay content
            Positioned.fill(
              child: Column(
                children: [
                  SizedBox(height: 70), // Add space above the GridView
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('AddRequirements').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('No requirements available.'));
                        }

                        final requirements = snapshot.data!.docs;

                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Two tiles per row
                              crossAxisSpacing: 8.0, // Space between tiles horizontally
                              mainAxisSpacing: 8.0, // Space between tiles vertically
                              childAspectRatio: 0.9, // Make tiles symmetric
                            ),
                            itemCount: requirements.length,
                            itemBuilder: (context, index) {
                              final requirement = requirements[index].data() as Map<String, dynamic>;
                              final imageUrl = requirement['Image URl'];

                              return Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero, // Square edges
                                ),
                                elevation: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Name
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        requirement['product name'] ?? 'No product name',
                                        style: TextStyle(
                                            fontSize: 14, // Smaller font size
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'
                                        ),
                                      ),
                                    ),
                                    // Product Price
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Price: \$${requirement['product price']}',
                                        style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Product Quantity
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Quantity: ${requirement['product quantity']}',
                                        style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Contact Email
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Mail: ${requirement['Contact email']}',
                                        style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // View Image Button
                                    if (imageUrl != null)
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Color(0xffb38e8e),
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(2.0),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          ),
                                          child: Text('View Image', style: TextStyle(fontSize: 13, fontFamily: 'Montserrat')),
                                          onPressed: () {
                                            _showImageDialog(context, imageUrl);
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Square edges
          ),
          content: Container(
            width: 200, // Increased width
            height: 200, // Increased height to make it square
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  color: Colors.black
              ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
