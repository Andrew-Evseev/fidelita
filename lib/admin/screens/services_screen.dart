import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<Service> _services = [];
  final List<ServiceCategory> _categories = [];
  String _selectedCategory = 'Все';
  String _sortBy = 'Популярность';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _categories.addAll([
      ServiceCategory(id: '1', name: 'Все', count: 45),
      ServiceCategory(id: '2', name: 'Парикмахерские', count: 12),
      ServiceCategory(id: '3', name: 'Ногтевой сервис', count: 8),
      ServiceCategory(id: '4', name: 'Косметология', count: 10),
      ServiceCategory(id: '5', name: 'Массаж', count: 6),
      ServiceCategory(id: '6', name: 'Эпиляция', count: 5),
      ServiceCategory(id: '7', name: 'Макияж', count: 4),
    ]);

    _services.addAll([
      Service(
        id: '1',
        name: 'Стрижка женская',
        category: 'Парикмахерские',
        duration: 60,
        price: 2500,
        masterPrice: 1500,
        popularity: 4.8,
        count: 156,
        status: 'Активна',
      ),
      Service(
        id: '2',
        name: 'Маникюр комбинированный',
        category: 'Ногтевой сервис',
        duration: 90,
        price: 1800,
        masterPrice: 1000,
        popularity: 4.9,
        count: 245,
        status: 'Активна',
      ),
      Service(
        id: '3',
        name: 'Чистка лица',
        category: 'Косметология',
        duration: 120,
        price: 3500,
        masterPrice: 2000,
        popularity: 4.7,
        count: 89,
        status: 'Активна',
      ),
      Service(
        id: '4',
        name: 'Классический массаж',
        category: 'Массаж',
        duration: 60,
        price: 2800,
        masterPrice: 1800,
        popularity: 4.6,
        count: 76,
        status: 'Активна',
      ),
      Service(
        id: '5',
        name: 'Окрашивание волос',
        category: 'Парикмахерские',
        duration: 180,
        price: 4500,
        masterPrice: 2500,
        popularity: 4.5,
        count: 124,
        status: 'Активна',
      ),
      Service(
        id: '6',
        name: 'Наращивание ресниц',
        category: 'Косметология',
        duration: 120,
        price: 3200,
        masterPrice: 1900,
        popularity: 4.8,
        count: 167,
        status: 'Активна',
      ),
      Service(
        id: '7',
        name: 'Депиляция воском',
        category: 'Эпиляция',
        duration: 45,
        price: 1500,
        masterPrice: 800,
        popularity: 4.4,
        count: 98,
        status: 'Неактивна',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildServiceStats(),
          const SizedBox(height: 24),
          _buildCategoryFilter(),
          const SizedBox(height: 24),
          _buildServicesTable(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Управление услугами',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${_services.length} услуг в системе',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Поиск услуг...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () => _showAddServiceDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B7355),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Добавить услугу'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceStats() {
    final activeServices = _services.where((s) => s.status == 'Активна').length;
    final totalRevenue = _services.fold<double>(0, (sum, s) => sum + (s.price * s.count));
    final avgPrice = _services.isNotEmpty ? _services.fold(0, (sum, s) => sum + s.price) / _services.length : 0;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Всего услуг',
            value: '${_services.length}',
            change: '+3 за месяц',
            icon: Icons.spa,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Активных услуг',
            value: '$activeServices',
            change: '${(activeServices / _services.length * 100).toStringAsFixed(0)}% от всех',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Общая выручка',
            value: '₽${totalRevenue.toStringAsFixed(0)}',
            change: '+15% за месяц',
            icon: Icons.attach_money,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Средняя цена',
            value: '₽${avgPrice.toStringAsFixed(0)}',
            change: '+8% за квартал',
            icon: Icons.trending_up,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
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
            'Категории услуг',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((category) => FilterChip(
              label: Text('${category.name} (${category.count})'),
              selected: _selectedCategory == category.name,
              selectedColor: const Color(0xFF8B7355),
              labelStyle: TextStyle(
                color: _selectedCategory == category.name ? Colors.white : Colors.grey.shade700,
              ),
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category.name;
                });
              },
            )).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Сортировка:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              DropdownButton<String>(
                value: _sortBy,
                items: ['Популярность', 'Цена по возрастанию', 'Цена по убыванию', 'Название']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _sortBy = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTable() {
    final filteredServices = _selectedCategory == 'Все'
        ? _services
        : _services.where((s) => s.category == _selectedCategory).toList();

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Список услуг',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 32,
              horizontalMargin: 0,
              columns: const [
                DataColumn(label: Text('Услуга')),
                DataColumn(label: Text('Категория')),
                DataColumn(label: Text('Длительность')),
                DataColumn(label: Text('Цена')),
                DataColumn(label: Text('Доход мастера')),
                DataColumn(label: Text('Популярность')),
                DataColumn(label: Text('Статус')),
                DataColumn(label: Text('Действия')),
              ],
              rows: filteredServices.map((service) => DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B7355).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.spa,
                            color: Color(0xFF8B7355),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '${service.count} записей',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        service.category,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  DataCell(Text('${service.duration} мин')),
                  DataCell(
                    Text(
                      '₽${service.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      '₽${service.masterPrice}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          service.popularity.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: service.status == 'Активна' 
                          ? Colors.green.withOpacity(0.1) 
                          : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        service.status,
                        style: TextStyle(
                          color: service.status == 'Активна' ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) => _handleServiceAction(value, service),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 16),
                              SizedBox(width: 8),
                              Text('Редактировать'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'duplicate',
                          child: Row(
                            children: [
                              Icon(Icons.content_copy, size: 16),
                              SizedBox(width: 8),
                              Text('Дублировать'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: service.status == 'Активна' ? 'deactivate' : 'activate',
                          child: Row(
                            children: [
                              Icon(
                                service.status == 'Активна' ? Icons.pause : Icons.play_arrow,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(service.status == 'Активна' ? 'Деактивировать' : 'Активировать'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 16, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Удалить', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить услугу'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Название услуги',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Категория'),
                items: _categories.skip(1).map((category) => DropdownMenuItem(
                  value: category.name,
                  child: Text(category.name),
                )).toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Длительность (мин)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Цена для клиента',
                        prefixText: '₽',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Доход мастера',
                  prefixText: '₽',
                ),
                keyboardType: TextInputType.number,
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
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B7355),
            ),
            child: const Text('Создать услугу'),
          ),
        ],
      ),
    );
  }

  void _handleServiceAction(String action, Service service) {
    switch (action) {
      case 'edit':
        _showEditServiceDialog(context, service);
        break;
      case 'duplicate':
        // Логика дублирования
        break;
      case 'activate':
      case 'deactivate':
        setState(() {
          service.status = action == 'activate' ? 'Активна' : 'Неактивна';
        });
        break;
      case 'delete':
        _showDeleteConfirmation(context, service);
        break;
    }
  }

  void _showEditServiceDialog(BuildContext context, Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать услугу'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Название услуги'),
                controller: TextEditingController(text: service.name),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Цена'),
                controller: TextEditingController(text: service.price.toString()),
                keyboardType: TextInputType.number,
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
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B7355),
            ),
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить услугу'),
        content: Text('Вы уверены, что хотите удалить услугу "${service.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _services.remove(service);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}

class Service {
  String id;
  String name;
  String category;
  int duration;
  int price;
  int masterPrice;
  double popularity;
  int count;
  String status;

  Service({
    required this.id,
    required this.name,
    required this.category,
    required this.duration,
    required this.price,
    required this.masterPrice,
    required this.popularity,
    required this.count,
    required this.status,
  });
}

class ServiceCategory {
  String id;
  String name;
  int count;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.count,
  });
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  change,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
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