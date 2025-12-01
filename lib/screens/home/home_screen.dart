import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fidelita/services/user_service.dart';
import 'package:fidelita/utils/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeContent();
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);
    
    // Инициализируем тестовые данные для салона красоты
    userService.setUser(
      'Анна Петрова',
      'anna@example.com',
      '+7 (912) 345-67-89',
      1250, // бонусы
      12,   // посещений
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(context),
          const SizedBox(height: 30),
          _buildBonusCard(context),
          const SizedBox(height: 25),
          _buildQuickActions(context),
          const SizedBox(height: 25),
          _buildUpcomingVisits(context),
          const SizedBox(height: 25),
          _buildSpecialOffers(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, userService, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Добро пожаловать,',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userService.userName ?? 'Гость',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        );
      },
    );
  }

  Widget _buildBonusCard(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, userService, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [AppTheme.cardShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ваши бонусы',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${userService.visitsCount ?? 0} посещений',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${userService.bonusBalance ?? 0} бонусов',
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '1 бонус = 1 рубль',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.qr_code, 'label': 'QR-код', 'color': const Color(0xFF8B7355), 'onTap': () {
        Navigator.pushNamed(context, '/qr');
      }},
      {'icon': Icons.calendar_today, 'label': 'Запись', 'color': const Color(0xFFC5A47E), 'onTap': () {}},
      {'icon': Icons.history, 'label': 'История', 'color': const Color(0xFF8B7355), 'onTap': () {}},
      {'icon': Icons.star, 'label': 'Акции', 'color': const Color(0xFFC5A47E), 'onTap': () {}},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Быстрые действия',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: actions.map((action) => _buildActionButton(context, action)).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, Map<String, dynamic> action) {
    return GestureDetector(
      onTap: action['onTap'],
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: action['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: action['color'].withOpacity(0.3)),
            ),
            child: Icon(
              action['icon'],
              size: 28,
              color: action['color'],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            action['label'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingVisits(BuildContext context) {
    final visits = [
      {'service': 'Стрижка и укладка', 'date': 'Сегодня, 15:00', 'master': 'Мария'},
      {'service': 'Маникюр', 'date': 'Завтра, 11:00', 'master': 'Анна'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ближайшие визиты',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              'Все',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF8B7355),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...visits.map((visit) => _buildVisitItem(context, visit)),
      ],
    );
  }

  Widget _buildVisitItem(BuildContext context, Map<String, dynamic> visit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF8B7355).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Color(0xFF8B7355),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visit['service'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${visit['date']} • ${visit['master']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF8B7355)),
            onPressed: () {
              // Напоминание о визите
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOffers(BuildContext context) {
    final offers = [
      {'title': 'Персональная скидка 20%', 'description': 'На все услуги до конца месяца', 'color': const Color(0xFFC5A47E)},
      {'title': 'Приведи друга', 'description': 'Получи 500 бонусов за каждого', 'color': const Color(0xFF8B7355)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Специальные предложения',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        ...offers.map((offer) => _buildOfferItem(context, offer)),
      ],
    );
  }

  Widget _buildOfferItem(BuildContext context, Map<String, dynamic> offer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [offer['color'].withOpacity(0.1), offer['color'].withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: offer['color'].withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: offer['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.local_offer,
              color: offer['color'],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer['title'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  offer['description'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}