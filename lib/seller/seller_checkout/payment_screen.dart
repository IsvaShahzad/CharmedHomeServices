import 'package:flutter/material.dart';
import '../cart.dart';
import 'delivered_screen.dart';
import 'shipping_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCheckboxChecked = false;
  final Cart _cart = Cart();

  void placeOrder() {
    if (!isCheckboxChecked) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0), // Make the dialog more square-like
            ),
            title: Text(
              'Error',
              style: TextStyle(
                fontFamily: 'Montserrat',
              ),
            ),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8, // Responsive width
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  'Please confirm your order by checking the checkbox.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => DeliveredScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ShippingScreen()));
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05), // Responsive spacing
              Text(
                'Select a Payment Method',
                style: TextStyle(
                  fontSize: screenWidth * 0.05, // Responsive font size
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Card(
                elevation: 1.0, // Set the elevation to a smaller value
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: isCheckboxChecked,
                    onChanged: (value) {
                      setState(() {
                        isCheckboxChecked = value!;
                      });
                    },
                  ),
                  title: Text(
                    'Cash on Delivery',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      fontSize: screenWidth * 0.045, // Responsive font size
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '*Parcel delivered to your door. Tip the rider!*',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035, // Responsive font size
                    color: Colors.blueGrey,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            SizedBox(
              height: 120,
            ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity, // Full width of the parent
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0), // Responsive padding
                    child: ElevatedButton(
                      onPressed: () {
                        placeOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffcc9a9d),
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // Responsive padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        elevation: 1.0, // Elevation of the button
                      ),
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedCard extends StatelessWidget {
  final Widget child;

  const ElevatedCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
