import 'package:flutter/foundation.dart';
import '../models/bonus_operation.dart';

class BonusService with ChangeNotifier {
  List<BonusOperation> _operations = [];
  int _balance = 150;

  List<BonusOperation> get operations => _operations;
  int get balance => _balance;

  BonusService() {
    // Демо-данные
    _operations = [
      BonusOperation(
        id: '1',
        type: 'earn',
        amount: 50,
        description: 'Посещение салона "Эстель"',
        date: DateTime.now().subtract(const Duration(days: 1)),
        salonName: 'Салон Эстель',
      ),
      BonusOperation(
        id: '2',
        type: 'earn',
        amount: 100,
        description: 'Приветственные бонусы',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      BonusOperation(
        id: '3',
        type: 'spend',
        amount: 50,
        description: 'Оплата стрижки',
        date: DateTime.now().subtract(const Duration(days: 3)),
        salonName: 'Барбершоп №1',
      ),
      BonusOperation(
        id: '4',
        type: 'earn',
        amount: 75,
        description: 'Посещение spa-комплекса',
        date: DateTime.now().subtract(const Duration(days: 5)),
        salonName: 'SPA Люкс',
      ),
    ];
  }

  void addOperation(BonusOperation operation) {
    _operations.insert(0, operation);
    if (operation.isEarned) {
      _balance += operation.amount;
    } else {
      _balance -= operation.amount;
    }
    notifyListeners();
  }

  List<BonusOperation> get recentOperations {
    return _operations.take(5).toList();
  }
}