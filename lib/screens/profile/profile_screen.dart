import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fidelita/services/user_service.dart';
import 'package:fidelita/utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 30),
          _buildVisitHistory(context),
          const SizedBox(height: 30),
          _buildMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, userService, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [AppTheme.cardShadow],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF8B7355),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userService.userName ?? 'Гость',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userService.phone ?? 'Не указан',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userService.email ?? 'Не указан',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVisitHistory(BuildContext context) {
    final visits = [
      {'service': 'Стрижка и укладка', 'date': '15 дек 2024', 'master': 'Мария', 'price': '2500 ₽'},
      {'service': 'Маникюр', 'date': '10 дек 2024', 'master': 'Анна', 'price': '1500 ₽'},
      {'service': 'Спа-процедура', 'date': '1 дек 2024', 'master': 'Елена', 'price': '3000 ₽'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'История посещений',
          style: Theme.of(context).textTheme.displayMedium,
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
              Icons.spa,
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
          Text(
            visit['price'],
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF8B7355),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      {'icon': Icons.qr_code, 'title': 'Мой QR-код'},
      {'icon': Icons.notifications, 'title': 'Уведомления'},
      {'icon': Icons.favorite, 'title': 'Избранные услуги'},
      {'icon': Icons.star, 'title': 'Мои отзывы'},
      {'icon': Icons.settings, 'title': 'Настройки'},
      {'icon': Icons.help, 'title': 'Помощь'},
    ];

    return Column(
      children: menuItems.map((item) => _buildMenuItem(context, item)).toList(),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF8B7355).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            item['icon'],
            color: const Color(0xFF8B7355),
          ),
        ),
        title: Text(
          item['title'],
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF8B7355),
        ),
        onTap: () {
          // Обработка нажатия на пункт меню
        },
      ),
    );
  }
}