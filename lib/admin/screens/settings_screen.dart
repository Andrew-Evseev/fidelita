import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedTab = 0;
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _autoBackup = true;
  bool _darkMode = false;
  String _language = 'Русский';
  String _timezone = 'Москва (UTC+3)';
  String _currency = 'Рубль (₽)';
  double _bonusPercentage = 10.0;

  final List<String> _tabs = [
    'Основные',
    'Бонусная система',
    'Уведомления',
    'Безопасность',
    'Интеграции',
    'Резервные копии',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSettingsContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Настройки системы',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Управление параметрами и конфигурациями системы Fidelita',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Боковая панель с табами
        Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: _tabs.asMap().entries.map((entry) => _buildSettingsTab(entry.key, entry.value)).toList(),
          ),
        ),
        const SizedBox(width: 24),
        // Основной контент
        Expanded(
          child: _buildSettingsPanel(),
        ),
      ],
    );
  }

  Widget _buildSettingsTab(int index, String title) {
    final isSelected = _selectedTab == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        borderRadius: BorderRadius.only(
          topLeft: index == 0 ? const Radius.circular(16) : Radius.zero,
          topRight: index == 0 ? const Radius.circular(16) : Radius.zero,
          bottomLeft: index == _tabs.length - 1 ? const Radius.circular(16) : Radius.zero,
          bottomRight: index == _tabs.length - 1 ? const Radius.circular(16) : Radius.zero,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF8B7355).withOpacity(0.1) : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: index < _tabs.length - 1 ? Colors.grey.shade200 : Colors.transparent,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getTabIcon(index),
                color: isSelected ? const Color(0xFF8B7355) : Colors.grey.shade600,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? const Color(0xFF8B7355) : Colors.grey.shade700,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B7355),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTabIcon(int index) {
    switch (index) {
      case 0:
        return Icons.settings;
      case 1:
        return Icons.card_giftcard;
      case 2:
        return Icons.notifications;
      case 3:
        return Icons.security;
      case 4:
        return Icons.api;
      case 5:
        return Icons.backup;
      default:
        return Icons.settings;
    }
  }

  Widget _buildSettingsPanel() {
    switch (_selectedTab) {
      case 0:
        return _buildGeneralSettings();
      case 1:
        return _buildBonusSettings();
      case 2:
        return _buildNotificationSettings();
      case 3:
        return _buildSecuritySettings();
      case 4:
        return _buildIntegrationSettings();
      case 5:
        return _buildBackupSettings();
      default:
        return _buildGeneralSettings();
    }
  }

  Widget _buildGeneralSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Основные настройки',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingRow(
            title: 'Язык интерфейса',
            description: 'Выберите язык системы',
            child: DropdownButton<String>(
              value: _language,
              isExpanded: true,
              items: ['Русский', 'English', 'Deutsch', 'Français']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _language = value!;
                });
              },
            ),
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Часовой пояс',
            description: 'Установите часовой пояс для отображения времени',
            child: DropdownButton<String>(
              value: _timezone,
              isExpanded: true,
              items: ['Москва (UTC+3)', 'Калининград (UTC+2)', 'Екатеринбург (UTC+5)', 'Владивосток (UTC+10)']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _timezone = value!;
                });
              },
            ),
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Валюта',
            description: 'Основная валюта для расчетов',
            child: DropdownButton<String>(
              value: _currency,
              isExpanded: true,
              items: ['Рубль (₽)', 'Доллар (\$)', 'Евро (€)', 'Тенге (₸)']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _currency = value!;
                });
              },
            ),
          ),
          const Divider(height: 40),
          _buildSettingSwitch(
            title: 'Темная тема',
            description: 'Включить темный режим интерфейса',
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Часы работы',
            description: 'Установите стандартные часы работы салона',
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Начало',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Конец',
                      prefixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Сбросить'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Сохранить изменения'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBonusSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Настройки бонусной системы',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingRow(
            title: 'Процент бонусов',
            description: 'Процент от суммы чека, который начисляется как бонусы',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: _bonusPercentage,
                  min: 1,
                  max: 20,
                  divisions: 19,
                  label: '${_bonusPercentage.round()}%',
                  onChanged: (value) {
                    setState(() {
                      _bonusPercentage = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  '${_bonusPercentage.round()}% от суммы чека',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 40),
          _buildSettingSwitch(
            title: 'Автоматическое начисление',
            description: 'Автоматически начислять бонусы после каждого визита',
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 40),
          _buildSettingSwitch(
            title: 'Приветственные бонусы',
            description: 'Начислять бонусы новым клиентам',
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Срок действия бонусов',
            description: 'Период, в течение которого бонусы действительны',
            child: DropdownButton<String>(
              value: '12 месяцев',
              isExpanded: true,
              items: ['3 месяца', '6 месяцев', '12 месяцев', '24 месяца']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Минимальная сумма чека',
            description: 'Минимальная сумма для начисления бонусов',
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Сумма',
                prefixText: '₽',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Сбросить'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Сохранить настройки'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Настройки уведомлений',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingSwitch(
            title: 'Включить уведомления',
            description: 'Получать уведомления о важных событиях',
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const Divider(height: 40),
          _buildSettingSwitch(
            title: 'Email уведомления',
            description: 'Отправлять уведомления на электронную почту',
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          const Divider(height: 40),
          _buildSettingSwitch(
            title: 'Push уведомления',
            description: 'Отправлять push-уведомления в приложение',
            value: _pushNotifications,
            onChanged: (value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Email для уведомлений',
            description: 'Адрес для отправки системных уведомлений',
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
          const Divider(height: 40),
          const Text(
            'Типы уведомлений',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildNotificationType('Новые записи', true),
          _buildNotificationType('Отмены записей', true),
          _buildNotificationType('Пополнение бонусов', true),
          _buildNotificationType('Истечение срока бонусов', false),
          _buildNotificationType('Системные уведомления', true),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Сбросить'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Сохранить настройки'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Настройки безопасности',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingRow(
            title: 'Смена пароля',
            description: 'Измените текущий пароль администратора',
            child: Column(
              children: [
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Текущий пароль',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Новый пароль',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Подтвердите пароль',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 40),
          _buildSettingSwitch(
            title: 'Двухфакторная аутентификация',
            description: 'Требовать подтверждение входа через SMS или приложение',
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 40),
          _buildSettingSwitch(
            title: 'Автоматический выход',
            description: 'Автоматически выходить из системы после периода неактивности',
            value: true,
            onChanged: (value) {},
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Время до автоматического выхода',
            description: 'Период неактивности перед автоматическим выходом',
            child: DropdownButton<String>(
              value: '30 минут',
              isExpanded: true,
              items: ['15 минут', '30 минут', '1 час', '2 часа', '4 часа']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'История входов',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildLoginHistoryItem('Сегодня, 10:30', 'Chrome, Windows', 'Успешно'),
          _buildLoginHistoryItem('Вчера, 18:45', 'Safari, macOS', 'Успешно'),
          _buildLoginHistoryItem('2 дня назад, 09:15', 'Chrome, Android', 'Неудачно'),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Сохранить настройки'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Интеграции',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 32),
          _buildIntegrationCard(
            title: 'SMS-рассылка',
            description: 'Интеграция с сервисом SMS-уведомлений',
            icon: Icons.sms,
            connected: true,
          ),
          const Divider(height: 24),
          _buildIntegrationCard(
            title: 'Email-рассылка',
            description: 'Интеграция с сервисом email-рассылок',
            icon: Icons.email,
            connected: true,
          ),
          const Divider(height: 24),
          _buildIntegrationCard(
            title: 'Платежная система',
            description: 'Интеграция с платежным шлюзом',
            icon: Icons.payment,
            connected: true,
          ),
          const Divider(height: 24),
          _buildIntegrationCard(
            title: '1C:Бухгалтерия',
            description: 'Синхронизация с 1С для учета',
            icon: Icons.account_balance,
            connected: false,
          ),
          const Divider(height: 24),
          _buildIntegrationCard(
            title: 'Telegram бот',
            description: 'Уведомления и запись через Telegram',
            icon: Icons.telegram,
            connected: false,
          ),
          const SizedBox(height: 40),
          const Text(
            'API ключи',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildApiKeyItem('SMS API ключ', '****************'),
          _buildApiKeyItem('Email API ключ', '****************'),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Обновить настройки'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackupSettings() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Резервные копии',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingSwitch(
            title: 'Автоматическое резервное копирование',
            description: 'Автоматически создавать резервные копии данных',
            value: _autoBackup,
            onChanged: (value) {
              setState(() {
                _autoBackup = value;
              });
            },
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Частота резервного копирования',
            description: 'Как часто создавать резервные копии',
            child: DropdownButton<String>(
              value: 'Ежедневно',
              isExpanded: true,
              items: ['Ежечасно', 'Ежедневно', 'Еженедельно', 'Ежемесячно']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          const Divider(height: 40),
          _buildSettingRow(
            title: 'Хранилище резервных копий',
            description: 'Место хранения резервных копий',
            child: DropdownButton<String>(
              value: 'Облачное хранилище',
              isExpanded: true,
              items: ['Локальный сервер', 'Облачное хранилище', 'FTP сервер', 'Google Drive']
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          const Divider(height: 40),
          const Text(
            'Последние резервные копии',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildBackupItem('Сегодня, 03:00', '256 МБ', 'Успешно'),
          _buildBackupItem('Вчера, 03:00', '254 МБ', 'Успешно'),
          _buildBackupItem('2 дня назад, 03:00', '252 МБ', 'Успешно'),
          _buildBackupItem('3 дня назад, 03:00', '250 МБ', 'Ошибка'),
          const SizedBox(height: 40),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                icon: const Icon(Icons.backup, size: 20),
                label: const Text('Создать резервную копию'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                icon: const Icon(Icons.restore, size: 20),
                label: const Text('Восстановить из копии'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Сохранить настройки'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildSettingSwitch({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: const Color(0xFF8B7355),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildNotificationType(String title, bool enabled) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: enabled,
            activeColor: const Color(0xFF8B7355),
            onChanged: (value) {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginHistoryItem(String time, String device, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            status == 'Успешно' ? Icons.check_circle : Icons.error,
            color: status == 'Успешно' ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  device,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: status == 'Успешно' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: status == 'Успешно' ? Colors.green : Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationCard({
    required String title,
    required String description,
    required IconData icon,
    required bool connected,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: connected ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: connected ? Colors.green : Colors.grey,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: connected ? Colors.green.withOpacity(0.1) : const Color(0xFF8B7355).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            connected ? 'Подключено' : 'Подключить',
            style: TextStyle(
              color: connected ? Colors.green : const Color(0xFF8B7355),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApiKeyItem(String title, String key) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.vpn_key, size: 20, color: Color(0xFF8B7355)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  key,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.content_copy, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBackupItem(String date, String size, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.backup, size: 20, color: Color(0xFF8B7355)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Размер: $size',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: status == 'Успешно' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: status == 'Успешно' ? Colors.green : Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.download, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}