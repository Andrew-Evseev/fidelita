import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fidelita/services/user_service.dart';
import 'package:fidelita/utils/theme.dart';
import 'package:fidelita/admin/auth/admin_login_screen.dart';

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
          _buildBonusCard(context),
          const SizedBox(height: 30),
          _buildMenuItems(context),
          const SizedBox(height: 20),
          _buildAdminSection(context), // Добавляем раздел админки
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${userService.bonusBalance ?? 0} бонусов',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
      {'service': 'Стрижка', 'date': '25 ноя 2024', 'master': 'Мария', 'price': '1800 ₽'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'История посещений',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Все',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF8B7355),
                  fontWeight: FontWeight.w600,
                ),
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
                    'Бонусный счет',
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
                    child: const Text(
                      'Премиум',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '${userService.bonusBalance ?? 0}',
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'бонусов',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        '1 бонус = 1 рубль',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: 0.75,
                backgroundColor: Colors.white.withOpacity(0.3),
                color: Colors.white,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'До нового уровня',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    '300 бонусов',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      {'icon': Icons.qr_code, 'title': 'Мой QR-код', 'route': '/qr'},
      {'icon': Icons.calendar_today, 'title': 'Мои записи', 'route': '/appointments'},
      {'icon': Icons.notifications, 'title': 'Уведомления', 'route': '/notifications'},
      {'icon': Icons.favorite, 'title': 'Избранное', 'route': '/favorites'},
      {'icon': Icons.star, 'title': 'Мои отзывы', 'route': '/reviews'},
      {'icon': Icons.card_giftcard, 'title': 'Бонусные акции', 'route': '/bonus-offers'},
      {'icon': Icons.settings, 'title': 'Настройки', 'route': '/settings'},
      {'icon': Icons.help, 'title': 'Помощь', 'route': '/help'},
      {'icon': Icons.logout, 'title': 'Выйти', 'route': '/logout'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Меню',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        ...menuItems.map((item) => _buildMenuItem(context, item)),
      ],
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
          if (item['title'] == 'Выйти') {
            _showLogoutDialog(context);
          } else {
            // TODO: Реализовать навигацию по другим пунктам
            print('Нажата кнопка: ${item['title']}');
          }
        },
      ),
    );
  }

  Widget _buildAdminSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF8B7355).withOpacity(0.2),
          width: 1.5,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF8B7355).withOpacity(0.05),
            const Color(0xFFC5A47E).withOpacity(0.05),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Управление салоном',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8B7355),
                        ),
                      ),
                      Text(
                        'Административная панель',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF4A4A4A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Для доступа к управлению клиентами, бонусами и аналитикой салона',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminLoginScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.admin_panel_settings_outlined, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Открыть админ-панель',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _showAdminInfoDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: const Color(0xFF8B7355).withOpacity(0.5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, size: 18, color: Color(0xFF8B7355)),
                    SizedBox(width: 8),
                    Text(
                      'Как получить доступ?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8B7355),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выйти из аккаунта'),
        content: const Text('Вы уверены, что хотите выйти из своего аккаунта?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              final userService = context.read<UserService>();
              userService.logout();
              userService.clearUser();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B7355),
              foregroundColor: Colors.white,
            ),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }

  void _showAdminInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings, color: Color(0xFF8B7355)),
            SizedBox(width: 8),
            Text('Доступ к админ-панели'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Административная панель доступна только для:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12),
            Text('• Владельцев салонов красоты'),
            Text('• Администраторов салонов'),
            Text('• Управляющих сетями салонов'),
            SizedBox(height: 16),
            Text(
              'Для получения доступа:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('1. Обратитесь к технической поддержке'),
            Text('2. Получите пароль администратора'),
            Text('3. Войдите в админ-панель'),
            SizedBox(height: 16),
            Text(
              'Демо-пароль: admin123',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B7355),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Понятно'),
          ),
        ],
      ),
    );
  }
}