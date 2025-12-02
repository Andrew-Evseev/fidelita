import 'package:flutter/foundation.dart';

class AdminAuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isChecking = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isChecking => _isChecking;

  Future<void> checkAuthStatus() async {
    // В будущем можно добавить проверку из shared_preferences
    // Пока просто для совместимости
    _isChecking = true;
    notifyListeners();
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    _isChecking = false;
    notifyListeners();
  }

  Future<bool> login(String password) async {
    _isChecking = true;
    notifyListeners();

    // Имитация проверки пароля
    await Future.delayed(const Duration(milliseconds: 1000));

    // Демо-пароли
    if (password == 'admin123' || password == 'fidelita2024') {
      _isAuthenticated = true;
      _isChecking = false;
      notifyListeners();
      return true;
    }

    _isChecking = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}