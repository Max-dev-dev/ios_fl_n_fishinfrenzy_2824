import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fishinfrenzy_2824/cubit/balance_cubit.dart';
import 'package:ios_f_n_fishinfrenzy_2824/cubit/fish_cubit.dart';
import 'package:ios_f_n_fishinfrenzy_2824/games/deep_sea_battle_game.dart';
import 'package:ios_f_n_fishinfrenzy_2824/games/treasure_hunt_game.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/challenges_screen.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/collections_screen.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/home_screen.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/mini_games_screen.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/progress_screen.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/rating_screen.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/shop_screen.dart';
import 'package:ios_f_n_fishinfrenzy_2824/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BalanceCubit()),
        BlocProvider(create: (context) => FishCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/challenges': (context) => const ChallengesScreen(),
          '/shop': (context) => ShopScreen(),
          '/progress': (context) => const ProgressScreen(),
          '/collections': (context) => const CollectionsScreen(),
          '/rating': (context) => RatingScreen(),
          '/mini_games': (context) => const MiniGamesScreen(),
          '/treasure_hunt': (context) => const TreasureHuntScreen(),
          '/treasure_hunt_game': (context) => const TreasureHuntScreenGame(),
          '/deep_sea_battle': (context) => const DeepSeaBattleScreen(),
          '/deep_sea_battle_game': (context) => const DeepSeaBattleGame(),
        },
      ),
    );
  }
}
