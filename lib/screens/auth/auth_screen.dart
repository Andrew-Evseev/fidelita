import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Auth Screen'),
            ElevatedButton(
              onPressed: () {
                // TODO: Реализовать авторизацию
              },
              child: const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}