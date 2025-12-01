class BonusOperation {
  final String id;
  final String type; // 'earn' или 'spend'
  final int amount;
  final String description;
  final DateTime date;
  final String? salonName;

  BonusOperation({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
    this.salonName,
  });

  String get formattedDate {
    return '${date.day}.${date.month}.${date.year}';
  }

  bool get isEarned => type == 'earn';
}