import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fishinfrenzy_2824/cubit/balance_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9A928),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              color: Color(0xFFF9A928),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      buildMenuButton(
                        'MINI-GAMES',
                        const Color(0xFF6028F9),
                        onTap: () {
                          Navigator.pushNamed(context, '/mini_games');
                        },
                      ),
                      buildMenuButton(
                        'PROGRESS',
                        const Color(0xFFF92828),
                        onTap: () => Navigator.pushNamed(context, '/progress'),
                      ),
                      buildMenuButton(
                        'COLLECTIONS',
                        const Color(0xFF39F928),
                        onTap: () {
                          Navigator.pushNamed(context, '/collections');
                        },
                      ),
                      buildMenuButton(
                        'CHALLENGES',
                        const Color(0xFF2883F9),
                        onTap: () {
                          Navigator.pushNamed(context, '/challenges');
                        },
                      ),
                      buildMenuButton('SHOP', const Color(0xFFF9A928), onTap: () => Navigator.pushNamed(context, '/shop'),),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(String text, Color color, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: Container(height: 12),
          ),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white, width: 6),
                ),
              ),
              onPressed: onTap,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
