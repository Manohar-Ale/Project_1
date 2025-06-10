// screens/payment_gateway_screen.dart
import 'package:flutter/material.dart';
import 'package:project_1/provider/PaymentProvider.dart';
import 'package:project_1/screen/PaymentFailureScreen.dart';
import 'package:project_1/screen/PaymentSuccessScreen.dart';
import 'package:provider/provider.dart';
import '../models/payment_status.dart';


class PaymentGatewayScreen extends StatefulWidget {
  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Provider.of<PaymentProvider>(context, listen: false).setStatus(PaymentStatus.cancelled);
    }
  }

  void _handlePayment(PaymentStatus status) {
    final provider = Provider.of<PaymentProvider>(context, listen: false);
    provider.setStatus(status);

    if (status == PaymentStatus.success) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PaymentSuccessScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PaymentFailureScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = Provider.of<PaymentProvider>(context).amount;
    return Scaffold(
      appBar: AppBar(title: Text("Processing ₹$amount")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(child: Text("Simulate Success"), onPressed: () => _handlePayment(PaymentStatus.success)),
          ElevatedButton(child: Text("Simulate Failure"), onPressed: () => _handlePayment(PaymentStatus.failure)),
          ElevatedButton(child: Text("Simulate Cancel"), onPressed: () => _handlePayment(PaymentStatus.cancelled)),
        ]),
      ),
    );
  }
}
