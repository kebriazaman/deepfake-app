import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  bool _isLoading = false;
  bool _isPasswordToggled = false;


  bool get isLoading => _isLoading;
  bool get isPasswordToggled => _isPasswordToggled;

  void setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void setPasswordToggled() {
    _isPasswordToggled = !_isPasswordToggled;
    notifyListeners();
  }

}