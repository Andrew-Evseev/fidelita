import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _hasCompletedOnboarding = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  void completeOnboarding() {
    _hasCompletedOnboarding = true;
    notifyListeners();
  }

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}