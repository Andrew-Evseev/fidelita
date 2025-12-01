import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/review_service.dart';
import '../../models/review.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final List<String> _salons = [
    'Салон Эстель',
    'SPA Люкс', 
    'Барбершоп №1',
    'Ноготок',
    'Салон Красоты'
  ];

  String _selectedSalon = 'Салон Эстель';

  @override
  Widget build(BuildContext context) {
    final reviewService = Provider.of<ReviewService>(context);
    final salonReviews = reviewService.reviews.where((r) => r.salonName == _selectedSalon).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои отзывы'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddReviewDialog(context);
            },
            tooltip: 'Добавить отзыв',
          ),
        ],
      ),
      body: Column(
        children: [
          // Фильтр по салонам
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: DropdownButtonFormField<String>(
              value: _selectedSalon,
              decoration: const InputDecoration(
                labelText: 'Выберите салон',
                border: OutlineInputBorder(),
              ),
              items: _salons.map((String salon) {
                return DropdownMenuItem<String>(
                  value: salon,
                  child: Text(salon),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSalon = newValue!;
                });
              },
            ),
          ),
          // Статистика
          _buildStatsSection(reviewService, salonReviews),
          // Список отзывов
          Expanded(
            child: salonReviews.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: salonReviews.length,
                    itemBuilder: (context, index) {
                      return _buildReviewCard(salonReviews[index], reviewService);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(ReviewService reviewService, List<Review> salonReviews) {
    final averageRating = salonReviews.isEmpty 
        ? 0 
        : salonReviews.map((r) => r.rating).reduce((a, b) => a + b) / salonReviews.length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF8B7355),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Всего отзывов', salonReviews.length.toString()),
          _buildStatItem('Средняя оценка', averageRating.toStringAsFixed(1)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Review review, ReviewService reviewService) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.salonName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                _buildRatingStars(review.rating),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.formattedDate,
              style: const TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: review.isModerated ? Colors.green.shade50 : Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    review.isModerated ? 'Опубликован' : 'На модерации',
                    style: TextStyle(
                      color: review.isModerated ? Colors.green : Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18),
                  onPressed: () {
                    _showDeleteDialog(review, reviewService);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: const Color(0xFF8B7355),
          size: 20,
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.reviews, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Отзывов пока нет',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Оставьте первый отзыв о посещении салона',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _showAddReviewDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B7355),
            ),
            child: const Text('Добавить отзыв'),
          ),
        ],
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    String selectedSalon = _salons.first;
    int rating = 5;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Добавить отзыв'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedSalon,
                    decoration: const InputDecoration(
                      labelText: 'Салон',
                      border: OutlineInputBorder(),
                    ),
                    items: _salons.map((String salon) {
                      return DropdownMenuItem<String>(
                        value: salon,
                        child: Text(salon),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSalon = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Оценка:'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: const Color(0xFF8B7355),
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: commentController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Ваш отзыв',
                      border: OutlineInputBorder(),
                      hintText: 'Поделитесь впечатлениями о посещении...',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  final reviewService = Provider.of<ReviewService>(context, listen: false);
                  reviewService.submitReview(
                    salonId: selectedSalon.toLowerCase().replaceAll(' ', '_'),
                    salonName: selectedSalon,
                    rating: rating,
                    comment: commentController.text,
                    visitDate: DateTime.now(),
                  );
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Отзыв успешно добавлен!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                ),
                child: const Text('Отправить'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteDialog(Review review, ReviewService reviewService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить отзыв?'),
        content: const Text('Вы уверены, что хотите удалить этот отзыв?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              reviewService.deleteReview(review.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Отзыв удален')),
              );
            },
            child: const Text(
              'Удалить',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}