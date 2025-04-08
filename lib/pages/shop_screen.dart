import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fishinfrenzy_2824/cubit/balance_cubit.dart';
import 'package:ios_f_n_fishinfrenzy_2824/cubit/fish_cubit.dart';

class ShopScreen extends StatelessWidget {
  final Map<String, String> fishMap = {
    'assets/images/fish/1.png': 'Golden Moray Eel',
    'assets/images/fish/2.png': 'Blue Shark',
    'assets/images/fish/4.png': 'Moon Fish',
    'assets/images/fish/5.png': 'Sea Dragon',
    'assets/images/fish/6.png': 'Silver Marlin',
  };

  ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Mini-games.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildChestItem(
                      context,
                      'assets/images/common_chest.png',
                      500,
                    ),
                    _buildChestItem(
                      context,
                      'assets/images/rare_chest.png',
                      1000,
                    ),
                    _buildChestItem(
                      context,
                      'assets/images/legendary_chest.png',
                      1500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/home_btn.png',
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Shop',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              const Text(
                'Balance:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/water_star.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<BalanceCubit, int>(
                    builder: (context, balance) {
                      return Text(
                        balance.toString(),
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChestItem(BuildContext context, String imagePath, int price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF002D67),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.asset(imagePath, height: 200),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              final balanceCubit = context.read<BalanceCubit>();
              if (balanceCubit.state >= price) {
                balanceCubit.reduceScore(balanceCubit.state - price);
                _showOpenChestDialog(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Insufficient balance to open the chest",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    duration: Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color(0xFFF9BE28),
                  ),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9BE28),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Open',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Image.asset('assets/images/water_star.png', width: 24),
                    const SizedBox(width: 5),
                    Text(
                      price.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOpenChestDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF002D67),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Click to open',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _showFishRewardDialog(context);
                },
                child: Image.asset(
                  'assets/images/legendary_chest.png',
                  height: 200,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFishRewardDialog(BuildContext context) {
    final fishList = fishMap.keys.toList();
    final randomFish = fishList[Random().nextInt(fishList.length)];
    final fishName = fishMap[randomFish]!;

    context.read<FishCubit>().addFish(fishName);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF002D67),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'You have opened',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(randomFish, height: 200),
              const SizedBox(height: 20),
              Text(
                fishName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFF9BE28),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
