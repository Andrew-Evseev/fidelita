import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF8B7355),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF8B7355),
      secondary: Color(0xFFC5A47E),
      background: Color(0xFFFAFAFA),
    ),
    // Используем стандартные шрифты Flutter
    fontFamily: 'Roboto', // Стандартный шрифт Flutter
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1A1A1A),
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A1A),
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF4A4A4A),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF4A4A4A),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFC5A47E),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFC5A47E),
      secondary: Color(0xFF8B7355),
      background: Color(0xFF121212),
    ),
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      centerTitle: true,
    ),
  );

  // Градиенты для салона красоты
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B7355), Color(0xFFC5A47E)],
  );

  static const secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC5A47E), Color(0xFFE8D5B7)],
  );

  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Color(0xFFF8F8F8)],
  );

  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAFAFA), Color(0xFFF0F0F0)],
  );

  // Тени
  static final cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.08),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
}