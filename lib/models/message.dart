class Message {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isUser;
  final bool isRead;
  final String? salonName;
  final String? senderName;

  Message({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isUser,
    this.isRead = false,
    this.salonName,
    this.senderName,
  });

  String get formattedTime {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (messageDay == today) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (messageDay == today.subtract(const Duration(days: 1))) {
      return 'Вчера';
    } else {
      return '${timestamp.day.toString().padLeft(2, '0')}.${timestamp.month.toString().padLeft(2, '0')}';
    }
  }

  Message copyWith({
    bool? isRead,
  }) {
    return Message(
      id: id,
      text: text,
      timestamp: timestamp,
      isUser: isUser,
      isRead: isRead ?? this.isRead,
      salonName: salonName,
      senderName: senderName,
    );
  }
}