class User {
  final String id;
  final String phone;
  final String? name;
  final String? email;
  final DateTime? birthDate;
  final DateTime createdAt;
  final String? avatarUrl;
  final bool notificationsEnabled;
  final bool emailNotifications; // Добавляем
  final bool smsNotifications;   // Добавляем
  final String? preferredSalon;
  final int bonusBalance;        // Добавляем
  final int totalVisits;         // Добавляем
  final int totalBonusesEarned;  // Добавляем
  final String loyaltyLevel;     // Добавляем

  User({
    required this.id,
    required this.phone,
    this.name,
    this.email,
    this.birthDate,
    required this.createdAt,
    this.avatarUrl,
    this.notificationsEnabled = true,
    this.emailNotifications = true,  // Новое поле
    this.smsNotifications = true,    // Новое поле
    this.preferredSalon,
    this.bonusBalance = 0,           // Новое поле
    this.totalVisits = 0,            // Новое поле
    this.totalBonusesEarned = 0,     // Новое поле
    this.loyaltyLevel = 'Стандарт',  // Новое поле
  });

  // Для демо-данных
  factory User.demo(String phone) {
    return User(
      id: 'demo_$phone',
      phone: phone,
      name: 'Анна Иванова',
      email: 'anna@example.com',
      birthDate: DateTime(1990, 5, 15),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      notificationsEnabled: true,
      emailNotifications: true,
      smsNotifications: true,
      preferredSalon: 'Салон Эстель',
      bonusBalance: 150,
      totalVisits: 8,
      totalBonusesEarned: 450,
      loyaltyLevel: 'Серебро',
    );
  }

  // Остальные методы остаются без изменений...

  User copyWith({
    String? name,
    String? email,
    DateTime? birthDate,
    bool? notificationsEnabled,
    bool? emailNotifications,  // Добавляем
    bool? smsNotifications,    // Добавляем
    String? preferredSalon,
    int? bonusBalance,         // Добавляем
    int? totalVisits,          // Добавляем
    int? totalBonusesEarned,   // Добавляем
    String? loyaltyLevel,      // Добавляем
  }) {
    return User(
      id: id,
      phone: phone,
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      createdAt: createdAt,
      avatarUrl: avatarUrl,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
      preferredSalon: preferredSalon ?? this.preferredSalon,
      bonusBalance: bonusBalance ?? this.bonusBalance,
      totalVisits: totalVisits ?? this.totalVisits,
      totalBonusesEarned: totalBonusesEarned ?? this.totalBonusesEarned,
      loyaltyLevel: loyaltyLevel ?? this.loyaltyLevel,
    );
  }
}