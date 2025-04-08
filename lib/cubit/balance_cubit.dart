import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceCubit extends Cubit<int> {
  BalanceCubit() : super(0) {
    _loadBalance();
  }

  void addScore(int value) {
    int newBalance = state + value;
    emit(newBalance);
    _saveBalance(newBalance);
  }

  void reduceScore(int value) {
    int newBalance = state - value;
    emit(newBalance);
    _saveBalance(newBalance);
  }

  Future<void> _loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final balance = prefs.getInt('balance') ?? 0;
    emit(balance);
  }

  Future<void> _saveBalance(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('balance', value);
  }
}
