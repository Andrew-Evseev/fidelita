import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/admin_auth_service.dart';
import '../widgets/admin_app_bar.dart';
import '../widgets/admin_nav_drawer.dart';
import '../widgets/metrics_card.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AdminAppBar(
        title: 'Панель управления',
        onLogout: () {
          context.read<AdminAuthService>().logout();
        },
      ),
      drawer: const AdminNavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Добро пожаловать, Администратор!',
              style: TextStyle(
                fontFamily: 'Playfair Display',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8B7355),
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Обзор статистики салона',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 32),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                MetricsCard(
                  title: 'Всего клиентов',
                  value: '1,247',
                  change: '+12%',
                  icon: Icons.group,
                  color: Colors.blue,
                  gradientColors: [
                    Colors.blue.shade400,
                    Colors.blue.shade300,
                  ],
                ),
                
                MetricsCard(
                  title: 'Посещений сегодня',
                  value: '47',
                  change: '+8%',
                  icon: Icons.calendar_today,
                  color: Colors.green,
                  gradientColors: [
                    Colors.green.shade400,
                    Colors.green.shade300,
                  ],
                ),
                
                MetricsCard(
                  title: 'Активных бонусов',
                  value: '356',
                  change: '+23%',
                  icon: Icons.card_giftcard,
                  color: Colors.orange,
                  gradientColors: [
                    Colors.orange.shade400,
                    Colors.orange.shade300,
                  ],
                ),
                
                MetricsCard(
                  title: 'Средний чек',
                  value: '₽2,850',
                  change: '+5%',
                  icon: Icons.attach_money,
                  color: Colors.purple,
                  gradientColors: [
                    Colors.purple.shade400,
                    Colors.purple.shade300,
                  ],
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
                  
                  ...List.generate(5, (index) {
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
                                  'Анна Иванова',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Стрижка + окрашивание',
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
                                '₽4,200',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF8B7355),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '2 часа назад',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}