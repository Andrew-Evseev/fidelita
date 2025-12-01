import 'package:flutter/foundation.dart';
import '../models/review.dart';

class ReviewService with ChangeNotifier {
  List<Review> _reviews = [];
  bool _isLoading = false;

  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;
  int get totalReviews => _reviews.length;
  double get averageRating {
    if (_reviews.isEmpty) return 0;
    return _reviews.map((r) => r.rating).reduce((a, b) => a + b) / _reviews.length;
  }

  ReviewService() {
    _loadDemoReviews();
  }

  void _loadDemoReviews() {
    _reviews = [
      Review(
        id: '1',
        salonId: 'salon_1',
        salonName: 'Салон Эстель',
        rating: 5,
        comment: 'Отличный сервис! Мастер Анна - профессионал своего дела. Очень внимательна к деталям.',
        visitDate: DateTime.now().subtract(const Duration(days: 7)),
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        isModerated: true,
      ),
      Review(
        id: '2',
        salonId: 'salon_1',
        salonName: 'Салон Эстель',
        rating: 4,
        comment: 'Хороший салон, приятная атмосфера. Чуть дороговато, но качество того стоит.',
        visitDate: DateTime.now().subtract(const Duration(days: 14)),
        createdAt: DateTime.now().subtract(const Duration(days: 13)),
        isModerated: true,
      ),
    ];
  }

  Future<void> submitReview({
    required String salonId,
    required String salonName,
    required int rating,
    required String comment,
    required DateTime visitDate,
    List<String>? photos,
  }) async {
    _isLoading = true;
    notifyListeners();

    // Имитация отправки на сервер
    await Future.delayed(const Duration(seconds: 2));

    final newReview = Review(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      salonId: salonId,
      salonName: salonName,
      rating: rating,
      comment: comment,
      visitDate: visitDate,
      createdAt: DateTime.now(),
      photos: photos,
    );

    _reviews.insert(0, newReview);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteReview(String reviewId) async {
    _reviews.removeWhere((review) => review.id == reviewId);
    notifyListeners();
  }

  List<Review> getReviewsBySalon(String salonId) {
    return _reviews.where((review) => review.salonId == salonId).toList();
  }
}