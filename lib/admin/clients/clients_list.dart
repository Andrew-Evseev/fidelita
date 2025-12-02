import 'package:flutter/material.dart';
import '../widgets/admin_app_bar.dart';
import '../widgets/admin_nav_drawer.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({super.key});

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
  final List<Map<String, dynamic>> _clients = List.generate(
    20,
    (index) => {
      'id': index + 1,
      'name': 'Клиент ${index + 1}',
      'email': 'client${index + 1}@example.com',
      'phone': '+7 (999) 123-45-6${index % 10}',
      'visits': 5 + index % 10,
      'bonuses': 150 + index * 20,
      'lastVisit': '2024-01-${15 + index % 15}',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AdminAppBar(title: 'Клиенты'),
      drawer: const AdminNavDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск клиентов...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.filter_list),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
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
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _clients.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final client = _clients[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF8B7355),
                      child: Text(
                        client['id'].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      client['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(client['phone']),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${client['visits']} посещ.',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${client['bonuses']} бон.',
                          style: const TextStyle(
                            color: Color(0xFF8B7355),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Переход на детальную страницу клиента
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}