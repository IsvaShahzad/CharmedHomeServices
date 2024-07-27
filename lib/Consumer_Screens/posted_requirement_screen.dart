import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:services_android_app/Consumer_Screens/add_requirements_consumer.dart';

class RequirementsDisplayScreen extends StatelessWidget {
  final List<Map<String, String>> dummyProducts = [
    {
      'product name': 'Knitted Hat',
      'product price': '2400',
      'product quantity': '1',
      'Contact email': 'jess@gmail.com',
      'Image URl': 'https://lovelifeyarn.com/wp-content/uploads/Easy-Bulky-Knit-Hat-Close-949x1024.jpg', // Example image URL
    },
    {
      'product name': 'Painting',
      'product price': '6000',
      'product quantity': '1',
      'Contact email': 'jess@gmail.com',
      'Image URl': 'https://www.brandysaturley.com/wp-content/uploads/2019/05/Painting5.jpg', // Example image URL
    },
    {
      'product name': 'Vase',
      'product price': '6000',
      'product quantity': '1',
      'Contact email': 'liam@gmail.com',
      'Image URl': 'https://vaaree.com/cdn/shop/files/vase-ganola-vase-with-naturally-dried-flower-bunch-1.jpg?v=1715979347&width=600',
    },
    {
      'product name': 'Coat',
      'product price': '30000',
      'product quantity': '1',
      'Contact email': 'ahmer@gmail.com',
      'Image URl': 'https://d1fufvy4xao6k9.cloudfront.net/images/blog/posts/2023/09/hockerty_double_breasted_overcoat_a9748bfb_360b_4f24_aa6c_f39bbbe3e79e.jpg',
    },
    {
      'product name': 'Gloves',
      'product price': '2000',
      'product quantity': '2',
      'Contact email': 'marie@gmail.com',
      'Image URl': 'https://images.squarespace-cdn.com/content/v1/645a571477fc01441cdebadd/1684263355957-RTMG8JZFRQEIDO4NSDNO/DSC_0028+fxd+web.jpg?format=1500w',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: () async {
          return false; // Disable the back button behavior
        },
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/page6.png', // Replace with your asset image path
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
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddRequirements()),
                  );                },
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
                          return Center(child: Text('No requirements available', style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16
                          ),));
                        }

                        final firestoreProducts = snapshot.data!.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return {
                            'product name': data['product name'] ?? 'No product name',
                            'product price': data['product price'] ?? 'N/A',
                            'product quantity': data['product quantity'] ?? 'N/A',
                            'Contact email': data['Contact email'] ?? 'N/A',
                            'Image URl': data['Image URl'] ?? '', // Note the field name
                          };
                        }).toList();

                        // Combine existing and dummy products
                        final allProducts = [
                          ...firestoreProducts,
                          ...dummyProducts,
                        ];

                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Two tiles per row
                              crossAxisSpacing: 8.0, // Space between tiles horizontally
                              mainAxisSpacing: 8.0, // Space between tiles vertically
                              childAspectRatio: 0.8, // Make tiles symmetric
                            ),
                            itemCount: allProducts.length,
                            itemBuilder: (context, index) {
                              final product = allProducts[index];
                              final imageUrl = product['Image URl'];

                              return Card(
                                color: Colors.white,
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
                                        product['product name'] ?? 'No product name',
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
                                        'Price: \$${product['product price']}',
                                        style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Product Quantity
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Quantity: ${product['product quantity']}',
                                        style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Contact Email
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Mail: ${product['Contact email']}',
                                        style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    // View Image Button
                                    if (imageUrl.isNotEmpty)
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
