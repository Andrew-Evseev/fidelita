import 'package:flutter/material.dart';
import 'package:fidelita/utils/theme.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой QR-код'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [AppTheme.cardShadow],
              ),
              child: Column(
                children: [
                  // Заглушка для QR-кода
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.qr_code, size: 100, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Покажите этот код администратору',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Для начисления или списания бонусов',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF8B7355).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: const Color(0xFF8B7355)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '1 бонус = 1 рубль. Вы можете оплачивать бонусами до 50% от стоимости услуги.',
                      style: TextStyle(color: const Color(0xFF8B7355)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}