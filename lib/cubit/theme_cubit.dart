

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() :super(ThemeMode.light){
    loadThem();
  }

  Future<void> loadThem() async {
    final sharf = await SharedPreferences.getInstance();

    final isDark = sharf.getBool('dark_mode')?? false;

    emit(
      isDark
      ? ThemeMode.dark
      : ThemeMode.light
    );
  }
  

    Future<void> toggleTheme() async {
      final isDark = state == ThemeMode.dark;

      emit(
        isDark 
        ? ThemeMode.light 
        : ThemeMode.dark
      );

          final sharf = await SharedPreferences.getInstance();
          await sharf.setBool('dark_mode', !isDark);
    }
  
}