
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/PaymentProvider.dart';
import 'screen/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentProvider()..loadStatusFromPrefs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Subscription App',
        theme: ThemeData(useMaterial3: true),
        home: LoginScreen(),
      ),
    );
  }
}
