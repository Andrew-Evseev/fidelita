import 'package:flutter/foundation.dart';

class UserService with ChangeNotifier {
  String? _userName;
  String? _email;
  String? _phone;
  int? _bonusBalance;
  int? _visitsCount;
  List<Map<String, dynamic>> _visitHistory = [];
  bool _isAuthenticated = false;
  bool _hasCompletedOnboarding = false;

  String? get userName => _userName;
  String? get email => _email;
  String? get phone => _phone;
  int? get bonusBalance => _bonusBalance;
  int? get visitsCount => _visitsCount;
  List<Map<String, dynamic>> get visitHistory => _visitHistory;
  bool get isAuthenticated => _isAuthenticated;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;

  void setUser(String name, String email, String phone, int bonusBalance, int visitsCount) {
    _userName = name;
    _email = email;
    _phone = phone;
    _bonusBalance = bonusBalance;
    _visitsCount = visitsCount;
    notifyListeners();
  }

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

  void addBonus(int amount) {
    _bonusBalance = (_bonusBalance ?? 0) + amount;
    notifyListeners();
  }

  void spendBonus(int amount) {
    if (_bonusBalance != null && _bonusBalance! >= amount) {
      _bonusBalance = _bonusBalance! - amount;
      notifyListeners();
    }
  }

  void addVisit(Map<String, dynamic> visit) {
    _visitHistory.add(visit);
    _visitsCount = (_visitsCount ?? 0) + 1;
    notifyListeners();
  }

  void clearUser() {
    _userName = null;
    _email = null;
    _phone = null;
    _bonusBalance = null;
    _visitsCount = null;
    _visitHistory = [];
    notifyListeners();
  }
}