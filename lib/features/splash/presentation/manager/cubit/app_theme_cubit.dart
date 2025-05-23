import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkai/core/services/shared_preference.dart';
import 'package:linkai/core/utils/app_constants.dart';
import 'package:linkai/core/utils/app_themes.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit(this.sharedPreferences) : super(AppThemeInitial());

  final SharedPreferenceServices sharedPreferences;
  ThemeMode appTheme = ThemeMode.dark;

  Future<void> getTheme() async {
    emit(AppThemeInitial());

    final String? res = await sharedPreferences.get(AppConstants.themeKey);
    if (res == null) {
      await sharedPreferences.set(AppConstants.themeKey, appTheme.name);
    } else {
      appTheme = AppThemes.fromString(res);
    }

    emit(AppThemeUpdateTheme());
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    emit(AppThemeInitial());

    appTheme = themeMode;
    await sharedPreferences.set(AppConstants.themeKey, appTheme.name);

    emit(AppThemeUpdateTheme());
  }
}
