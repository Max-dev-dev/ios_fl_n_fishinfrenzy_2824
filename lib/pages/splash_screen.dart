// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'prehistory_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    await Future.delayed(const Duration(seconds: 2));

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PrehistoryScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/SplachScreen.png', fit: BoxFit.cover),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: 6.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
