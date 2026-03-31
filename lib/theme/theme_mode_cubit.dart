import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit() : super(ThemeMode.light);

  void setDarkMode(bool isDarkMode) {
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
