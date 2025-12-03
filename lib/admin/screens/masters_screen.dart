import 'package:flutter/material.dart';

class MastersScreen extends StatefulWidget {
  const MastersScreen({super.key});

  @override
  State<MastersScreen> createState() => _MastersScreenState();
}

class _MastersScreenState extends State<MastersScreen> {
  final List<Master> _masters = [];
  String _filterStatus = 'Все';
  String _sortBy = 'Рейтинг';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _masters.addAll([
      Master(
        id: '1',
        name: 'Анна Петрова',
        position: 'Ведущий стилист',
        rating: 4.9,
        completedServices: 1245,
        revenue: 1850000,
        services: ['Стрижка', 'Окрашивание', 'Укладка'],
        schedule: 'Пн-Пт 9:00-18:00',
        status: 'Работает',
        avatarColor: Colors.blue,
      ),
      Master(
        id: '2',
        name: 'Иван Сидоров',
        position: 'Мастер ногтевого сервиса',
        rating: 4.8,
        completedServices: 876,
        revenue: 1240000,
        services: ['Маникюр', 'Педикюр', 'Наращивание'],
        schedule: 'Вт-Сб 10:00-19:00',
        status: 'Работает',
        avatarColor: Colors.green,
      ),
      Master(
        id: '3',
        name: 'Мария Иванова',
        position: 'Косметолог',
        rating: 4.7,
        completedServices: 654,
        revenue: 980000,
        services: ['Чистка лица', 'Пилинг', 'Уходовые процедуры'],
        schedule: 'Пн-Сб 11:00-20:00',
        status: 'Работает',
        avatarColor: Colors.purple,
      ),
      Master(
        id: '4',
        name: 'Ольга Смирнова',
        position: 'Массажист',
        rating: 4.6,
        completedServices: 432,
        revenue: 765000,
        services: ['Классический массаж', 'Антицеллюлитный', 'Релакс'],
        schedule: 'Ср-Вс 12:00-21:00',
        status: 'В отпуске',
        avatarColor: Colors.orange,
      ),
      Master(
        id: '5',
        name: 'Алексей Козлов',
        position: 'Барбер',
        rating: 4.5,
        completedServices: 567,
        revenue: 890000,
        services: ['Мужская стрижка', 'Бритье', 'Уход за бородой'],
        schedule: 'Пн-Пт 8:00-17:00',
        status: 'Работает',
        avatarColor: Colors.red,
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
          _buildMastersStats(),
          const SizedBox(height: 24),
          _buildMastersGrid(),
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
              'Управление мастерами',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${_masters.length} мастеров в штате',
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
                  hintText: 'Поиск мастеров...',
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
              onPressed: () => _showAddMasterDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B7355),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Добавить мастера'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMastersStats() {
    final workingMasters = _masters.where((m) => m.status == 'Работает').length;
    final avgRating = _masters.isNotEmpty
        ? _masters.fold(0.0, (sum, m) => sum + m.rating) / _masters.length
        : 0.0;
    final totalRevenue = _masters.fold(0, (sum, m) => sum + m.revenue);
    final totalServices = _masters.fold(0, (sum, m) => sum + m.completedServices);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Всего мастеров',
            value: '${_masters.length}',
            change: '+1 за месяц',
            icon: Icons.people,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Работают сейчас',
            value: '$workingMasters',
            change: '${(workingMasters / _masters.length * 100).toStringAsFixed(0)}% от всех',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Средний рейтинг',
            value: avgRating.toStringAsFixed(1),
            change: '+0.2 за квартал',
            icon: Icons.star,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Общая выручка',
            value: '₽${(totalRevenue / 1000000).toStringAsFixed(1)}M',
            change: '+18% за год',
            icon: Icons.attach_money,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildMastersGrid() {
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
              const Text(
                'Список мастеров',
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
                  _buildFilterChip('Работают', 'Работает'),
                  const SizedBox(width: 8),
                  _buildFilterChip('В отпуске', 'В отпуске'),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: _sortBy,
                    items: ['Рейтинг', 'Имя', 'Выручка', 'Количество услуг']
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
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.6,
            children: _masters
                .where((master) => _filterStatus == 'Все' || master.status == _filterStatus)
                .map((master) => _buildMasterCard(master))
                .toList(),
          ),
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

  Widget _buildMasterCard(Master master) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: master.avatarColor.withOpacity(0.1),
                  radius: 24,
                  child: Text(
                    master.name.split(' ').map((n) => n[0]).join(),
                    style: TextStyle(
                      color: master.avatarColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        master.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        master.position,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: master.status == 'Работает'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    master.status,
                    style: TextStyle(
                      color: master.status == 'Работает' ? Colors.green : Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  master.rating.toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.work, size: 16, color: Colors.blue),
                const SizedBox(width: 4),
                Text(
                  '${master.completedServices}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.attach_money, size: 16, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  '₽${(master.revenue / 1000).toStringAsFixed(0)}K',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: master.services.take(2).map((service) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  service,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade700,
                  ),
                ),
              )).toList(),
            ),
            if (master.services.length > 2)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '+${master.services.length - 2} ещё',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  master.schedule,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 20),
                  onSelected: (value) => _handleMasterAction(value, master),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'schedule',
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: 8),
                          Text('Расписание'),
                        ],
                      ),
                    ),
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
                    PopupMenuItem(
                      value: master.status == 'Работает' ? 'vacation' : 'work',
                      child: Row(
                        children: [
                          Icon(
                            master.status == 'Работает' ? Icons.beach_access : Icons.work,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(master.status == 'Работает' ? 'В отпуск' : 'На работу'),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMasterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить мастера'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'ФИО мастера'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Должность'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Специализации (через запятую)'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'График работы'),
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
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _handleMasterAction(String action, Master master) {
    switch (action) {
      case 'schedule':
        _showMasterSchedule(context, master);
        break;
      case 'edit':
        _showEditMasterDialog(context, master);
        break;
      case 'vacation':
      case 'work':
        setState(() {
          master.status = action == 'vacation' ? 'В отпуске' : 'Работает';
        });
        break;
      case 'delete':
        _showDeleteMasterConfirmation(context, master);
        break;
    }
  }

  void _showMasterSchedule(BuildContext context, Master master) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Расписание: ${master.name}'),
        content: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildScheduleDay('Понедельник', '9:00 - 18:00', true),
                    _buildScheduleDay('Вторник', '9:00 - 18:00', true),
                    _buildScheduleDay('Среда', '9:00 - 18:00', true),
                    _buildScheduleDay('Четверг', '9:00 - 18:00', true),
                    _buildScheduleDay('Пятница', '9:00 - 18:00', true),
                    _buildScheduleDay('Суббота', '10:00 - 16:00', false),
                    _buildScheduleDay('Воскресенье', 'Выходной', false),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleDay(String day, String hours, bool isWorking) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isWorking ? Colors.grey.shade800 : Colors.grey.shade500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isWorking ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              hours,
              style: TextStyle(
                color: isWorking ? Colors.green : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditMasterDialog(BuildContext context, Master master) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать мастера'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'ФИО мастера'),
                controller: TextEditingController(text: master.name),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Должность'),
                controller: TextEditingController(text: master.position),
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

  void _showDeleteMasterConfirmation(BuildContext context, Master master) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить мастера'),
        content: Text('Вы уверены, что хотите удалить мастера "${master.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _masters.remove(master);
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

class Master {
  String id;
  String name;
  String position;
  double rating;
  int completedServices;
  int revenue;
  List<String> services;
  String schedule;
  String status;
  Color avatarColor;

  Master({
    required this.id,
    required this.name,
    required this.position,
    required this.rating,
    required this.completedServices,
    required this.revenue,
    required this.services,
    required this.schedule,
    required this.status,
    required this.avatarColor,
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