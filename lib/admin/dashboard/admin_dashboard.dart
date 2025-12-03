import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/admin_auth_service.dart';
import '../widgets/admin_app_bar.dart';
import '../widgets/admin_sidebar.dart';
import '../screens/clients_screen.dart';
import '../screens/bonuses_screen.dart';
import '../screens/analytics_screen.dart';
import '../screens/services_screen.dart';
import '../screens/masters_screen.dart';
import '../screens/bookings_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/promotions_screen.dart'; // Добавляем импорт экрана акций

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedNavIndex = 0;

  final List<Widget> _screens = [
    const DashboardContent(),
    const ClientsScreen(),
    const BookingsScreen(),
    const BonusesScreen(),
    const ServicesScreen(),
    const MastersScreen(),
    const AnalyticsScreen(),
    const SettingsScreen(),
    const PromotionsScreen(), // Добавляем экран акций
  ];

  final List<String> _screenTitles = [
    'Панель управления',
    'Управление клиентами',
    'Календарь записей',
    'Управление бонусами',
    'Управление услугами',
    'Управление мастерами',
    'Аналитика и отчеты',
    'Настройки системы',
    'Акции и промо', // Добавляем название для экрана акций
  ];

  @override
  Widget build(BuildContext context) {
    final adminAuth = Provider.of<AdminAuthService>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AdminAppBar(
        title: _screenTitles[_selectedNavIndex],
        showNotifications: _selectedNavIndex == 0,
        notificationCount: 3,
        onLogout: () {
          adminAuth.logout();
        },
      ),
      body: Row(
        children: [
          // Боковая панель навигации
          AdminSidebar(
            selectedIndex: _selectedNavIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedNavIndex = index;
              });
            },
          ),
          
          // Основной контент
          Expanded(
            child: _screens[_selectedNavIndex],
          ),
        ],
      ),
    );
  }
}

// Контент дашборда
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          _buildQuickMetrics(),
          const SizedBox(height: 32),
          _buildDashboardContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Добро пожаловать, Администратор!',
          style: TextStyle(
            fontFamily: 'Playfair Display',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8B7355),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Обзор статистики салона • ${_getFormattedDate()}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickMetrics() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: const [
        _MetricCard(
          title: 'Общая выручка',
          value: '₽1.2M',
          change: '+15.2%',
          icon: Icons.trending_up,
          color: Colors.green,
        ),
        _MetricCard(
          title: 'Новых клиентов',
          value: '47',
          change: '+8.4%',
          icon: Icons.group_add,
          color: Colors.blue,
        ),
        _MetricCard(
          title: 'Средний чек',
          value: '₽3,250',
          change: '+5.7%',
          icon: Icons.attach_money,
          color: Colors.orange,
        ),
        _MetricCard(
          title: 'Активных бонусов',
          value: '1,247',
          change: '+12.3%',
          icon: Icons.card_giftcard,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildDashboardContent() {
    return Column(
      children: [
        _buildStatsCards(),
        const SizedBox(height: 24),
        _buildRecentVisits(),
        const SizedBox(height: 24),
        _buildTopServices(),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ключевые показатели',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8B7355),
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3, // 3 колонки
            crossAxisSpacing: 12, // Уменьшили отступы
            mainAxisSpacing: 12, // Уменьшили отступы
            childAspectRatio: 1.4, // Немного уже карточки
            children: [
              _buildCompactStatCard('Конверсия', '68%', Icons.trending_up, Colors.green, '+2%'),
              _buildCompactStatCard('Средний чек', '₽3,250', Icons.attach_money, Colors.blue, '+5.7%'),
              _buildCompactStatCard('Удовлетворенность', '92%', Icons.star, Colors.amber, '+1%'),
              _buildCompactStatCard('Возвращаемость', '78%', Icons.repeat, Colors.purple, '+3%'),
              _buildCompactStatCard('Ср. время визита', '85 мин', Icons.timer, Colors.orange, '+2 мин'),
              _buildCompactStatCard('Заполненность', '82%', Icons.calendar_today, Colors.cyan, '+8%'),
            ],
          ),
        ],
      ),
    );
  }

  // Компактная карточка для ключевых показателей
  Widget _buildCompactStatCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: const EdgeInsets.all(12), // Уменьшили padding
      decoration: BoxDecoration(
        color: color.withOpacity(0.05), // Более прозрачный фон
        borderRadius: BorderRadius.circular(12), // Меньше скругление
        border: Border.all(
          color: color.withOpacity(0.1), // Более светлая граница
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32, // Уменьшили иконку
                height: 32,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18), // Уменьшили иконку
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10, // Уменьшили шрифт
                    color: change.startsWith('+') ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16, // Уменьшили шрифт значения
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11, // Уменьшили шрифт заголовка
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentVisits() {
    final List<Map<String, String>> visits = [
      {'client': 'Анна Петрова', 'service': 'Маникюр', 'amount': '₽4,200', 'time': '2 часа назад'},
      {'client': 'Иван Сидоров', 'service': 'Стрижка', 'amount': '₽2,800', 'time': '3 часа назад'},
      {'client': 'Мария Иванова', 'service': 'Окрашивание', 'amount': '₽5,600', 'time': '4 часа назад'},
      {'client': 'Ольга Смирнова', 'service': 'Косметология', 'amount': '₽3,900', 'time': '5 часов назад'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Последние посещения',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8B7355),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Все посещения',
                  style: TextStyle(
                    color: const Color(0xFF8B7355),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...visits.map((visit) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[200]!,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B7355),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visit['client']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        visit['service']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      visit['amount']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8B7355),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      visit['time']!,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTopServices() {
    final List<Map<String, String>> services = [
      {'name': 'Маникюр', 'count': '156', 'revenue': '₽420K'},
      {'name': 'Стрижка', 'count': '124', 'revenue': '₽310K'},
      {'name': 'Окрашивание', 'count': '89', 'revenue': '₽280K'},
      {'name': 'Косметология', 'count': '76', 'revenue': '₽380K'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Топ услуг по выручке',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF8B7355),
            ),
          ),
          const SizedBox(height: 16),
          ...services.map((service) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: int.parse(service['count']!) / 200,
                        backgroundColor: Colors.grey[200],
                        color: const Color(0xFF8B7355),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      service['revenue']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    Text(
                      '${service['count']} зап.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }
}

// Временная замена для MetricsCard
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: change.startsWith('+') ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        change.startsWith('+') ? Icons.trending_up : Icons.trending_down,
                        size: 14,
                        color: change.startsWith('+') ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        change,
                        style: TextStyle(
                          color: change.startsWith('+') ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}