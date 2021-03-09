import 'package:flutter/material.dart';

class PasswordResetProvider extends ChangeNotifier {
  bool emailSent = false;

  updateEmailSent(bool emailSent) {
    this.emailSent = emailSent;
    notifyListeners();
  }
}
