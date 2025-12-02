import 'package:flutter/material.dart';
import '../widgets/admin_app_bar.dart';
import '../widgets/admin_nav_drawer.dart';

class BonusesManagement extends StatefulWidget {
  const BonusesManagement({super.key});

  @override
  State<BonusesManagement> createState() => _BonusesManagementState();
}

class _BonusesManagementState extends State<BonusesManagement> {
  final List<Map<String, dynamic>> _bonuses = [
    {
      'id': 1,
      'title': 'Скидка 10% на стрижку',
      'description': 'Для новых клиентов',
      'points': 100,
      'active': true,
      'expires': '2024-12-31',
    },
    {
      'id': 2,
      'title': 'Бесплатное окрашивание',
      'description': 'После 5 посещений',
      'points': 500,
      'active': true,
      'expires': '2024-12-31',
    },
    {
      'id': 3,
      'title': 'Подарок на день рождения',
      'description': 'Для именинников',
      'points': 0,
      'active': true,
      'expires': '2024-12-31',
    },
    {
      'id': 4,
      'title': 'Скидка 15% на уход',
      'description': 'Акция месяца',
      'points': 200,
      'active': false,
      'expires': '2024-01-31',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AdminAppBar(title: 'Управление бонусами'),
      drawer: const AdminNavDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Добавить новый бонус
        },
        backgroundColor: const Color(0xFF8B7355),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(
                  'Активных бонусов',
                  '3',
                  Icons.check_circle,
                  Colors.green,
                ),
                _buildStatCard(
                  'Неактивных',
                  '1',
                  Icons.pause_circle,
                  Colors.orange,
                ),
                _buildStatCard(
                  'Всего выдано',
                  '1,247',
                  Icons.card_giftcard,
                  Colors.blue,
                ),
                _buildStatCard(
                  'Баллов в системе',
                  '45,670',
                  Icons.star,
                  Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(24),
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
                    'Все бонусы',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._bonuses.map((bonus) {
                    return Container(
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
                              color: bonus['active']
                                  ? const Color(0xFF8B7355)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              bonus['active']
                                  ? Icons.card_giftcard
                                  : Icons.pause,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bonus['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  bonus['description'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Действует до: ${bonus['expires']}',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${bonus['points']} баллов',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8B7355),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: bonus['active']
                                      ? Colors.green.shade100
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  bonus['active'] ? 'Активен' : 'Неактивен',
                                  style: TextStyle(
                                    color: bonus['active']
                                        ? Colors.green.shade800
                                        : Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}