
import 'package:flutter/material.dart';
import 'package:project_1/provider/PaymentProvider.dart';
import 'package:project_1/screen/PaymentFailureScreen.dart';
import 'package:project_1/screen/PaymentSuccessScreen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../models/payment_status.dart';


class PaymentGatewayScreen extends StatefulWidget {
  @override
  _PaymentGatewayScreenState createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();


    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //  _razorpay.on(Razorpay.EVENT_PAYMENT_CANCELLED, _handlePaymentCancel);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  // Payment Success Handler
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Success: ${response.paymentId}");

    Provider.of<PaymentProvider>(context, listen: false).setStatus(PaymentStatus.success);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PaymentSuccessScreen()));
  }

  // Payment Error Handler
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error code: ${response.code}");
    print("Error message: ${response.message}");

    if (response.code == 2) {
      // Code 2 indicates payment cancelled by user
      print("Payment was cancelled by the user.");
      Provider.of<PaymentProvider>(context, listen: false).setStatus(PaymentStatus.cancelled);
    } else {
      // Any other error
      print("Payment failed.");
      Provider.of<PaymentProvider>(context, listen: false).setStatus(PaymentStatus.failure);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => PaymentFailureScreen()),
    );
  }


  // Payment Cancel Handler
  // void _handlePaymentCancel(PaymentCancelResponse response) {
  //   print("Payment Cancelled: ${response.paymentId}");
  //   // Handle cancellation
  //   Provider.of<PaymentProvider>(context, listen: false).setStatus(PaymentStatus.cancelled);
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PaymentFailureScreen()));
  // }

  void _startPayment(double amount) {
    var options = {
      'key': 'rzp_test_ne8WGPosJBjDuM',
      'amount': (amount * 100).toInt(),
      'name': 'Subscription Payment',
      'description': 'Premium Subscription',
      'prefill': {'contact': '', 'email': ''},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = Provider.of<PaymentProvider>(context).amount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Payment Gateway")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0), // Corner radius
            ),
          ),
          child: Text("Pay ₹$amount"),
          onPressed: () => _startPayment(amount),
        ),
      ),
    );
  }
}
