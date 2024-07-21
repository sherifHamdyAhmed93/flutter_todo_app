import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  String currentAppLanguage = 'en';
  final PreferencesService _preferencesService = PreferencesService();

  AppLanguageProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final lang = await _preferencesService.getLang();
    currentAppLanguage = lang ?? 'en';
    notifyListeners();
  }

  void changeAppLanguage(String lang) {
    if (currentAppLanguage == lang) {
      return;
    } else {
      currentAppLanguage = lang;
    }
    _preferencesService.saveLang(currentAppLanguage);
    notifyListeners();
  }

  bool isCurrentAppLangEn() {
    return currentAppLanguage == 'en';
  }

  String getCurrentLanguageName(BuildContext context) {
    return isCurrentAppLangEn()
        ? "${AppLocalizations.of(context)!.english}"
        : "${AppLocalizations.of(context)!.arabic}";
  }
}
