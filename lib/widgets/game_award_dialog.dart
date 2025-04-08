import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fishinfrenzy_2824/cubit/balance_cubit.dart';

class GameAwardDialog extends StatelessWidget {
  final int score;
  const GameAwardDialog({required this.score, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF002D67), // Головний фон (темно-синій)
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Reward",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "+$score",
              style: const TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w800,
                color: Color(0xFFF9BE28),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                context.read<BalanceCubit>().addScore(score);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Container(
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9BE28),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white, width: 4),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
