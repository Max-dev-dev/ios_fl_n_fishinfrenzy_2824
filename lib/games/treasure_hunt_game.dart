import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ios_f_n_fishinfrenzy_2824/widgets/game_award_dialog.dart';

class TreasureHuntScreen extends StatelessWidget {
  const TreasureHuntScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/treasure_hunt.png'),
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
                            'Treasure Hunt',
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
                  Navigator.pushNamed(context, '/treasure_hunt_game');
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

class TreasureHuntScreenGame extends StatefulWidget {
  const TreasureHuntScreenGame({super.key});

  @override
  _TreasureHuntScreenGameState createState() => _TreasureHuntScreenGameState();
}

class _TreasureHuntScreenGameState extends State<TreasureHuntScreenGame>
    with TickerProviderStateMixin {
  final Random _random = Random();
  List<FallingObject> _fallingObjects = [];
  int _score = 0;
  bool _isGameOver = false;
  bool _isGameStarted = false;
  late Timer _spawnTimer;
  late Timer _gameTimer;
  late Timer _fallingTimer;
  int _timeLeft = 5;

  @override
  void initState() {
    super.initState();
    print("initState called");
    _startCountdown();
    _showMissionSnackbar();
  }

  void _startCountdown() {
    print("Countdown started");
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print("Countdown: $_timeLeft");
      if (_timeLeft > 1) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel();
        _startGame();
      }
    });
  }

  void _showMissionSnackbar() {
    print("Showing mission snackbar");
    Future.delayed(const Duration(milliseconds: 300), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "The sea is always full of adventures and dangers, so in the mini-game Treasure Hunt, you can try your luck and attempt to find treasures—or stumble upon sea predators and end up with nothing! Good luck! ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color(0xFF002D67),
        ),
      );
    });
  }

  void _startGame() {
    print("Game started");
    setState(() {
      _isGameStarted = true;
      _timeLeft = 60;
    });

    _isGameOver = false;
    _score = 0;
    _fallingObjects.clear();

    _spawnTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (!_isGameOver) {
        _generateFallingObject();
      }
    });

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print("Game time left: $_timeLeft");
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _endGame();
      }
    });

    _fallingTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!_isGameOver) {
        _updateGame();
      }
    });
  }

  void _generateFallingObject() {
    print("Generating falling object");
    double newX;
    bool overlaps;
    int attempts = 0;

    do {
      if (attempts > 100) {
        print("Failed to generate non-overlapping object after 100 attempts");
        return;
      }

      overlaps = false;
      newX = _random.nextDouble() * (MediaQuery.of(context).size.width - 150);

      for (var obj in _fallingObjects) {
        if ((newX - obj.x).abs() < 150) {
          overlaps = true;
          break;
        }
      }
      attempts++;
    } while (overlaps);

    FallingObject newObj = FallingObject(
      type: _randomObjectType(),
      x: newX,
      y: -150,
    );

    setState(() {
      _fallingObjects.add(newObj);
    });

    print("Generated: ${newObj.type} at X: ${newObj.x}");
  }

  void _endGame() {
    if (_isGameOver) return;
    print("Game over");
    _isGameOver = true;
    _spawnTimer.cancel();
    _gameTimer.cancel();
    _fallingTimer.cancel();
    _showGameOverDialog();
  }

  String _randomObjectType() {
    int rand = _random.nextInt(3);
    String type =
        rand == 0
            ? "chest"
            : rand == 1
            ? "shark"
            : "jellyfish";
    print("Generated object type: $type");
    return type;
  }

  void _handleTap(FallingObject obj) {
    print("Tapped: ${obj.type} at X: ${obj.x}");
    if (obj.type == "shark" || obj.type == "jellyfish") {
      setState(() {
        _fallingObjects.remove(obj);
      });
      print("Removed: ${obj.type}");
    }
  }

  void _updateGame() {
    if (_isGameOver) return;
    List<FallingObject> toRemove = [];

    for (var obj in _fallingObjects) {
      obj.y += 3.0;
      if (obj.y > MediaQuery.of(context).size.height - 150) {
        print("Object reached bottom: ${obj.type} at Y: ${obj.y}");
        if (obj.type == "shark" || obj.type == "jellyfish") {
          _endGame();
        } else if (obj.type == "chest") {
          _score += 5;
        }
        toRemove.add(obj);
      }
    }

    if (toRemove.isNotEmpty) {
      setState(() {
        _fallingObjects.removeWhere((obj) => toRemove.contains(obj));
      });
      print("Removed ${toRemove.length} objects");
    }
  }

  void _showGameOverDialog() {
    print("Showing game over dialog");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => GameAwardDialog(score: _score),
    );
  }

  @override
  void dispose() {
    print("Disposing timers");
    _spawnTimer.cancel();
    _gameTimer.cancel();
    _fallingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Mini-games.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
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
                Expanded(
                  child: GestureDetector(
                    onTapDown: (details) {
                      FallingObject? tappedObj;
                      for (var obj in _fallingObjects) {
                        if ((details.localPosition.dx - obj.x).abs() < 75 &&
                            (details.localPosition.dy - obj.y).abs() < 75) {
                          tappedObj = obj;
                          break;
                        }
                      }
                      if (tappedObj != null) {
                        _handleTap(tappedObj);
                      }
                    },
                    child: Stack(
                      children: [
                        ..._fallingObjects.map(
                          (obj) => FallingObjectWidget(
                            obj: obj,
                            screenHeight: MediaQuery.of(context).size.height,
                            onReachBottom: () {
                              if (obj.type == "shark" ||
                                  obj.type == "jellyfish") {
                                _endGame();
                              } else if (obj.type == "chest") {
                                setState(() {
                                  _score += 5;
                                });
                              }
                            },
                            onRemove: () {
                              setState(() {
                                _fallingObjects.remove(obj);
                              });
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: MediaQuery.of(context).size.width / 4.5,
                          child: Image.asset(
                            "assets/images/treasure_hunt/submarine.png",
                            width: 250,
                            height: 250,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FallingObjectWidget extends StatefulWidget {
  final FallingObject obj;
  final double screenHeight;
  final VoidCallback onReachBottom;
  final VoidCallback onRemove;

  const FallingObjectWidget({
    Key? key,
    required this.obj,
    required this.screenHeight,
    required this.onReachBottom,
    required this.onRemove,
  }) : super(key: key);

  @override
  _FallingObjectWidgetState createState() => _FallingObjectWidgetState();
}

class _FallingObjectWidgetState extends State<FallingObjectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double>? _fallAnimation;
  bool _isRemoved = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    );

    _fallAnimation = Tween<double>(
      begin: widget.obj.y,
      end: widget.screenHeight - 150,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().whenComplete(() {
      if (!_isRemoved) {
        widget.onReachBottom();
        _removeObject();
      }
    });
  }

  void _removeObject() {
    if (_isRemoved) return;
    _isRemoved = true;
    _controller.stop();
    _controller.dispose();
    //widget.onRemove();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fallAnimation == null) {
      return const SizedBox();
    }

    return AnimatedBuilder(
      animation: _fallAnimation!,
      builder: (context, child) {
        return Positioned(
          left: widget.obj.x,
          top: _fallAnimation!.value,
          child: GestureDetector(
            onTap: () {},

            // {
            //   if (widget.obj.type == "shark" ||
            //       widget.obj.type == "jellyfish") {
            //     _removeObject();
            //   }
            // },
            child: child!,
          ),
        );
      },
      child: Image.asset(
        "assets/images/treasure_hunt/${widget.obj.type}.png",
        width: 150,
        height: 150,
      ),
    );
  }
}

class FallingObject {
  String type;
  double x;
  double y;

  FallingObject({required this.type, required this.x, required this.y});
}
