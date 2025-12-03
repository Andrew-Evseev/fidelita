import 'package:flutter/material.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  final List<Promotion> _promotions = [];
  String _filterStatus = 'Все';
  String _sortBy = 'Дата создания';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _promotions.addAll([
      Promotion(
        id: '1',
        title: 'Скидка 20% на первый визит',
        description: 'Для новых клиентов при первом посещении',
        type: 'Скидка',
        discount: '20%',
        startDate: '01.07.2024',
        endDate: '31.12.2024',
        target: 'Новые клиенты',
        status: 'Активна',
        clientsCount: 124,
        notificationSent: true,
      ),
      Promotion(
        id: '2',
        title: 'Бесплатный кофе при записи онлайн',
        description: 'Бесплатный кофе или чай при онлайн-записи',
        type: 'Бонус',
        discount: 'Кофе/чай',
        startDate: '15.07.2024',
        endDate: '15.08.2024',
        target: 'Все клиенты',
        status: 'Активна',
        clientsCount: 89,
        notificationSent: true,
      ),
      Promotion(
        id: '3',
        title: '3-я процедура в подарок',
        description: 'При покупке 2-х процедур, 3-я в подарок',
        type: 'Акция',
        discount: 'Бесплатно',
        startDate: '01.08.2024',
        endDate: '31.08.2024',
        target: 'Постоянные клиенты',
        status: 'Запланирована',
        clientsCount: 0,
        notificationSent: false,
      ),
      Promotion(
        id: '4',
        title: 'День рождения - 500 бонусов',
        description: 'Поздравление с Днем рождения + 500 бонусов',
        type: 'Бонусы',
        discount: '500 бонусов',
        startDate: '01.01.2024',
        endDate: '31.12.2024',
        target: 'Все клиенты',
        status: 'Активна',
        clientsCount: 156,
        notificationSent: true,
      ),
      Promotion(
        id: '5',
        title: 'Летняя скидка 15%',
        description: 'Скидка на все услуги в летний период',
        type: 'Скидка',
        discount: '15%',
        startDate: '01.06.2024',
        endDate: '31.08.2024',
        target: 'Все клиенты',
        status: 'Активна',
        clientsCount: 245,
        notificationSent: true,
      ),
      Promotion(
        id: '6',
        title: 'Приведи друга - получи 1000₽',
        description: '1000₽ скидки за приведенного друга',
        type: 'Реферальная',
        discount: '1000₽',
        startDate: '01.05.2024',
        endDate: '31.10.2024',
        target: 'Все клиенты',
        status: 'Активна',
        clientsCount: 67,
        notificationSent: true,
      ),
      Promotion(
        id: '7',
        title: 'Новогодняя акция',
        description: 'Специальные предложения к Новому году',
        type: 'Сезонная',
        discount: '25%',
        startDate: '15.12.2024',
        endDate: '15.01.2025',
        target: 'Все клиенты',
        status: 'Черновик',
        clientsCount: 0,
        notificationSent: false,
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
          _buildPromotionStats(),
          const SizedBox(height: 24),
          _buildPromotionsTable(),
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
              'Управление акциями',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${_promotions.length} акций в системе',
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
                  hintText: 'Поиск акций...',
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
              onPressed: () => _showCreatePromotionDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B7355),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Создать акцию'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPromotionStats() {
    final activePromotions = _promotions.where((p) => p.status == 'Активна').length;
    final scheduledPromotions = _promotions.where((p) => p.status == 'Запланирована').length;
    final totalClients = _promotions.fold(0, (sum, p) => sum + p.clientsCount);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Всего акций',
            value: '${_promotions.length}',
            change: '+3 за месяц',
            icon: Icons.local_offer,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Активных',
            value: '$activePromotions',
            change: '${(activePromotions / _promotions.length * 100).toStringAsFixed(0)}% от всех',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Запланировано',
            value: '$scheduledPromotions',
            change: 'Скоро стартуют',
            icon: Icons.schedule,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Охват клиентов',
            value: '$totalClients',
            change: '+18% за месяц',
            icon: Icons.people,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionsTable() {
    final filteredPromotions = _filterStatus == 'Все'
        ? _promotions
        : _promotions.where((p) => p.status == _filterStatus).toList();

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
                'Список акций',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Row(
                children: [
                  _buildFilterChip('Все', 'Все'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Активные', 'Активна'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Запланированы', 'Запланирована'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Черновики', 'Черновик'),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: _sortBy,
                    items: ['Дата создания', 'Название', 'Статус', 'Количество клиентов']
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
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...filteredPromotions.map((promotion) => Container(
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
                    color: _getPromotionColor(promotion.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getPromotionIcon(promotion.type),
                    color: _getPromotionColor(promotion.type),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            promotion.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(promotion.status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              promotion.status,
                              style: TextStyle(
                                color: _getStatusColor(promotion.status),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        promotion.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            '${promotion.startDate} - ${promotion.endDate}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.person, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            promotion.target,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.people, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            '${promotion.clientsCount} клиентов',
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
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B7355).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        promotion.discount,
                        style: const TextStyle(
                          color: Color(0xFF8B7355),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (!promotion.notificationSent)
                          IconButton(
                            icon: const Icon(Icons.notifications_none),
                            onPressed: () => _sendPushNotification(promotion),
                            tooltip: 'Отправить уведомление',
                          ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editPromotion(promotion),
                          tooltip: 'Редактировать',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deletePromotion(promotion),
                          tooltip: 'Удалить',
                        ),
                      ],
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

  Widget _buildFilterChip(String label, String value) {
    return FilterChip(
      label: Text(label),
      selected: _filterStatus == value,
      selectedColor: const Color(0xFF8B7355),
      labelStyle: TextStyle(
        color: _filterStatus == value ? Colors.white : Colors.grey.shade700,
      ),
      onSelected: (selected) {
        setState(() {
          _filterStatus = selected ? value : 'Все';
        });
      },
    );
  }

  void _sendPushNotification(Promotion promotion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Отправить push-уведомление'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Отправить уведомление об акции "${promotion.title}"?'),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Заголовок уведомления',
                hintText: 'Новая акция в салоне!',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Текст уведомления',
                hintText: 'Специальное предложение для вас...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                const Text('Получатели:'),
                const SizedBox(width: 8),
                Chip(label: Text(promotion.target)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                promotion.notificationSent = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Уведомление отправлено клиентам'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B7355),
            ),
            child: const Text('Отправить'),
          ),
        ],
      ),
    );
  }

  void _showCreatePromotionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Создать новую акцию'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Название акции',
                  hintText: 'Скидка 20% на первый визит',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  hintText: 'Для новых клиентов при первом посещении',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Дата начала',
                        hintText: '01.01.2024',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Дата окончания',
                        hintText: '31.12.2024',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Тип акции'),
                items: ['Скидка', 'Бонус', 'Акция', 'Сезонная', 'Реферальная']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Размер скидки/бонуса',
                  hintText: '20% или 500 бонусов',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Целевая аудитория'),
                items: ['Все клиенты', 'Новые клиенты', 'Постоянные клиенты', 'VIP клиенты', 'Выборочно']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {},
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
              final newPromotion = Promotion(
                id: (DateTime.now().millisecondsSinceEpoch).toString(),
                title: 'Новая акция',
                description: 'Описание акции',
                type: 'Скидка',
                discount: '20%',
                startDate: '01.09.2024',
                endDate: '30.09.2024',
                target: 'Все клиенты',
                status: 'Черновик',
                clientsCount: 0,
                notificationSent: false,
              );
              
              setState(() {
                _promotions.insert(0, newPromotion);
              });
              
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Акция успешно создана'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B7355),
            ),
            child: const Text('Создать акцию'),
          ),
        ],
      ),
    );
  }

  void _editPromotion(Promotion promotion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать акцию'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Название акции',
                  hintText: promotion.title,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: promotion.status,
                decoration: const InputDecoration(labelText: 'Статус'),
                items: ['Активна', 'Запланирована', 'Завершена', 'Черновик']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    promotion.status = value!;
                  });
                  Navigator.pop(context);
                },
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

  void _deletePromotion(Promotion promotion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить акцию'),
        content: Text('Вы уверены, что хотите удалить акцию "${promotion.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _promotions.remove(promotion);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Акция успешно удалена'),
                  backgroundColor: Colors.green,
                ),
              );
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Активна':
        return Colors.green;
      case 'Запланирована':
        return Colors.orange;
      case 'Завершена':
        return Colors.grey;
      case 'Черновик':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getPromotionColor(String type) {
    switch (type) {
      case 'Скидка':
        return Colors.green;
      case 'Бонус':
        return Colors.blue;
      case 'Акция':
        return Colors.purple;
      case 'Сезонная':
        return Colors.orange;
      case 'Реферальная':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getPromotionIcon(String type) {
    switch (type) {
      case 'Скидка':
        return Icons.percent;
      case 'Бонус':
        return Icons.card_giftcard;
      case 'Акция':
        return Icons.local_offer;
      case 'Сезонная':
        return Icons.wb_sunny;
      case 'Реферальная':
        return Icons.people;
      default:
        return Icons.local_offer;
    }
  }
}

class Promotion {
  String id;
  String title;
  String description;
  String type;
  String discount;
  String startDate;
  String endDate;
  String target;
  String status;
  int clientsCount;
  bool notificationSent;

  Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.discount,
    required this.startDate,
    required this.endDate,
    required this.target,
    required this.status,
    required this.clientsCount,
    required this.notificationSent,
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