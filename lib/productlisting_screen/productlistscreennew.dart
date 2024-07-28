
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
      imageUrl:
          'https://www.browneyedbaker.com/wp-content/uploads/2021/05/chocolate-cake-15-square.jpg',
      productName: 'Chocolate Cake',
      productPrice: 900,
      productDescription: 'Delicious chocolate cake with rich cocoa flavor.',
      companyName: 'Bakes',
    ),
    Product(
      imageUrl:
          'https://static01.nyt.com/images/2023/10/25/multimedia/lh-vanilla-cake-jhfb/lh-vanilla-cake-jhfb-superJumbo.jpg',
      productName: 'Vanilla Cake',
      productPrice: 1100,
      productDescription: 'Classic vanilla cake with a smooth texture.',
      companyName: 'MustCakes',
    ),
    Product(
      imageUrl:
          'https://bakeitwithlove.com/wp-content/uploads/2022/09/red-velvet-cake-h.jpg',
      productName: 'Red Velvet Cake',
      productPrice: 1400,
      productDescription: 'Smooth red velvet cake with cream cheese frosting.',
      companyName: 'Cake Shop',
    ),
    Product(
      imageUrl:
          'https://www.serendipitycakecompany.co.uk/wp-content/uploads/2020/04/Lemon-Drizzle-Cake-1080x675.jpeg',
      productName: 'Lemon Drizzle Cake',
      productPrice: 1200,
      productDescription: 'Refreshing lemon drizzle cake with a zesty flavor.',
      companyName: 'Cake Makers',
    ),
    Product(
      imageUrl: 'https://bakerjo.co.uk/wp-content/uploads/2022/08/IMG_3525.jpg',
      productName: 'Carrot Cake',
      productPrice: 1300,
      productDescription:
          'Moist carrot cake with walnuts and cream cheese frosting.',
      companyName: 'Cake Shop',
    ),
  ],
  'Cupcakes': [
    Product(
      imageUrl:
          'https://joyfoodsunshine.com/wp-content/uploads/2021/12/best-vanilla-cupcakes-recipe-1x1-1.jpg',
      productName: 'Vanilla Cupcake',
      productPrice: 1200,
      productDescription: 'Tasty vanilla cupcake with creamy frosting.',
      companyName: 'Cupcake Corner',
    ),
    Product(
      imageUrl:
          'https://www.onceuponachef.com/images/2021/02/chocolate-lover-chocolate-cupcakes-scaled.jpg',
      productName: 'Chocolate Cupcake',
      productPrice: 700,
      productDescription: 'Delicious chocolate cupcake with a moist center.',
      companyName: 'Bakes',
    ),
    Product(
      imageUrl:
          'https://www.allrecipes.com/thmb/W5Ou0-fSTAHi5vM9FdJkplRzgNQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/212429-red-velvet-cupcakes-ddmfs-0178-3x4-hero-e5cd9e2684dd4d90b40d9aa0d42e3ee2.jpg',
      productName: 'Red Velvet Cupcake',
      productPrice: 400,
      productDescription:
          'Smooth red velvet cupcake with cream cheese frosting.',
      companyName: 'EatsCo.',
    ),
    Product(
      imageUrl:
          'https://sallysbakingaddiction.com/wp-content/uploads/2013/04/the-best-lemon-cupcakes-5.jpg',
      productName: 'Lemon Cupcake',
      productPrice: 400,
      productDescription: 'Zesty lemon cupcake with a tangy glaze.',
      companyName: 'Cupcake Corner',
    ),
    Product(
      imageUrl:
          'https://joyfoodsunshine.com/wp-content/uploads/2022/08/carrot-cake-cupcakes-recipe-8.jpg',
      productName: 'Carrot Cupcake',
      productPrice: 400,
      productDescription:
          'Moist carrot cupcake with walnuts and cream cheese frosting.',
      companyName: 'Cupcake Corner',
    ),
  ],
  'Frozen': [
    Product(
      imageUrl:
      'https://www.shanfoods.com/wp-content/uploads/2016/11/seekh-kabab.jpg',
      productName: 'Kebab',
      productPrice: 450,
      productDescription: 'Fresh Chicken Kebab.',
      companyName: 'Bakery',
    ),
    Product(
      imageUrl:
      'https://karalydon.com/wp-content/uploads/2022/05/air-fryer-frozen-french-fries-8-2.jpg',
      productName: 'Fries',
      productPrice: 300,
      productDescription: 'Fresh Chicken Nuggets.',
      companyName: 'Bakery',
    ),

    Product(
      imageUrl:
          'https://cdn.tasteatlas.com/images/recipes/77b9ef5b3e404dacbc227418104705ff.jpg',
      productName: 'Nuggets',
      productPrice: 890,
      productDescription: 'Fresh Chicken Nuggets.',
      companyName: 'Bakery',
    ),
    Product(
      imageUrl:
          'https://cliftonnimco.com/wp-content/uploads/2018/04/Chicken-Roll.jpg',
      productName: 'Rolls',
      productPrice: 700,
      productDescription: 'Chicken rolls with spices',
      companyName: 'Sunsrise Bakery',
    ),
    Product(
      imageUrl:
          'https://images.themodernproper.com/billowy-turkey/production/posts/2018/BakedChickenWings_11.jpg?w=1200&h=630&q=82&fm=jpg&fit=crop&dm=1674170504&s=922661b43b1124dce4a28eead97618d9',
      productName: 'Chicken Wings ',
      productPrice: 900,
      productDescription: 'BBQ glazed honey wings',
      companyName: 'CHomeCooks',
    ),
    Product(
      imageUrl:
          'https://static01.nyt.com/images/2023/10/18/multimedia/EP-Air-fryer-chicken-tenders-cpmw/EP-Air-fryer-chicken-tenders-cpmw-superJumbo.jpg',
      productName: 'Tenders',
      productPrice: 800,
      productDescription: 'Chciken tenders with cheese filling insde.',
      companyName: 'Tart Bakery',
    ),
    Product(
      imageUrl:
          'https://mummyrecipes.in/wp-content/uploads/2019/08/chickenpopsCover.jpg',
      productName: 'Chicken Pops',
      productPrice: 900,
      productDescription:
          'Chicken pops with chunks of chicken and bread crumbs',
      companyName: 'Sunrise Bakery',
    ),
  ],
  'Western': [
    Product(
      imageUrl:
          'https://pulses.org/us/wp-content/uploads/2020/05/DSCF4822-scaled.jpg',
      productName: 'BBQ Burger',
      productPrice: 800,
      productDescription:
          'Juicy beef burger with smoky BBQ sauce and crispy onions.',
      companyName: 'Cowboy Bites',
    ),
    Product(
      imageUrl:
          'https://insanelygoodrecipes.com/wp-content/uploads/2022/01/Homemade-Chicken-Shawarma-with-Vegetables.jpg',
      productName: 'Chicken Wrap',
      productPrice: 700,
      productDescription:
          'Grilled chicken wrap with ranch dressing and fresh veggies.',
      companyName: 'Prairie Eats',
    ),
    Product(
      imageUrl:
          'https://midwestfoodieblog.com/wp-content/uploads/2022/04/FINAL-cheese-quesadilla-1-4.jpg',
      productName: 'Quesadilla',
      productPrice: 600,
      productDescription: 'Cheesy quesadilla with a blend of Tex-Mex spices.',
      companyName: 'Desert Delight',
    ),
    Product(
      imageUrl:
          'https://stlukepalermo.ca/wp-content/uploads/2024/02/cowboy-steak-223-d111289_sq-crop-0723-a352ee2803564fb4853d60ed7ac702b9.jpeg',
      productName: 'Cowboy Steak',
      productPrice: 1400,
      productDescription: 'Grilled steak with a classic Western seasoning.',
      companyName: 'Ranch House Grill',
    ),
    Product(
      imageUrl:
          'https://www.healthyseasonalrecipes.com/wp-content/uploads/2022/06/healthy-cobb-salad-steps-sq-026.jpg',
      productName: 'Southwest Salad',
      productPrice: 900,
      productDescription:
          'Fresh greens with corn, black beans, and a spicy dressing.',
      companyName: 'Cactus Fresh',
    ),
    Product(
      imageUrl:
          'https://dinnerthendessert.com/wp-content/uploads/2018/08/Buffalo-Wings-4.jpg',
      productName: 'Buffalo Wings',
      productPrice: 700,
      productDescription:
          'Spicy buffalo wings served with ranch dipping sauce.',
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
      imageUrl:
          'https://zhangcatherine.com/wp-content/uploads/2022/06/strawbrownies.jpg',
      productName: 'Strawberry Brownie',
      productPrice: 599,
      productDescription:
          'Strawberry fudgy brownie with a gooey filled center of chunks of strawberry.',
      companyName: 'Brownie Bliss',
    ),
    Product(
      imageUrl:
          'https://momfoodie.com/wp-content/uploads/Double-Chocolate-Brownies-Package-5-7.jpg',
      productName: 'Chocolate Chip Brownie',
      productPrice: 599,
      productDescription: 'Chocolate chip filled brownie',
      companyName: 'Brownie Bliss',
    ),
    Product(
      imageUrl:
          'https://img.kidspot.com.au/pYPsXUEC/w1200-h630-cfill/kk/2015/03/walnut-brownies-recipe-606095-2.jpg',
      productName: 'Walnut Brownie',
      productPrice: 600,
      productDescription: 'Decadent brownie with crunchy walnuts.',
      companyName: 'Brownie Bliss',
    ),
    Product(
      imageUrl:
          'https://www.simplyrecipes.com/thmb/hGNrO2G9ajEJc3YRijL8E4NIiQs=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-Blondies-Lead-Shot-12e-7844d357f5934aa785f446045b92777b.jpg',
      productName: 'Blondie Brownie',
      productPrice: 540,
      productDescription: 'Chewy blondie with a hint of vanilla.',
      companyName: 'Brownie Bliss',
    ),
    Product(
      imageUrl:
          'https://handletheheat.com/wp-content/uploads/2019/06/Peanut-Butter-Stuffed-Brownies-SQUARE.jpg',
      productName: 'Peanut Butter Brownie',
      productPrice: 690,
      productDescription: 'Smooth peanut butter swirled into a rich brownie.',
      companyName: 'Brownie Bliss',
    ),
    Product(
      imageUrl:
          'https://www.thespicehouse.com/cdn/shop/articles/Chocolate_Mint_Brownies_720x.jpg?v=1604595371',
      productName: 'Mint Chocolate Brownie',
      productPrice: 650,
      productDescription:
          'Refreshing mint flavor combined with rich chocolate.',
      companyName: 'Brownie Bliss',
    ),
  ],
  'Pizzas': [
    Product(
      imageUrl:
          'https://simplyhomecooked.com/wp-content/uploads/2023/04/Margherita-Pizza-3.jpg',
      productName: 'Margherita Pizza',
      productPrice: 900,
      productDescription:
          'Classic Margherita pizza with fresh mozzarella and basil.',
      companyName: 'Pizza Palace',
    ),
    Product(
      imageUrl:
          'https://foodhub.scene7.com/is/image/woolworthsltdprod/2004-easy-pepperoni-pizza:Mobile-1300x1150',
      productName: 'Pepperoni Pizza',
      productPrice: 1200,
      productDescription: 'Spicy pepperoni on a bed of melted cheese.',
      companyName: 'Pizza Palace',
    ),
    Product(
      imageUrl:
          'https://pinchofyum.com/wp-content/uploads/bbq-chicken-pizza.jpg',
      productName: 'BBQ Chicken Pizza',
      productPrice: 1249,
      productDescription: 'Tender BBQ chicken with a smoky sauce.',
      companyName: 'Pizza Palace',
    ),
    Product(
      imageUrl:
          'https://images.arla.com/recordid/F67E678C-299C-46E8-B52D14612437E31D/vegetable-pizza.jpg?width=1200&height=630&mode=crop&format=jpg',
      productName: 'Vegetarian Pizza',
      productPrice: 900,
      productDescription: 'Loaded with fresh vegetables and cheese.',
      companyName: 'Pizza Palace',
    ),
    Product(
      imageUrl:
          'https://pisapizza.ca/wp-content/uploads/2024/05/hawaiian-pizza-ddmfs-3x2-132-450eff04ad924d9a9eae98ca44e3f988.jpg',
      productName: 'Hawaiian Pizza',
      productPrice: 1100,
      productDescription: 'Ham and pineapple on a cheesy base.',
      companyName: 'Pizza Palace',
    ),
  ],
  'Homemade': [
    Product(
      imageUrl:
          'https://static01.nyt.com/images/2023/08/31/multimedia/RS-Lasagna-hkjl-copy/RS-Lasagna-hkjl-superJumbo.jpg',
      productName: 'Lasagna',
      productPrice: 800,
      productDescription: 'Layered lasagna with homemade sauce.',
      companyName: 'Homemade Delights',
    ),
    Product(
      imageUrl:
          'https://drivemehungry.com/wp-content/uploads/2021/11/italian-meatballs-f.jpg',
      productName: 'Meatballs',
      productPrice: 700,
      productDescription: 'Juicy meatballs with a secret family recipe.',
      companyName: 'Homemade Delights',
    ),
    Product(
      imageUrl:
          'https://www.seriouseats.com/thmb/rSLErBdfLqXb-FpzU_ScNXeP1aA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/20230804-SEA-ToastedRaviloli-RobbyLozano-003-e7bb43d20b734ff7bcc9a56a49a4840d.jpg',
      productName: 'Ravioli',
      productPrice: 1000,
      productDescription: 'Stufefd chicken and cheese ravioli',
      companyName: 'Homemade Delights',
    ),
    Product(
      imageUrl:
          'https://www.allrecipes.com/thmb/e8uotDI18ieXNBY0KpmtGKbxMRM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/238691-Simple-Macaroni-And-Cheese-mfs_008-4x3-6ed91ba87a1344558aacc0f9ef0f4b41.jpg',
      productName: 'Mac and Cheese',
      productPrice: 800,
      productDescription: 'Creamy macaroni and cheese with a crunchy topping.',
      companyName: 'Homemade Delights',
    ),
    Product(
      imageUrl:
          'https://images.immediate.co.uk/production/volatile/sites/30/2022/09/Spicy-tomato-spaghetti-caf3053.jpg',
      productName: 'Spaghetti',
      productPrice: 700,
      productDescription: 'Mariana sauce covered tomatoe spaghetti.',
      companyName: 'Homemade Delights',
    ),
    Product(
      imageUrl:
          'https://images.getrecipekit.com/20220904015448-veg-20fried-20rice.png?aspect_ratio=16:9&quality=90&',
      productName: 'Fried Rice',
      productPrice: 700,
      productDescription: 'Chicken adn vegetable fried rice',
      companyName: 'Homemade Delights',
    ),
  ],
  'Banner Making': [
    Product(
      imageUrl:
          'https://paksellers.net/wp-content/uploads/2018/07/p-9459-mint-ombre-3.jpg',
      productName: 'Birthday Banner',
      productPrice: 1599,
      productDescription: 'Customizable birthday banner with vibrant colors.',
      companyName: 'Banner Creations',
    ),
    Product(
      imageUrl:
          'https://i.etsystatic.com/6156248/r/il/10ab02/1481621165/il_570xN.1481621165_jhdm.jpg',
      productName: 'Wedding Banner',
      productPrice: 2499,
      productDescription: 'Elegant banner for wedding celebrations.',
      companyName: 'Celebration Banners',
    ),
    Product(
      imageUrl:
          'https://media1.thehungryjpeg.com/thumbs2/ori_3911792_63zg4siaj7xzda6mvaoza0k18mgru60kq5mr8t3q_banner-roll-up-business-banner-design.jpg',
      productName: 'Business Banner',
      productPrice: 1999,
      productDescription: 'Professional banner for business events.',
      companyName: 'Pro Banners',
    ),
    Product(
      imageUrl:
          'https://cdn.squaresigns.com/images/blogs/handy-guide-to-a-breathtaking-trade-show-banner-design.jpeg',
      productName: 'Trade Show Banner',
      productPrice: 2999,
      productDescription:
          'Eye-catching banner for trade shows and exhibitions.',
      companyName: 'Exhibit Banners',
    ),
    Product(
      imageUrl:
          'https://cdn3.vectorstock.com/i/1000x1000/53/87/modern-event-banner-template-with-degrade-vector-44785387.jpg',
      productName: 'Event Banner',
      productPrice: 1799,
      productDescription: 'Versatile banner for various events.',
      companyName: 'Event Graphics',
    ),
    Product(
      imageUrl:
          'https://cdn.bannerbuzz.com/media/wysiwyg/new-description/Sports_Banners.png',
      productName: 'Sports Banner',
      productPrice: 1899,
      productDescription: 'Durable banner for sports events.',
      companyName: 'Sports Banners',
    ),
  ],
  'Canvas Painting': [
    Product(
      imageUrl:
          'https://www.jiomart.com/images/product/original/rvvgf4rnmz/elegance-beautiful-nature-landscape-digital-canvas-painting-big-unframed-canvas-48-x-32-inch-product-images-orvvgf4rnmz-p598467660-0-202302171032.jpg?im=Resize=(1000,1000)',
      productName: 'Landscape Canvas',
      productPrice: 3400,
      productDescription: 'Beautiful landscape painting on canvas.',
      companyName: 'Artistic Touch',
    ),
    Product(
      imageUrl:
          'https://static-01.daraz.pk/p/88c09099fcce67db1dba2285cf7e3a42.jpg_750x750.jpg_.webp',
      productName: 'Abstract Art',
      productPrice: 3500,
      productDescription: 'Colorful abstract art on canvas.',
      companyName: 'Modern Artworks',
    ),
    Product(
      imageUrl:
          'https://kotart.in/cdn/shop/files/CanvasAS446171.jpg?v=1697729028&width=1445',
      productName: 'Portrait Canvas',
      productPrice: 2500,
      productDescription: 'Stunning portrait painting on canvas.',
      companyName: 'Canvas Creations',
    ),
    Product(
      imageUrl:
          'https://kotart.in/cdn/shop/files/CanvasCS68112.jpg?v=1698340724&width=1445',
      productName: 'Floral Canvas',
      productPrice: 3400,
      productDescription: 'Vibrant floral painting on canvas.',
      companyName: 'Flower Art Studio',
    ),
    Product(
      imageUrl: 'https://i.icanvas.com/list-hero/scenic-seascapes.jpg',
      productName: 'Seascape Canvas',
      productPrice: 4000,
      productDescription: 'Serene seascape painting on canvas.',
      companyName: 'Ocean Artworks',
    ),
  ],
  'Quilting': [
    Product(
      imageUrl:
          'https://images.squarespace-cdn.com/content/61266b7ec0d66b344e266860/1636858677963-7ZUD80GPE8EIAAST1SYN/IMG_3122+%281%29.jpg?format=1500w&content-type=image%2Fjpeg',
      productName: 'Patchwork Quilt',
      productPrice: 3100,
      productDescription: 'Colorful patchwork quilt made from premium fabrics.',
      companyName: 'Cozy Quilts',
    ),
    Product(
      imageUrl:
          'https://sp.apolloboxassets.com/vendor/product/productImages/2022-04-14/r9nmmArray_14.jpg',
      productName: 'Floral Quilt',
      productPrice: 3000,
      productDescription: 'Beautiful floral quilt with intricate designs.',
      companyName: 'Flower Quilts',
    ),
    Product(
      imageUrl:
          'https://i0.wp.com/www.sewwhatalicia.com/wp-content/uploads/2020/06/modern-quilt-patterns-17.jpg?fit=700%2C1000&ssl=1',
      productName: 'Modern Quilt',
      productPrice: 2300,
      productDescription: 'Sleek modern quilt with geometric patterns.',
      companyName: 'Contemporary Quilts',
    ),
    Product(
      imageUrl:
          'https://sparklebeing.com/cdn/shop/files/Floral-Quilted-Makeup-Pouch-Small-Cosmetic-Bag-TravelToiletry-Organizer_7_2048x.jpg?v=1683221317',
      productName: 'Quilted Pouches',
      productPrice: 1200,
      productDescription: 'Vibrant quilt pocuhes with zips.',
      companyName: 'Unique Quilts',
    ),
    Product(
      imageUrl:
          'https://blog.fatquartershop.com/wp-content/uploads/2022/06/BG5NEW.jpg',
      productName: 'Baby Quilt',
      productPrice: 4000,
      productDescription: 'Soft and cozy quilt perfect for babies.',
      companyName: 'Baby Quilts Co.',
    ),
    Product(
      imageUrl:
          'https://patchworksampler.com/wp-content/uploads/2023/05/12-sister-bay-mat.jpg',
      productName: 'Quilt Mat',
      productPrice: 1209,
      productDescription: 'Quilt with designs inspired by different seasons.',
      companyName: 'Seasonal Quilts',
    ),
  ],

  'Sweaters': [
    Product(
      imageUrl:
          'https://images.squarespace-cdn.com/content/v1/5b857fa7d274cbd8da07321a/6f4a8e81-b569-4040-8ae6-b3d387ad37c0/IMG_4835.jpg',
      productName: 'Cable Knit Sweater',
      productPrice: 2500,
      productDescription:
          'Warm and cozy cable knit sweater made from premium wool.',
      companyName: 'Cozy Knits',
    ),
    Product(
      imageUrl:
          'https://shopbetseys.com/cdn/shop/products/chunky-knit-turtleneck-sweater-128162_1000x.jpg?v=1701933372',
      productName: 'Turtleneck Sweater',
      productPrice: 3000,
      productDescription: 'Classic turtleneck sweater with a modern twist.',
      companyName: 'Modern Knits',
    ),
    Product(
      imageUrl:
          'https://i.etsystatic.com/36870885/r/il/21a150/5458893785/il_fullxfull.5458893785_8igh.jpg',
      productName: 'Chunky Knit Sweater',
      productPrice: 5000,
      productDescription: 'Thick and chunky knit sweater for extra warmth.',
      companyName: 'Chunky Knits',
    ),
    Product(
      imageUrl: 'https://i.ebayimg.com/images/g/2ecAAOSwlCtk7hhG/s-l1600.jpg',
      productName: 'Cardigan Sweater',
      productPrice: 2000,
      productDescription: 'Versatile cardigan sweater with button-down front.',
      companyName: 'Cardigan Co.',
    ),
    Product(
      imageUrl:
          'https://easyasknit.com/cdn/shop/products/6CC435F7-8997-4578-9AEE-3CD1C997CE9F_72747592-64e4-4cdc-bc25-32aa0e80498f.jpg?v=1653555688',
      productName: 'Ribbed Sweater',
      productPrice: 5000,
      productDescription: 'Stylish ribbed sweater with a comfortable fit.',
      companyName: 'Ribbed Knits',
    ),
  ],
  'Socks': [
    Product(
      imageUrl:
          'https://images.squarespace-cdn.com/content/5e387ebfc182ca3ee4f87db8/1689960836140-Z9SUZAOWL00NJOIWKNQX/DSC_0735.jpg?content-type=image%2Fjpeg',
      productName: 'Cozy Wool Socks',
      productPrice: 800,
      productDescription: 'Soft wool socks to keep your feet warm and cozy.',
      companyName: 'Warm Feet Co.',
    ),
    Product(
      imageUrl:
          'https://images.squarespace-cdn.com/content/v1/64cd825ac82a17067bcec807/1691691306166-JUZ29DKGVUK0B0HDZTPW/free-easy-lace-summer-ankle-socks-knitting-pattern-1.jpg',
      productName: 'Ankle Socks',
      productPrice: 900,
      productDescription: 'Comfortable ankle socks for everyday wear.',
      companyName: 'Everyday Knits',
    ),
    Product(
      imageUrl:
          'https://images.squarespace-cdn.com/content/v1/5f501f67b4edd51d5726b7c7/1687462649086-3MHYK4PDF1WKAFMXJEE8/sock+5+PS-3.jpg?format=2500w',
      productName: 'Striped Socks',
      productPrice: 750,
      productDescription: 'Fun striped socks in vibrant colors.',
      companyName: 'Colorful Socks',
    ),
    Product(
      imageUrl:
          'https://www.sockgeeks.co.uk/cdn/shop/articles/Long_Socks_for_Women-Sock_Geeks.jpg?v=1710960103',
      productName: 'Knee-High Socks',
      productPrice: 1000,
      productDescription: 'Stylish knee-high socks perfect for chilly days.',
      companyName: 'Knee High Knits',
    ),
    Product(
      imageUrl:
          'https://biscotteyarns.com/cdn/shop/files/surprise3RESIZE_900x.jpg?v=1711493493',
      productName: 'Patterned Socks',
      productPrice: 800,
      productDescription: 'Unique patterned socks for a fun look.',
      companyName: 'Patterned Knits',
    ),
  ],
  'Scarves': [
    Product(
      imageUrl:
          'https://leeleeknits.com/wp-content/uploads/2016/12/BlueCableScarfHat-54.jpg',
      productName: 'Cable Knit Scarf',
      productPrice: 2000,
      productDescription: 'Cozy cable knit scarf made from soft wool.',
      companyName: 'Scarves & Knits',
    ),
    Product(
      imageUrl:
          'https://images.squarespace-cdn.com/content/v1/572f6d87b654f90629116055/1479230388540-KTECCQT8SYGNLE85QZ13/IMG_5879.JPG',
      productName: 'Infinity Scarf',
      productPrice: 2300,
      productDescription: 'Stylish infinity scarf perfect for layering.',
      companyName: 'Infinite Knits',
    ),
    Product(
      imageUrl:
          'https://craftsonair.com/wp-content/uploads/2023/12/01-Duille-Oversized-Scarf.jpeg',
      productName: 'Chunky Scarf',
      productPrice: 2500,
      productDescription: 'Thick and chunky scarf for extra warmth.',
      companyName: 'Chunky Knitwear',
    ),
    Product(
      imageUrl:
          'https://m.media-amazon.com/images/I/61gl5XCVIEL._AC_UY1000_.jpg',
      productName: 'Plaid Scarf',
      productPrice: 3000,
      productDescription: 'Classic plaid scarf with a timeless design.',
      companyName: 'Plaid Knits',
    ),
    Product(
      imageUrl:
          'https://www.muezart.com/cdn/shop/products/Untitleddesign_25.jpg?v=1624512270',
      productName: 'Striped Scarf',
      productPrice: 3299,
      productDescription: 'Colorful striped scarf for a fun pop of color.',
      companyName: 'Colorful Scarves',
    ),
  ],
  'Coats': [
    Product(
      imageUrl: 'https://www.byrdie.com/thmb/B7HTcOQGnZtb5Cpm1wX5HLbjuW0=/fit-in/1500x1429/filters:no_upscale():max_bytes(150000):strip_icc()/byr-peacoats-women-test-ll-bean-classic-lambswool-hannah-agran-5_crop-c02cd27d1954429496153818ed879f92.jpeg',
      productName: 'Classic Wool Coat',
      productPrice: 6000,
      productDescription: 'Warm and stylish wool coat for winter.',
      companyName: 'Elegant Threads',
    ),
    Product(
      imageUrl: 'https://shop.mango.com/assets/rcs/pics/static/T6/fotos/S/67046321_08.jpg?imwidth=2048&imdensity=1&ts=1708693419378',
      productName: 'Trench Coat',
      productPrice: 6999,
      productDescription: 'Classic trench coat for a sophisticated look.',
      companyName: 'Fashion Forward',
    ),
    Product(
      imageUrl: 'https://cdni.llbean.net/is/image/wim/260345_2772_41?hei=1095&wid=950&resMode=sharp2&defaultImage=llbprod/260345_2772_41',
      productName: 'Peacoat',
      productPrice: 6499,
      productDescription: 'Navy blue peacoat for a timeless style.',
      companyName: 'Urban Elegance',
    ),
    Product(
      imageUrl: 'https://mamasmarketplace.pk/cdn/shop/files/22A3BDDD-BCE5-4D94-B8D4-B60C8E79D5AF.jpg?v=1708471698',
      productName: 'Puffer Jacket',
      productPrice: 6000,
      productDescription: 'Lightweight puffer jacket for warmth and comfort.',
      companyName: 'Adventure Gear',
    ),
    Product(
      imageUrl: 'https://media.karenmillen.com/i/karenmillen/bkk14753_camel_xl?pdp.template',
      productName: 'Double-Breasted Coat',
      productPrice: 10000,
      productDescription: 'Stylish double-breasted coat for formal occasions.',
      companyName: 'Tailored Fit',
    ),

  ],
  'Pants': [
    Product(
      imageUrl: 'https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_22_kv.jpg?240711',
      productName: 'Slim Fit Chinos',
      productPrice: 2999,
      productDescription: 'Comfortable slim fit chinos for everyday wear.',
      companyName: 'Casual Essentials',
    ),
    Product(
      imageUrl: 'https://www.thepinkdesert.com/cdn/shop/files/DSC01733.jpg?v=1692810594',
      productName: 'Straight Leg Jeans',
      productPrice: 3499,
      productDescription: 'Classic straight leg jeans for a timeless look.',
      companyName: 'Denim Co.',
    ),
    Product(
      imageUrl: 'https://cdn.suitdirect.co.uk/upload/siteimages/medium/ar24155mt_250_a.jpg',
      productName: 'Formal Trousers',
      productPrice: 3999,
      productDescription: 'Sharp formal trousers for office wear.',
      companyName: 'Office Attire',
    ),
    Product(
      imageUrl: 'https://theoctopus.pk/cdn/shop/files/BDD12BEB-29F3-4BC2-945F-E39354B6D820_1200x.jpg?v=1716571562',
      productName: 'Cargo Pants',
      productPrice: 2599,
      productDescription: 'Durable cargo pants with multiple pockets.',
      companyName: 'Outdoor Wear',
    ),
    Product(
      imageUrl: 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1707421767-under-armour-65c5302e55ae3.jpg?crop=1xw:1xh;center,top&resize=980:*',
      productName: 'Jogger Pants',
      productPrice: 2199,
      productDescription: 'Relaxed jogger pants for casual outings.',
      companyName: 'Active Lifestyle',
    ),
    Product(
      imageUrl: 'https://dynamic.zacdn.com/2_Lk_o-03Ac5RwrOc9Uic0lw3pM=/filters:quality(70):format(webp)/https://static-hk.zacdn.com/p/happiness-istanbul-9266-3814556-1.jpg',
      productName: 'High-Waisted Trousers',
      productPrice: 3299,
      productDescription: 'Trendy high-waisted trousers for a chic look.',
      companyName: 'Modern Styles',
    ),
  ],
  'Shirts': [
    Product(
      imageUrl: 'https://m.media-amazon.com/images/I/71GulHVoa2L._AC_UY1000_.jpg',
      productName: 'Cotton Button-Up Shirt',
      productPrice: 1999,
      productDescription:
          'Classic cotton button-up shirt for formal occasions.',
      companyName: 'Formal Wear',
    ),
    Product(
      imageUrl: 'https://img.ltwebstatic.com/images3_pi/2023/12/19/26/1702971068364c1f2cc0dec21eec9f42cfb2458d82_thumbnail_720x.jpg',
      productName: 'Linen Casual Shirt',
      productPrice: 2499,
      productDescription: 'Lightweight linen shirt for a relaxed vibe.',
      companyName: 'Summer Styles',
    ),
    Product(
      imageUrl: 'https://forge.pk/cdn/shop/files/IMG_5592_800x.jpg?v=1691939925',
      productName: 'Plaid Flannel Shirt',
      productPrice: 1899,
      productDescription: 'Cozy plaid flannel shirt for cooler days.',
      companyName: 'Winter Essentials',
    ),
    Product(
      imageUrl: 'https://chiefapparel.pk/cdn/shop/files/file_8_copy_2.webp?v=1689614810&width=2000',
      productName: 'Denim Shirt',
      productPrice: 2799,
      productDescription: 'Trendy denim shirt for a laid-back look.',
      companyName: 'Casual Classics',
    ),
    Product(
      imageUrl: 'https://i5.walmartimages.com/seo/Fule-Mens-Satin-Silk-Dress-Shirt-Long-Sleeve-Casual-Button-Down-Shirts-Wedding-Party_b4c87d86-0eb1-4c0d-a56b-0f26a246a0bf.2b4b54c141c6bd4e1e0cab6a64c7d702.jpeg',
      productName: 'Silk Dress Shirt',
      productPrice: 3999,
      productDescription: 'Elegant silk shirt for formal events.',
      companyName: 'Luxury Line',
    ),
    Product(
      imageUrl: 'https://funsies.pk/cdn/shop/products/GoodVibesOnlyGTTTTTT.jpg?v=1681903147',
      productName: 'Graphic Tee',
      productPrice: 999,
      productDescription: 'Casual graphic tee with a unique print.',
      companyName: 'Urban Vibe',
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
                  icon: Icon(Icons.arrow_back,
                      color: Colors.white), // Set back button color to white
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
                        .where('product subcategory',
                            isEqualTo: subcategoryName)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final firestoreProducts = snapshot.data?.docs.map((doc) {
                            final productData =
                                doc.data() as Map<String, dynamic>;
                            return Product(
                              imageUrl: productData['Image URl'] ?? '',
                              productName: productData['product name'] ??
                                  'Unnamed Product',
                              productPrice: double.tryParse(
                                      productData['product price'] ?? '0') ??
                                  0.0,
                              productDescription:
                                  productData['product description'] ?? '',
                              companyName: productData['company name'] ?? '',
                            );
                          }).toList() ??
                          [];

                      // Get dummy products for the current subcategory
                      final dummyProducts =
                          dummyProductsBySubcategory[subcategoryName] ?? [];

                      // Combine Firestore products with dummy products
                      final allProducts = [
                        ...firestoreProducts,
                        ...dummyProducts
                      ];

                      if (allProducts.isEmpty) {
                        return Center(
                            child: Text(
                          'No products available for this subcategory',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ));
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
                                    productDescription:
                                        product.productDescription,
                                    ImageURL: product.imageUrl,
                                    companyName: product.companyName,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2, // Adjust elevation as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    4.0), // Rounded corners
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height:
                                        120, // Adjust the height for the image container
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(
                                              4.0)), // Rounded top edges
                                      image: DecorationImage(
                                        image: product.imageUrl.isNotEmpty
                                            ? NetworkImage(product.imageUrl)
                                            : AssetImage(
                                                    'assets/placeholder.png')
                                                as ImageProvider,
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
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
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
