import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fidelita/services/user_service.dart';
import 'package:fidelita/utils/theme.dart';

class BonusScreen extends StatelessWidget {
  const BonusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBonusInfo(context),
          const SizedBox(height: 25),
          _buildBonusHistory(context),
        ],
      ),
    );
  }

  Widget _buildBonusInfo(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, userService, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [AppTheme.cardShadow],
          ),
          child: Column(
            children: [
              Text(
                '${userService.bonusBalance ?? 0}',
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'бонусов на счету',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '1 бонус = 1 рубль',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Курс обмена',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '5%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Начисление',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBonusHistory(BuildContext context) {
    final transactions = [
      {'type': 'Начисление', 'amount': '+250', 'date': '15 дек 2024', 'description': 'За визит в салон'},
      {'type': 'Списание', 'amount': '-150', 'date': '10 дек 2024', 'description': 'Оплата услуг'},
      {'type': 'Начисление', 'amount': '+300', 'date': '1 дек 2024', 'description': 'Акция "День красоты"'},
      {'type': 'Начисление', 'amount': '+200', 'date': '25 ноя 2024', 'description': 'За визит в салон'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'История операций',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        ...transactions.map((transaction) => _buildTransactionItem(context, transaction)),
      ],
    );
  }

  Widget _buildTransactionItem(BuildContext context, Map<String, dynamic> transaction) {
    final isPositive = transaction['amount'].toString().startsWith('+');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isPositive 
                  ? const Color(0xFF8B7355).withOpacity(0.1)
                  : const Color(0xFFC5A47E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isPositive ? Icons.add : Icons.remove,
              color: isPositive ? const Color(0xFF8B7355) : const Color(0xFFC5A47E),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['type'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction['description'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isPositive ? const Color(0xFF8B7355) : const Color(0xFFC5A47E),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                transaction['date'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}