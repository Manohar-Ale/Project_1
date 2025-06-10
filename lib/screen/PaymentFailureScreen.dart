// screens/payment_failure_screen.dart
import 'package:flutter/material.dart';
import 'package:project_1/screen/PaymentGatewayScreen.dart';


class PaymentFailureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Failed")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Payment failed or cancelled ❌"),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Retry Payment"),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PaymentGatewayScreen()));
            },
          )
        ]),
      ),
    );
  }
}
