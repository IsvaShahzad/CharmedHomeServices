import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequirementsDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requirements List'),
        backgroundColor: Color(0xffb38e8e),
      ),
      body: StreamBuilder<QuerySnapshot>(
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

          return ListView.builder(
            itemCount: requirements.length,
            itemBuilder: (context, index) {
              final requirement = requirements[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      requirement['Image URl'] != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          requirement['Image URl'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                          : SizedBox(height: 150, child: Center(child: Text('No image available'))),
                      SizedBox(height: 12),
                      // Product Name
                      Text(
                        requirement['product name'] ?? 'No product name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Product Price
                      Text(
                        'Price: \$${requirement['product price']}',
                        style: TextStyle(fontSize: 16, color: Colors.green[700]),
                      ),
                      SizedBox(height: 8),
                      // Product Quantity
                      Text(
                        'Quantity: ${requirement['product quantity']}',
                        style: TextStyle(fontSize: 16, color: Colors.blue[700]),
                      ),
                      SizedBox(height: 8),
                      // Product Description
                      Text(
                        'Description: ${requirement['product description']}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 8),
                      // Contact Email
                      Text(
                        'Email: ${requirement['Contact email']}',
                        style: TextStyle(fontSize: 16, color: Colors.deepOrange[700]),
                      ),
                      SizedBox(height: 8),
                      // Mobile Number
                      Text(
                        'Mobile: ${requirement['Mobile Number']}',
                        style: TextStyle(fontSize: 16, color: Colors.teal[700]),
                      ),
                      SizedBox(height: 8),
                      // Delivery Date
                      Text(
                        'Delivery Date: ${requirement['Delivery Date']}',
                        style: TextStyle(fontSize: 16, color: Colors.purple[700]),
                      ),
                      SizedBox(height: 12),
                      // View Details Button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Color(0xffb38e8e),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: Text('View Details'),
                          onPressed: () {
                            // Add action for button if needed
                          },
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
    );
  }
}
