import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fidelita/utils/theme.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cards = [
      {'number': '**** 4832', 'type': 'Visa', 'balance': '45 680 ₽', 'color': Colors.blue},
      {'number': '**** 1567', 'type': 'MasterCard', 'balance': '12 340 ₽', 'color': Colors.red},
      {'number': '**** 9021', 'type': 'Мир', 'balance': '67 890 ₽', 'color': Colors.green},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Мои карты',
            style: GoogleFonts.manrope(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ...cards.map((card) => _buildCardItem(context, card)),
          const SizedBox(height: 20),
          _buildAddCardButton(context),
        ],
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, Map<String, dynamic> card) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            card['color'],
            card['color'].withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card['type'],
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                card['number'],
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Баланс',
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          Text(
            card['balance'],
            style: GoogleFonts.manrope(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D3748) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppTheme.cardShadow],
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Color(0xFF667EEA),
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Добавить карту',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}