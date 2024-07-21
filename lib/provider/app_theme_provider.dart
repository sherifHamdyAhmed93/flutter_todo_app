import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../colors/app_colors.dart';
import '../theme/app_theme.dart';
import 'shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode currentAppTheme = ThemeMode.light;
  final PreferencesService _preferencesService = PreferencesService();

  AppThemeProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final theme = await _preferencesService.getTheme();
    currentAppTheme = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void changeAppTheme(ThemeMode mode) {
    if (currentAppTheme == mode) {
      return;
    } else {
      currentAppTheme = mode;
    }
    _preferencesService
        .saveTheme(currentAppTheme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  bool isCurrentAppThemeLight() {
    return currentAppTheme == ThemeMode.light;
  }

  ThemeData getCurrentAppTheme() {
    return currentAppTheme == ThemeMode.light
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;
  }

  Color getFieldBackgroundColor() {
    return isCurrentAppThemeLight()
        ? AppColors.whiteColor
        : AppColors.cardBackgroundDarkColor;
  }

  Color getSelectionColor() {
    return isCurrentAppThemeLight()
        ? AppColors.primaryColor
        : AppColors.primaryColor;
  }

  Color getContainerBackground() {
    return isCurrentAppThemeLight()
        ? AppColors.cardBackgroundLightColor
        : AppColors.cardBackgroundDarkColor;
  }

  Color getIconsColor() {
    return isCurrentAppThemeLight()
        ? AppColors.primaryColor
        : AppColors.primaryColor;
  }

  Color getNavBarBackgrounnd() {
    return isCurrentAppThemeLight()
        ? AppColors.whiteColor
        : AppColors.backgroundDarkColor;
  }

  String getCurrentThemeName(BuildContext context) {
    return isCurrentAppThemeLight()
        ? "${AppLocalizations.of(context)!.day_mode}"
        : "${AppLocalizations.of(context)!.night_mode}";
  }
}
