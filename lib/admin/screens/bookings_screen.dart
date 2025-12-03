import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedView = 'day'; // 'day', 'week', 'month'
  final List<TimeSlot> _timeSlots = _generateTimeSlots();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildCalendarControls(),
          const SizedBox(height: 24),
          _buildCalendarView(),
          const SizedBox(height: 24),
          _buildUpcomingAppointments(),
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
              'Календарь записей',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Управление расписанием и записями',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Color(0xFF8B7355)),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(_selectedDate),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () => _showNewBookingDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B7355),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Новая запись'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarControls() {
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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _changeDate(-1),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = DateTime.now();
                      });
                    },
                    child: const Text(
                      'Сегодня',
                      style: TextStyle(
                        color: Color(0xFF8B7355),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _changeDate(1),
                  ),
                ],
              ),
              Row(
                children: [
                  _buildViewButton('День', 'day'),
                  const SizedBox(width: 8),
                  _buildViewButton('Неделя', 'week'),
                  const SizedBox(width: 8),
                  _buildViewButton('Месяц', 'month'),
                ],
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
          _buildMasterFilter(),
        ],
      ),
    );
  }

  Widget _buildViewButton(String label, String value) {
    final isSelected = _selectedView == value;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedView = value;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF8B7355) : Colors.white,
        foregroundColor: isSelected ? Colors.white : const Color(0xFF8B7355),
        side: BorderSide(
          color: isSelected ? const Color(0xFF8B7355) : Colors.grey.shade300,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(label),
    );
  }

  Widget _buildMasterFilter() {
    final masters = [
      'Все мастера',
      'Анна Петрова',
      'Иван Сидоров',
      'Мария Иванова',
      'Ольга Смирнова',
    ];

    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: masters.map((master) => Container(
          margin: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(master),
            selected: master == 'Все мастера',
            selectedColor: const Color(0xFF8B7355),
            labelStyle: TextStyle(
              color: master == 'Все мастера' ? Colors.white : Colors.grey.shade700,
            ),
            onSelected: (selected) {},
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildCalendarView() {
    if (_selectedView == 'day') {
      return _buildDayView();
    } else if (_selectedView == 'week') {
      return _buildWeekView();
    } else {
      return _buildMonthView();
    }
  }

  Widget _buildDayView() {
    final appointments = _getAppointmentsForDay(_selectedDate);

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
            'Расписание на ${_formatDate(_selectedDate)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 600,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Временная шкала
                SizedBox(
                  width: 80,
                  child: Column(
                    children: _timeSlots.map((slot) => SizedBox(
                      height: 60,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            slot.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                // Основная область с записями
                Expanded(
                  child: Stack(
                    children: [
                      // Сетка времени
                      Column(
                        children: _timeSlots.map((slot) => Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                      // Записи
                      ..._buildAppointmentWidgets(appointments),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAppointmentWidgets(List<Appointment> appointments) {
    return appointments.map((appointment) => Positioned(
      top: _calculatePosition(appointment.startTime),
      left: _calculateLeftPosition(appointment.master),
      width: _calculateWidth(),
      child: Container(
        height: _calculateHeight(appointment.duration),
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _getAppointmentColor(appointment.status),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.client,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              appointment.service,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 10,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  appointment.master,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    )).toList();
  }

  Widget _buildWeekView() {
    final weekDates = _getWeekDates(_selectedDate);
    final appointments = _getAppointmentsForWeek(weekDates);

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
            'Неделя ${_formatWeekRange(weekDates)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 20),
          // Заголовки дней недели
          Row(
            children: [
              const SizedBox(width: 80),
              ...weekDates.map((date) => Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isToday(date) ? const Color(0xFF8B7355).withOpacity(0.1) : Colors.transparent,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getDayName(date.weekday),
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _isToday(date) ? const Color(0xFF8B7355) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              color: _isToday(date) ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ],
          ),
          // Сетка времени и записей
          SizedBox(
            height: 600,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Временная шкала
                SizedBox(
                  width: 80,
                  child: Column(
                    children: _timeSlots.map((slot) => SizedBox(
                      height: 60,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            slot.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                // Дни недели
                ...weekDates.asMap().entries.map((entry) => Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: entry.key == weekDates.length - 1 ? Colors.transparent : Colors.grey.shade200,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Сетка времени
                        Column(
                          children: _timeSlots.map((slot) => Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                            ),
                          )).toList(),
                        ),
                        // Записи для этого дня
                        ..._buildAppointmentWidgets(
                          appointments.where((a) => 
                            a.date.year == entry.value.year &&
                            a.date.month == entry.value.month &&
                            a.date.day == entry.value.day
                          ).toList()
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthView() {
    final monthDates = _getMonthDates(_selectedDate);

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
                '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Дни недели
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.5,
            ),
            itemCount: 7,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Center(
                child: Text(
                  _getDayName(index + 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B7355),
                  ),
                ),
              ),
            ),
          ),
          // Календарь
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.5,
            ),
            itemCount: monthDates.length,
            itemBuilder: (context, index) {
              final date = monthDates[index];
              final isCurrentMonth = date.month == _selectedDate.month;
              final isToday = _isToday(date);
              final appointments = _getAppointmentsForDay(date);
              
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100),
                  color: isToday ? const Color(0xFF8B7355).withOpacity(0.1) : Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isCurrentMonth ? Colors.grey.shade800 : Colors.grey.shade400,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    if (appointments.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      ...appointments.take(2).map((appointment) => Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getAppointmentColor(appointment.status),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _getStatusColor(appointment.status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                appointment.time,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey.shade700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                      if (appointments.length > 2)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '+${appointments.length - 2}',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    final upcoming = _getUpcomingAppointments();

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
            'Ближайшие записи',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 16),
          ...upcoming.map((appointment) => Container(
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
                  width: 60,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B7355).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appointment.time,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8B7355),
                        ),
                      ),
                      Text(
                        appointment.duration,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.client,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${appointment.service} • ${appointment.master}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(appointment.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    appointment.status,
                    style: TextStyle(
                      color: _getStatusColor(appointment.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {},
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
                      value: 'cancel',
                      child: Row(
                        children: [
                          Icon(Icons.cancel, size: 16),
                          SizedBox(width: 8),
                          Text('Отменить запись'),
                        ],
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

  // Вспомогательные методы
  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  void _showNewBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новая запись'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Клиент',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Услуга',
                  prefixIcon: Icon(Icons.spa),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Мастер',
                  prefixIcon: Icon(Icons.person_outline),
                ),
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
            child: const Text('Создать запись'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  String _formatWeekRange(List<DateTime> dates) {
    return '${dates.first.day}-${dates.last.day}.${dates.first.month}.${dates.first.year}';
  }

  String _getDayName(int weekday) {
    const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
      'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
    ];
    return months[month - 1];
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Подтверждена':
        return Colors.green;
      case 'Ожидает':
        return Colors.orange;
      case 'Отменена':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getAppointmentColor(String status) {
    switch (status) {
      case 'Подтверждена':
        return Colors.green.withOpacity(0.1);
      case 'Ожидает':
        return Colors.orange.withOpacity(0.1);
      case 'Отменена':
        return Colors.red.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  double _calculatePosition(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return (hour * 60 + minute) / 60 * 60;
  }

  double _calculateLeftPosition(String master) {
    const masters = ['Анна', 'Иван', 'Мария', 'Ольга'];
    final index = masters.indexOf(master.split(' ')[0]);
    return index >= 0 ? index * 150.0 : 0;
  }

  double _calculateWidth() {
    const mastersCount = 4;
    return 600 / mastersCount;
  }

  double _calculateHeight(String duration) {
    final hours = int.parse(duration.split(' ')[0]);
    return hours * 60;
  }

  List<DateTime> _getWeekDates(DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => start.add(Duration(days: index)));
  }

  List<DateTime> _getMonthDates(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    
    // Начинаем с понедельника перед первым числом месяца
    final startDate = firstDay.subtract(Duration(days: firstDay.weekday - 1));
    
    // Заканчиваем воскресеньем после последнего числа месяца
    final endDate = lastDay.add(Duration(days: 7 - lastDay.weekday));
    
    final days = <DateTime>[];
    var current = startDate;
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }
    
    return days;
  }

  List<Appointment> _getAppointmentsForDay(DateTime date) {
    // Демо-данные
    return [
      Appointment(
        client: 'Анна Петрова',
        service: 'Маникюр',
        master: 'Ольга',
        date: date,
        startTime: '10:00',
        duration: '90',
        status: 'Подтверждена',
      ),
      Appointment(
        client: 'Иван Сидоров',
        service: 'Стрижка',
        master: 'Анна',
        date: date,
        startTime: '14:00',
        duration: '60',
        status: 'Подтверждена',
      ),
    ];
  }

  List<Appointment> _getAppointmentsForWeek(List<DateTime> dates) {
    return dates.expand((date) => _getAppointmentsForDay(date)).toList();
  }

  List<Appointment> _getUpcomingAppointments() {
    return [
      Appointment(
        client: 'Анна Петрова',
        service: 'Маникюр',
        master: 'Ольга Смирнова',
        date: _selectedDate,
        startTime: '10:00',
        duration: '90 мин',
        status: 'Подтверждена',
      ),
      Appointment(
        client: 'Иван Сидоров',
        service: 'Стрижка',
        master: 'Анна Петрова',
        date: _selectedDate,
        startTime: '14:00',
        duration: '60 мин',
        status: 'Подтверждена',
      ),
      Appointment(
        client: 'Мария Иванова',
        service: 'Чистка лица',
        master: 'Мария Иванова',
        date: _selectedDate.add(const Duration(days: 1)),
        startTime: '11:30',
        duration: '120 мин',
        status: 'Ожидает',
      ),
    ];
  }
}

class Appointment {
  final String client;
  final String service;
  final String master;
  final DateTime date;
  final String startTime;
  final String duration;
  final String status;

  Appointment({
    required this.client,
    required this.service,
    required this.master,
    required this.date,
    required this.startTime,
    required this.duration,
    required this.status,
  });

  String get time => startTime;
}

class TimeSlot {
  final String time;

  TimeSlot(this.time);
}

List<TimeSlot> _generateTimeSlots() {
  return List.generate(24, (index) => TimeSlot('${index.toString().padLeft(2, '0')}:00'));
}