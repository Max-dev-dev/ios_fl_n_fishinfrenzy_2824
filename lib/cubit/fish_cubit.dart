import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FishCubit extends Cubit<List<String>> {
  FishCubit() : super([]);

  Future<void> loadFishes() async {
    final prefs = await SharedPreferences.getInstance();
    final fishes = prefs.getStringList('caught_fishes') ?? [];
    emit(fishes);
  }

  Future<void> addFish(String fish) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedFishes = List<String>.from(state)..add(fish);
    await prefs.setStringList('caught_fishes', updatedFishes);
    emit(updatedFishes);
  }
}
