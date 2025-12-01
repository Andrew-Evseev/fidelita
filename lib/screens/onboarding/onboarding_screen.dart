import 'package:flutter/material.dart';
import 'package:fidelita/utils/theme.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Накопительная система',
      'description': 'Получайте бонусы за каждое посещение и оплачивайте ими до 50% от стоимости услуг',
      'image': '🎁',
    },
    {
      'title': 'Персональные предложения',
      'description': 'Получайте специальные предложения, подобранные именно для вас',
      'image': '⭐',
    },
    {
      'title': 'Удобное общение',
      'description': 'Общайтесь с администратором салона прямо в приложении',
      'image': '💬',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return _buildOnboardingPage(_onboardingData[index]);
                },
              ),
            ),
            _buildIndicator(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data['image']!,
            style: const TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 40),
          Text(
            data['title']!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            data['description']!,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF4A4A4A),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _onboardingData.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == entry.key ? const Color(0xFF8B7355) : Colors.grey,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButton() {
    return Container(
      margin: const EdgeInsets.all(40),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_currentPage < _onboardingData.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          } else {
            widget.onComplete();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B7355),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          _currentPage < _onboardingData.length - 1 ? 'Далее' : 'Начать',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}