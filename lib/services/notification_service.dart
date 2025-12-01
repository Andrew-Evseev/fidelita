import 'package:flutter/foundation.dart';

class NotificationService with ChangeNotifier {
  bool _notificationsEnabled = true;
  List<Map<String, dynamic>> _notifications = [];

  bool get notificationsEnabled => _notificationsEnabled;
  List<Map<String, dynamic>> get notifications => _notifications;

  NotificationService() {
    _loadDemoNotifications();
  }

  void _loadDemoNotifications() {
    _notifications = [
      {
        'id': '1',
        'title': 'Добро пожаловать!',
        'body': 'Вы успешно зарегистрировались в Fidelita',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'read': true,
        'type': 'welcome',
      },
    ];
  }

  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      _notifications[index]['read'] = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification['read'] = true;
    }
    notifyListeners();
  }

  int get unreadCount {
    return _notifications.where((n) => !n['read']).length;
  }

  // Демо-уведомления для тестирования
  void sendDemoNotification({String title = 'Демо уведомление', String body = 'Это тестовое уведомление'}) {
    final notification = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'body': body,
      'timestamp': DateTime.now(),
      'type': 'demo',
      'read': false,
    };

    _notifications.insert(0, notification);
    notifyListeners();
  }
}