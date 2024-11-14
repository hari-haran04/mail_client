import 'package:flutter/material.dart';
import 'package:mail_client/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> signUp(String firstName, String lastName, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    bool success = await AuthService().signUp(firstName, lastName, email, password);
    _isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    bool success = await AuthService().signIn(email, password);
    _isLoading = false;
    notifyListeners();
    return success;
  }
}
