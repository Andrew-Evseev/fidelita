import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Основные сервисы
import 'services/auth_service.dart';
import 'services/user_service.dart';
import 'services/chat_service.dart';
import 'services/qr_service.dart';
import 'services/notification_service.dart';

// Основные экраны
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/qr/qr_screen.dart';
import 'screens/feedback/feedback_screen.dart';

// Клиентское приложение
import 'app/client_app.dart';

// Тема
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => QrService()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
      ],
      child: MaterialApp(
        title: 'Fidelita',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const AppWrapper(),
        routes: {
          '/qr': (context) => const QrScreen(),
          '/feedback': (context) => const FeedbackScreen(),
        },
      ),
    );
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);

    // Временная логика для демонстрации
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 500)), // Имитация загрузки
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildSplashScreen();
        }

        // Проверяем, прошел ли пользователь онбординг
        if (!authService.hasCompletedOnboarding) {
          return OnboardingScreen(
            onComplete: () {
              authService.completeOnboarding();
            },
          );
        }

        // Проверяем, авторизован ли пользователь
        if (!authService.isAuthenticated) {
          return LoginScreen(
            onLoginSuccess: () {
              authService.login();
              // Устанавливаем тестовые данные пользователя
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

        // Если пользователь авторизован, показываем клиентское приложение
        return const ClientApp();
      },
    );
  }

  Widget _buildSplashScreen() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Заглушка для логотипа
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.spa, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                'Fidelita',
                style: AppTheme.lightTheme.textTheme.displayLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'Система лояльности',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}