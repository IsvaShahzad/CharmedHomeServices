import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Consumer_Screens/favourites.dart';
import 'package:provider/provider.dart';
import 'InitialScreens/splash_screen.dart';
import 'seller/cart.dart';
import 'Providers/seller_cart_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavouriteProductPageProvider>(
          create: (_) => FavouriteProductPageProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        ),

        // Add other providers here if needed
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 804),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(

            theme: ThemeData(
              scaffoldBackgroundColor:  Color(0xffffa7a6),
              primarySwatch: Colors.purple,
              // accentColor: Colors.pink,
              inputDecorationTheme: const InputDecorationTheme(
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(width: 1, color: Color(0xffffa7a6)),
                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(width: 1, color: Color(0xffffa7a6)),
                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                // ),
              ),
            ),
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
