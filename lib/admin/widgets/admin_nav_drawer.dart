import 'package:flutter/material.dart';
import '../dashboard/admin_dashboard.dart';

class AdminNavDrawer extends StatelessWidget {
  const AdminNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8B7355),
                  Color(0xFFC5A47E),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.spa,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Fidelita Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Панель управления',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            title: 'Дашборд',
            destination: const AdminDashboard(),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.group,
            title: 'Клиенты',
            destination: Container(), // Placeholder
          ),
          _buildDrawerItem(
            context,
            icon: Icons.card_giftcard,
            title: 'Бонусы',
            destination: Container(), // Placeholder
          ),
          _buildDrawerItem(
            context,
            icon: Icons.analytics,
            title: 'Аналитика',
            destination: Container(), // Placeholder
          ),
          const Divider(height: 32, thickness: 1),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Настройки',
            destination: Container(), // Placeholder
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help_outline,
            title: 'Помощь',
            destination: Container(), // Placeholder
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget destination,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF8B7355),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF333333),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}