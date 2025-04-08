import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ios_f_n_fishinfrenzy_2824/widgets/game_award_dialog.dart';

class DeepSeaBattleScreen extends StatelessWidget {
  const DeepSeaBattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/deep_sea_battle.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 28.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/home_btn.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Deep Sea Battle',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              bottom: 130,
              left: 80,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/deep_sea_battle_game');
                },
                child: Container(
                  width: 280,
                  height: 140,
                  child: const Text(''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeepSeaBattleGame extends StatefulWidget {
  const DeepSeaBattleGame({super.key});

  @override
  _DeepSeaBattleGameState createState() => _DeepSeaBattleGameState();
}

class _DeepSeaBattleGameState extends State<DeepSeaBattleGame> {
  Timer? _timer;
  int _timeLeft = 10;
  int _score = 0;
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _answered = false;
  bool _gameOverShown = false;
  int _questionCount = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      "image": "assets/images/quiz/1.png",
      "answers": ["Whale", "Blue whale", "Blue shark"],
      "correct": "Blue whale",
    },
    {
      "image": "assets/images/quiz/2.png",
      "answers": ["Iridescence", "Mother-of-pearl", "Velvety"],
      "correct": "Mother-of-pearl",
    },
    {
      "image": "assets/images/quiz/3.png",
      "answers": ["Shark", "Sea Shark", "Sea Horse"],
      "correct": "Sea Shark",
    },
    {
      "image": "assets/images/quiz/4.png",
      "answers": ["Squid", "Sea urchin", "Lobster"],
      "correct": "Squid",
    },
    {
      "image": "assets/images/quiz/5.png",
      "answers": ["Barracuda", "Anglerfish", "Sardine"],
      "correct": "Anglerfish",
    },
  ];

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _currentQuestionIndex = Random().nextInt(_questions.length);
      _selectedAnswer = null;
      _answered = false;
      _timeLeft = 10;
      _gameOverShown = false;
    });

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        if (!_gameOverShown) {
          _gameOverShown = true;
          _showGameOverDialog();
        }
      }
    });
  }

  void _selectAnswer(String answer) {
    if (_answered) return;
    _timer?.cancel();
    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (answer == _questions[_currentQuestionIndex]['correct']) {
        _score += (_questionCount + 1) * 30;
        _questionCount++;
        Future.delayed(const Duration(seconds: 2), _startGame);
      } else {
        if (!_gameOverShown) {
          _gameOverShown = true;
          _showGameOverDialog();
        }
      }
    });
  }

  void _showGameOverDialog() {
    _timer?.cancel();
    print("Showing game over dialog");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GameAwardDialog(score: _score),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(question["image"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⏳ $_timeLeft',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/close_btn.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Column(
                  children:
                      question["answers"].map<Widget>((answer) {
                        bool isCorrect = answer == question["correct"];
                        bool isSelected = answer == _selectedAnswer;
                        return GestureDetector(
                          onTap: () => _selectAnswer(answer),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade900,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color:
                                    _answered
                                        ? (isSelected
                                            ? (isCorrect
                                                ? Colors.green
                                                : Colors.red)
                                            : Colors.white)
                                        : Colors.white,
                                width: 4,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                answer,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
