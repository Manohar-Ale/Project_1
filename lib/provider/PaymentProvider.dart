// providers/payment_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/payment_status.dart';

class PaymentProvider with ChangeNotifier {
  double _amount = 0;
  PaymentStatus _status = PaymentStatus.none;

  double get amount => _amount;
  PaymentStatus get status => _status;

  void setAmount(double value) {
    _amount = value;
    notifyListeners();
  }

  void setStatus(PaymentStatus status) {
    _status = status;
    saveStatusToPrefs(status);
    notifyListeners();
  }

  Future<void> saveStatusToPrefs(PaymentStatus status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('payment_status', status.toString());
  }

  Future<void> loadStatusFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final statusString = prefs.getString('payment_status') ?? 'PaymentStatus.none';
    _status = PaymentStatus.values.firstWhere(
          (e) => e.toString() == statusString,
      orElse: () => PaymentStatus.none,
    );
    notifyListeners();
  }
}
