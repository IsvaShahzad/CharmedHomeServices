import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Detail_Screens/Baking_DetailScreen/Cakes_detail.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryName;
  final String subcategoryName;

  ProductListScreen({
    required this.categoryName,
    required this.subcategoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName - $subcategoryName'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('addproducts')
              .where('product category', isEqualTo: categoryName)
              .where('product subcategory', isEqualTo: subcategoryName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data?.docs ?? [];

            if (products.isEmpty) {
              return Center(child: Text('No products available for this subcategory.'));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.85, // Adjust as needed
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final productData = products[index].data() as Map<String, dynamic>;

                // Safely retrieve values with null checks
                final imageUrl = productData['Image URl'] ?? '';
                final productName = productData['product name'] ?? 'Unnamed Product';
                final productPrice = productData['product price'] ?? '0';
                final productDescription = productData['product description'] ?? '';
                final companyName = productData['company name'] ?? '';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CakesDetailScreen(
                          productName: productName,
                          id: products[index].id, // Assuming you want to pass the document ID
                          productPrice: double.tryParse(productPrice) ?? 0.0,
                          productDescription: productDescription,
                          ImageURL: imageUrl,
                          companyName: companyName,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2, // Adjust elevation as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), // Rounded corners
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 120, // Adjust the height for the image container
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)), // Rounded top edges
                            image: DecorationImage(
                              image: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : AssetImage('assets/placeholder.png') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            productName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                            ),
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Rs.${productPrice}',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12, // Adjusted font size
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
