import 'package:deepfake/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../repository/auth_repository.dart';

class AuthController with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  bool _isPasswordToggled = false;

  bool _isSigningUp = false;

  bool _isLogin = false;

  bool get isLoading => _isLoading;
  bool get isPasswordToggled => _isPasswordToggled;

  bool get isSigningUp => _isSigningUp;

  bool get isLogin => _isLogin;

  void setLogin(bool v) {
    _isLogin = v;
    notifyListeners();
  }

  void setSigningUp(bool v) {
    _isSigningUp = v;
    notifyListeners();
  }

  void setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void setPasswordToggled() {
    _isPasswordToggled = !_isPasswordToggled;
    notifyListeners();
  }

  Future<bool> signup({required BuildContext context, required String username, required String email, required String password, required String
  confirmPassword}) async {
    setSigningUp(true);
    try {
      final response = await _authRepository.signupUser(username: username, email: email, confirmPassword: confirmPassword);
      setSigningUp(false);
      if (!context.mounted) return false;
      Utils.instance.showSnakeBar(context: context, title: response['message']);
      return true;
    } catch (e) {
      debugPrint("Signup error: $e");
      setSigningUp(false);
      if (!context.mounted) return false;
      Utils.instance.showSnakeBar(context: context, title: e.toString());
      return false;
    }
  }

  Future<bool> login({required BuildContext context, required String username, required String password}) async {
    setLogin(true);
    try {
      final response = await _authRepository.loginUser(email: username, password: password);
      setLogin(false);

      if (response['login'] != true) {
        if (!context.mounted) return false;
        Utils.instance.showSnakeBar(context: context, title: 'Unable to login, please check your username and password.');
        return false;
      }

      if (!context.mounted) return false;
      Utils.instance.showSnakeBar(context: context, title: 'Login Successful.');
      return true;
    } catch (e) {
      debugPrint("Signup error: $e");
      setLogin(false);
      if (!context.mounted) return false;
      Utils.instance.showSnakeBar(context: context, title: e.toString());
      return false;
    }
  }
}
