// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../Detail_Screens/Products_DetailScreen/products_detail_screen.dart';
//
// class ProductListScreen extends StatelessWidget {
//   final String categoryName;
//   final String subcategoryName;
//
//   ProductListScreen({
//     required this.categoryName,
//     required this.subcategoryName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/page7.png'), // Replace with your image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Main content
//           Column(
//             children: [
//               // AppBar
//               AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 leading: IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.white), // Set back button color to white
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Navigate back
//                   },
//                 ),
//               ),
//               // Add padding to move the list tiles down
//               SizedBox(height: 20.0), // Adjust the height as needed
//               // Product grid
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('addproducts')
//                         .where('product category', isEqualTo: categoryName)
//                         .where('product subcategory', isEqualTo: subcategoryName)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       }
//
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//
//                       final products = snapshot.data?.docs ?? [];
//
//                       if (products.isEmpty) {
//                         return Center(
//                           child: Text(
//                             'No products available for this subcategory',
//                             style: TextStyle(fontFamily: 'Montserrat'),
//                           ),
//                         );
//                       }
//
//                       return GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 5.0,
//                           mainAxisSpacing: 5.0,
//                           childAspectRatio: 0.85, // Adjust as needed
//                         ),
//                         itemCount: products.length,
//                         itemBuilder: (context, index) {
//                           final productData = products[index].data() as Map<String, dynamic>;
//
//                           // Safely retrieve values with null checks
//                           final imageUrl = productData['Image URl'] ?? '';
//                           final productName = productData['product name'] ?? 'Unnamed Product';
//                           final productPrice = productData['product price'] ?? '0';
//                           final productDescription = productData['product description'] ?? '';
//                           final companyName = productData['company name'] ?? '';
//
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetailScreen(
//                                     productName: productName,
//                                     id: products[index].id, // Assuming you want to pass the document ID
//                                     productPrice: double.tryParse(productPrice) ?? 0.0,
//                                     productDescription: productDescription,
//                                     ImageURL: imageUrl,
//                                     companyName: companyName,
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Card(
//                               elevation: 2, // Adjust elevation as needed
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(4.0), // Rounded corners
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Container(
//                                     height: 120, // Adjust the height for the image container
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)), // Rounded top edges
//                                       image: DecorationImage(
//                                         image: imageUrl.isNotEmpty
//                                             ? NetworkImage(imageUrl)
//                                             : AssetImage('assets/placeholder.png') as ImageProvider,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       productName,
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15,
//                                         fontFamily: 'Montserrat',
//                                       ),
//                                       overflow: TextOverflow.ellipsis, // Handle overflow
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                                     child: Text(
//                                       'Rs.${productPrice}',
//                                       style: TextStyle(
//                                         color: Colors.green,
//                                         fontSize: 12, // Adjusted font size
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:services_android_app/Detail_Screens/Products_DetailScreen/products_detail_screen.dart';

// Define a data model for products
class Product {
  final String imageUrl;
  final String productName;
  final double productPrice;
  final String productDescription;
  final String companyName;

  Product({
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.productDescription,
    required this.companyName,
  });
}

// Define a map for dummy products based on subcategory
Map<String, List<Product>> dummyProductsBySubcategory = {
  'Cakes': [
    Product(
      imageUrl: 'https://www.browneyedbaker.com/wp-content/uploads/2021/05/chocolate-cake-15-square.jpg',
      productName: 'Chocolate Cake',
      productPrice: 900,
      productDescription: 'Delicious chocolate cake with rich cocoa flavor.',
      companyName: 'Bakes',
    ),
    Product(
      imageUrl: 'https://static01.nyt.com/images/2023/10/25/multimedia/lh-vanilla-cake-jhfb/lh-vanilla-cake-jhfb-superJumbo.jpg',
      productName: 'Vanilla Cake',
      productPrice: 1100,
      productDescription: 'Classic vanilla cake with a smooth texture.',
      companyName: 'MustCakes',
    ),
    Product(
      imageUrl: 'https://bakeitwithlove.com/wp-content/uploads/2022/09/red-velvet-cake-h.jpg',
      productName: 'Red Velvet Cake',
      productPrice: 1400,
      productDescription: 'Smooth red velvet cake with cream cheese frosting.',
      companyName: 'Cake Shop',
    ),
    Product(
      imageUrl: 'https://www.serendipitycakecompany.co.uk/wp-content/uploads/2020/04/Lemon-Drizzle-Cake-1080x675.jpeg',
      productName: 'Lemon Drizzle Cake',
      productPrice: 1200,
      productDescription: 'Refreshing lemon drizzle cake with a zesty flavor.',
      companyName: 'Cake Makers',
    ),
    Product(
      imageUrl: 'https://bakerjo.co.uk/wp-content/uploads/2022/08/IMG_3525.jpg',
      productName: 'Carrot Cake',
      productPrice: 13.99,
      productDescription: 'Moist carrot cake with walnuts and cream cheese frosting.',
      companyName: 'Cake Shop',
    ),
  ],
  'Cupcakes': [
    Product(
      imageUrl: 'https://joyfoodsunshine.com/wp-content/uploads/2021/12/best-vanilla-cupcakes-recipe-1x1-1.jpg',
      productName: 'Vanilla Cupcake',
      productPrice: 3.99,
      productDescription: 'Tasty vanilla cupcake with creamy frosting.',
      companyName: 'Cupcake Corner',
    ),
    Product(
      imageUrl: 'https://www.onceuponachef.com/images/2021/02/chocolate-lover-chocolate-cupcakes-scaled.jpg',
      productName: 'Chocolate Cupcake',
      productPrice: 4.99,
      productDescription: 'Delicious chocolate cupcake with a moist center.',
      companyName: 'Bakes',
    ),
    Product(
      imageUrl: 'https://www.allrecipes.com/thmb/W5Ou0-fSTAHi5vM9FdJkplRzgNQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/212429-red-velvet-cupcakes-ddmfs-0178-3x4-hero-e5cd9e2684dd4d90b40d9aa0d42e3ee2.jpg',
      productName: 'Red Velvet Cupcake',
      productPrice: 4.49,
      productDescription: 'Smooth red velvet cupcake with cream cheese frosting.',
      companyName: 'EatsCo.',
    ),
    Product(
      imageUrl: 'https://sallysbakingaddiction.com/wp-content/uploads/2013/04/the-best-lemon-cupcakes-5.jpg',
      productName: 'Lemon Cupcake',
      productPrice: 4.29,
      productDescription: 'Zesty lemon cupcake with a tangy glaze.',
      companyName: 'Cupcake Corner',
    ),
    Product(
      imageUrl: 'https://joyfoodsunshine.com/wp-content/uploads/2022/08/carrot-cake-cupcakes-recipe-8.jpg',
      productName: 'Carrot Cupcake',
      productPrice: 4.79,
      productDescription: 'Moist carrot cupcake with walnuts and cream cheese frosting.',
      companyName: 'Cupcake Corner',
    ),
  ],
  'Frozen': [
    Product(
      imageUrl: 'https://cdn.tasteatlas.com/images/recipes/77b9ef5b3e404dacbc227418104705ff.jpg',
      productName: 'Nuggets',
      productPrice: 890,
      productDescription: 'Fresh Chicken Nuggets.',
      companyName: 'Bakery',
    ),
    Product(
      imageUrl: 'https://cliftonnimco.com/wp-content/uploads/2018/04/Chicken-Roll.jpg',
      productName: 'Rolls',
      productPrice: 700,
      productDescription: 'Chicken rolls with spices',
      companyName: 'Sunsrise Bakery',
    ),
    Product(
      imageUrl: 'https://images.themodernproper.com/billowy-turkey/production/posts/2018/BakedChickenWings_11.jpg?w=1200&h=630&q=82&fm=jpg&fit=crop&dm=1674170504&s=922661b43b1124dce4a28eead97618d9',
      productName: 'Chicken Wings ',
      productPrice: 900,
      productDescription: 'BBQ glazed honey wings',
      companyName: 'CHomeCooks',
    ),
    Product(
      imageUrl: 'https://static01.nyt.com/images/2023/10/18/multimedia/EP-Air-fryer-chicken-tenders-cpmw/EP-Air-fryer-chicken-tenders-cpmw-superJumbo.jpg',
      productName: 'Tenders',
      productPrice: 800,
      productDescription: 'Chciken tenders with cheese filling insde.',
      companyName: 'Tart Bakery',
    ),
    Product(
      imageUrl: 'https://mummyrecipes.in/wp-content/uploads/2019/08/chickenpopsCover.jpg',
      productName: 'Pops',
      productPrice: 900,
      productDescription: 'Chicken pops with chunks of chicken and bread crumbs',
      companyName: 'Sunrise Bakery',
    ),
    ],
  'Western': [
    Product(
      imageUrl: 'https://pulses.org/us/wp-content/uploads/2020/05/DSCF4822-scaled.jpg',
      productName: 'BBQ Burger',
      productPrice: 800,
      productDescription: 'Juicy beef burger with smoky BBQ sauce and crispy onions.',
      companyName: 'Cowboy Bites',
    ),
    Product(
      imageUrl: 'https://insanelygoodrecipes.com/wp-content/uploads/2022/01/Homemade-Chicken-Shawarma-with-Vegetables.jpg',
      productName: 'Chicken Wrap',
      productPrice: 700,
      productDescription: 'Grilled chicken wrap with ranch dressing and fresh veggies.',
      companyName: 'Prairie Eats',
    ),
    Product(
      imageUrl: 'https://midwestfoodieblog.com/wp-content/uploads/2022/04/FINAL-cheese-quesadilla-1-4.jpg',
      productName: 'Quesadilla',
      productPrice: 600,
      productDescription: 'Cheesy quesadilla with a blend of Tex-Mex spices.',
      companyName: 'Desert Delight',
    ),
    Product(
      imageUrl: 'https://stlukepalermo.ca/wp-content/uploads/2024/02/cowboy-steak-223-d111289_sq-crop-0723-a352ee2803564fb4853d60ed7ac702b9.jpeg',
      productName: 'Cowboy Steak',
      productPrice: 1400,
      productDescription: 'Grilled steak with a classic Western seasoning.',
      companyName: 'Ranch House Grill',
    ),
    Product(
      imageUrl: 'https://www.healthyseasonalrecipes.com/wp-content/uploads/2022/06/healthy-cobb-salad-steps-sq-026.jpg',
      productName: 'Southwest Salad',
      productPrice: 900,
      productDescription: 'Fresh greens with corn, black beans, and a spicy dressing.',
      companyName: 'Cactus Fresh',
    ),
    Product(
      imageUrl: 'https://dinnerthendessert.com/wp-content/uploads/2018/08/Buffalo-Wings-4.jpg',
      productName: 'Buffalo Wings',
      productPrice: 700,
      productDescription: 'Spicy buffalo wings served with ranch dipping sauce.',
      companyName: 'Wild West Wings',
    ),
  ],

  'Brownies': [
      Product(
        imageUrl: 'https://www.bakedbyclaire.com/img/fudgy%20brownies.png',
        productName: 'Fudgy Brownie',
        productPrice: 599,
        productDescription: 'Rich and fudgy brownie with a gooey center.',
        companyName: 'Brownie Bliss',
      ),
    Product(
      imageUrl: 'https://zhangcatherine.com/wp-content/uploads/2022/06/strawbrownies.jpg',
      productName: 'Strawberry Brownie',
      productPrice: 599,
      productDescription: 'Strawberry fudgy brownie with a gooey filled center of chunks of strawberry.',
      companyName: 'Brownie Bliss',
    ),
    Product(
      imageUrl: 'https://momfoodie.com/wp-content/uploads/Double-Chocolate-Brownies-Package-5-7.jpg',
      productName: 'Chocolate Chip Brownie',
      productPrice: 599,
      productDescription: 'Chocolate chip filled brownie',
      companyName: 'Brownie Bliss',
    ),
      Product(
        imageUrl: 'https://img.kidspot.com.au/pYPsXUEC/w1200-h630-cfill/kk/2015/03/walnut-brownies-recipe-606095-2.jpg',
        productName: 'Walnut Brownie',
        productPrice: 600,
        productDescription: 'Decadent brownie with crunchy walnuts.',
        companyName: 'Brownie Bliss',
      ),
      Product(
        imageUrl: 'https://www.simplyrecipes.com/thmb/hGNrO2G9ajEJc3YRijL8E4NIiQs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Blondies-Lead-Shot-12e-7844d357f5934aa785f446045b92777b.jpg',
        productName: 'Blondie Brownie',
        productPrice: 540,
        productDescription: 'Chewy blondie with a hint of vanilla.',
        companyName: 'Brownie Bliss',
      ),
      Product(
        imageUrl: 'https://handletheheat.com/wp-content/uploads/2019/06/Peanut-Butter-Stuffed-Brownies-SQUARE.jpg',
        productName: 'Peanut Butter Brownie',
        productPrice: 690,
        productDescription: 'Smooth peanut butter swirled into a rich brownie.',
        companyName: 'Brownie Bliss',
      ),
      Product(
        imageUrl: 'https://www.thespicehouse.com/cdn/shop/articles/Chocolate_Mint_Brownies_720x.jpg?v=1604595371',
        productName: 'Mint Chocolate Brownie',
        productPrice: 650,
        productDescription: 'Refreshing mint flavor combined with rich chocolate.',
        companyName: 'Brownie Bliss',
      ),
    ],
    'Pizzas': [
      Product(
        imageUrl: 'https://simplyhomecooked.com/wp-content/uploads/2023/04/Margherita-Pizza-3.jpg',
        productName: 'Margherita Pizza',
        productPrice: 900,
        productDescription: 'Classic Margherita pizza with fresh mozzarella and basil.',
        companyName: 'Pizza Palace',
      ),
      Product(
        imageUrl: 'https://foodhub.scene7.com/is/image/woolworthsltdprod/2004-easy-pepperoni-pizza:Mobile-1300x1150',
        productName: 'Pepperoni Pizza',
        productPrice: 1200,
        productDescription: 'Spicy pepperoni on a bed of melted cheese.',
        companyName: 'Pizza Palace',
      ),
      Product(
        imageUrl: 'https://pinchofyum.com/wp-content/uploads/bbq-chicken-pizza.jpg',
        productName: 'BBQ Chicken Pizza',
        productPrice: 1249,
        productDescription: 'Tender BBQ chicken with a smoky sauce.',
        companyName: 'Pizza Palace',
      ),
      Product(
        imageUrl: 'https://images.arla.com/recordid/F67E678C-299C-46E8-B52D14612437E31D/vegetable-pizza.jpg?width=1200&height=630&mode=crop&format=jpg',
        productName: 'Vegetarian Pizza',
        productPrice: 900,
        productDescription: 'Loaded with fresh vegetables and cheese.',
        companyName: 'Pizza Palace',
      ),
      Product(
        imageUrl: 'https://pisapizza.ca/wp-content/uploads/2024/05/hawaiian-pizza-ddmfs-3x2-132-450eff04ad924d9a9eae98ca44e3f988.jpg',
        productName: 'Hawaiian Pizza',
        productPrice: 1100,
        productDescription: 'Ham and pineapple on a cheesy base.',
        companyName: 'Pizza Palace',
      ),
    ],
    'Homemade': [
      Product(
        imageUrl: 'https://static01.nyt.com/images/2023/08/31/multimedia/RS-Lasagna-hkjl-copy/RS-Lasagna-hkjl-superJumbo.jpg',
        productName: 'Lasagna',
        productPrice: 800,
        productDescription: 'Layered lasagna with homemade sauce.',
        companyName: 'Homemade Delights',
      ),
      Product(
        imageUrl: 'https://drivemehungry.com/wp-content/uploads/2021/11/italian-meatballs-f.jpg',
        productName: 'Meatballs',
        productPrice: 700,
        productDescription: 'Juicy meatballs with a secret family recipe.',
        companyName: 'Homemade Delights',
      ),
      Product(
        imageUrl: 'https://www.seriouseats.com/thmb/rSLErBdfLqXb-FpzU_ScNXeP1aA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/20230804-SEA-ToastedRaviloli-RobbyLozano-003-e7bb43d20b734ff7bcc9a56a49a4840d.jpg',
        productName: 'Ravioli',
        productPrice: 1000,
        productDescription: 'Stufefd chicken and cheese ravioli',
        companyName: 'Homemade Delights',
      ),
      Product(
        imageUrl: 'https://www.allrecipes.com/thmb/e8uotDI18ieXNBY0KpmtGKbxMRM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/238691-Simple-Macaroni-And-Cheese-mfs_008-4x3-6ed91ba87a1344558aacc0f9ef0f4b41.jpg',
        productName: 'Mac and Cheese',
        productPrice: 800,
        productDescription: 'Creamy macaroni and cheese with a crunchy topping.',
        companyName: 'Homemade Delights',
      ),
      Product(
        imageUrl: 'https://images.immediate.co.uk/production/volatile/sites/30/2022/09/Spicy-tomato-spaghetti-caf3053.jpg',
        productName: 'Spaghetti',
        productPrice: 700,
        productDescription: 'Mariana sauce covered tomatoe spaghetti.',
        companyName: 'Homemade Delights',
      ),
      Product(
        imageUrl: 'https://images.getrecipekit.com/20220904015448-veg-20fried-20rice.png?aspect_ratio=16:9&quality=90&',
        productName: 'Fried Rice',
        productPrice: 700,
        productDescription: 'Chicken adn vegetable fried rice',
        companyName: 'Homemade Delights',
      ),
    ],

  // Add more subcategories and products as needed
};

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
      body: Stack(
        children: [
          // Background image

          // Main content
          Column(
            children: [
              // AppBar
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white), // Set back button color to white
                  onPressed: () {
                    Navigator.of(context).pop(); // Navigate back
                  },
                ),
              ),
              // Add padding to move the list tiles down
              // Product grid
              Expanded(
                child: Padding(
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

                      final firestoreProducts = snapshot.data?.docs.map((doc) {
                        final productData = doc.data() as Map<String, dynamic>;
                        return Product(
                          imageUrl: productData['Image URl'] ?? '',
                          productName: productData['product name'] ?? 'Unnamed Product',
                          productPrice: double.tryParse(productData['product price'] ?? '0') ?? 0.0,
                          productDescription: productData['product description'] ?? '',
                          companyName: productData['company name'] ?? '',
                        );
                      }).toList() ?? [];

                      // Get dummy products for the current subcategory
                      final dummyProducts = dummyProductsBySubcategory[subcategoryName] ?? [];

                      // Combine Firestore products with dummy products
                      final allProducts = [...firestoreProducts, ...dummyProducts];

                      if (allProducts.isEmpty) {
                        return Center(child: Text('No products available for this subcategory', style: TextStyle(
                            fontFamily: 'Montserrat'
                        ),));
                      }

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 0.85, // Adjust as needed
                        ),
                        itemCount: allProducts.length,
                        itemBuilder: (context, index) {
                          final product = allProducts[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(
                                    productName: product.productName,
                                    id: 'dummy_id', // Use a dummy ID
                                    productPrice: product.productPrice,
                                    productDescription: product.productDescription,
                                    ImageURL: product.imageUrl,
                                    companyName: product.companyName,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2, // Adjust elevation as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0), // Rounded corners
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 120, // Adjust the height for the image container
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)), // Rounded top edges
                                      image: DecorationImage(
                                        image: product.imageUrl.isNotEmpty
                                            ? NetworkImage(product.imageUrl)
                                            : AssetImage('assets/placeholder.png') as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      product.productName,
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
                                      'Rs.${product.productPrice.toStringAsFixed(2)}',
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

