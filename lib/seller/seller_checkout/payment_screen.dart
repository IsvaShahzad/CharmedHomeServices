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
    if (isCheckboxChecked != true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please confirm your order by checking the checkbox.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pastel.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text('Payment Method'),
          ),
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.0),
              Text(
                'Select a Payment Method',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedCard(
                child: ListTile(
                  leading: Checkbox(
                    value: isCheckboxChecked,
                    onChanged: (value) {
                      setState(() {
                        isCheckboxChecked = value!;
                      });
                    },
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cash on Delivery',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '* Parcel will be delivered at your doorstep, tip the rider! *',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 120),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    placeOrder();

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAB47BC),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10.0, // Elevation of the button
                  ),
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}