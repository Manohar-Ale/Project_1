
import 'package:flutter/material.dart';
import 'package:project_1/provider/PaymentProvider.dart';
import 'package:project_1/screen/PaymentGatewayScreen.dart';
import 'package:provider/provider.dart';


class SubscriptionScreen extends StatelessWidget {
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Subscribe")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Subscription Amount"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0), // Corner radius
                ),
              ),
              onPressed: () {
                final amount = double.tryParse(amountController.text);
                if (amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter a valid amount")));
                } else {
                  Provider.of<PaymentProvider>(context, listen: false).setAmount(amount);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentGatewayScreen()));
                }
              },
              child: Text("Subscribe to Premium"),
            )
          ],
        ),
      ),
    );
  }
}
