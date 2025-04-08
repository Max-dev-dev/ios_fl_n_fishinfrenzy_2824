import 'package:flutter/material.dart';
import 'home_screen.dart';

class PrehistoryScreen extends StatefulWidget {
  const PrehistoryScreen({super.key});

  @override
  _PrehistoryScreenState createState() => _PrehistoryScreenState();
}

class _PrehistoryScreenState extends State<PrehistoryScreen> {
  int _currentIndex = 0;
  bool _hasChosen = false;

  void _nextImage() {
    if (_currentIndex == 14 && !_hasChosen) {
      return;
    }
    if (_currentIndex < 42) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _goToHome();
    }
  }

  void _goToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _chooseOption() {
    setState(() {
      _hasChosen = true;
    });
    _nextImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0465E3),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: _nextImage,
            child: Image.asset(
              'assets/images/prehistory/${_currentIndex + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: _goToHome,
              child: Image.asset(
                'assets/images/close_btn.png',
                width: 50,
                height: 50,
              ),
            ),
          ),
          // Показати кнопки вибору тільки на 15-му слайді
          if (_currentIndex == 14) _buildChoiceButtons(),
        ],
      ),
    );
  }

  Widget _buildChoiceButtons() {
    return Positioned(
      bottom: 100,
      left: 20,
      right: 20,
      child: Column(
        children: [
          _buildChoiceButton("Modern technologies"),
          const SizedBox(height: 10),
          _buildChoiceButton("Old proven methods"),
        ],
      ),
    );
  }

  Widget _buildChoiceButton(String text) {
    return GestureDetector(
      onTap: _chooseOption,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF0465E3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber, width: 3),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
