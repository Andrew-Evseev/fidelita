import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'admin/auth/admin_auth_service.dart';
import 'app/client_app.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'admin/auth/admin_login_screen.dart';
import 'admin/dashboard/admin_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UserService()),
        ChangeNotifierProvider(create: (context) => AdminAuthService()),
      ],
      child: MaterialApp(
        title: 'Fidelita',
        theme: ThemeData(
          primaryColor: const Color(0xFF8B7355),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF8B7355),
            secondary: const Color(0xFFC5A47E),
            background: const Color(0xFFFAF8F5),
          ),
          scaffoldBackgroundColor: const Color(0xFFFAF8F5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B7355),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 24,
              ),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
            displayMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
            titleLarge: TextStyle(
              fontSize: 20,
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
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF8B7355),
            unselectedItemColor: Color(0xFF4A4A4A),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Инициализация приложения
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Задержка для показа splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AppContent(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8B7355),
                    Color(0xFFC5A47E),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.spa,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Fidelita',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B7355),
                fontFamily: 'Playfair Display',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Система лояльности для салонов красоты',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Color(0xFF8B7355),
            ),
          ],
        ),
      ),
    );
  }
}

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {
    final adminAuth = Provider.of<AdminAuthService>(context);
    
    // Проверяем статус админ-авторизации при первом запуске
    if (adminAuth.isChecking) {
      return const Scaffold(
        backgroundColor: Color(0xFFFAF8F5),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF8B7355),
          ),
        ),
      );
    }

    // Если админ авторизован, показываем админ-панель
    if (adminAuth.isAuthenticated) {
      return const AdminDashboard();
    }

    // Для обычных пользователей - основной поток
    return const UserAppFlow();
  }
}

class UserAppFlow extends StatefulWidget {
  const UserAppFlow({super.key});

  @override
  State<UserAppFlow> createState() => _UserAppFlowState();
}

class _UserAppFlowState extends State<UserAppFlow> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);

    // 1. Проверяем, прошел ли пользователь онбординг
    if (!authService.hasCompletedOnboarding) {
      return OnboardingScreen(
        onComplete: () {
          authService.completeOnboarding();
        },
      );
    }

    // 2. Проверяем, авторизован ли пользователь
    if (!userService.isAuthenticated) {
      return LoginScreen(
        onLoginSuccess: () {
          userService.login();
          userService.setUser(
            'Анна Петрова',
            'anna@example.com',
            '+7 (912) 345-67-89',
            1250,
            12,
          );
        },
      );
    }

    // 3. Если все пройдено - показываем основное приложение
    return const ClientApp();
  }
}