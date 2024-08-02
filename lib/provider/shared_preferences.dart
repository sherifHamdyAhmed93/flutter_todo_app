import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String themeKey = 'app_theme';
  static const String langKey = 'app_lang';

  Future<void> saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, theme);
  }

  Future<String?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeKey);
  }

  Future<void> saveLang(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(langKey, lang);
  }

  Future<String?> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(langKey);
  }
}
