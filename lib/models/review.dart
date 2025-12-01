class Review {
  final String id;
  final String salonId;
  final String salonName;
  final int rating; // 1-5
  final String comment;
  final DateTime visitDate;
  final DateTime createdAt;
  final bool isModerated;
  final List<String>? photos;

  Review({
    required this.id,
    required this.salonId,
    required this.salonName,
    required this.rating,
    required this.comment,
    required this.visitDate,
    required this.createdAt,
    this.isModerated = false,
    this.photos,
  });

  String get formattedDate {
    return '${visitDate.day.toString().padLeft(2, '0')}.${visitDate.month.toString().padLeft(2, '0')}.${visitDate.year}';
  }

  String get shortComment {
    if (comment.length <= 100) return comment;
    return '${comment.substring(0, 100)}...';
  }
}