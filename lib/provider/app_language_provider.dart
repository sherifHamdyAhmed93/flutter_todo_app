import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLanguageProvider extends ChangeNotifier {
  String currentAppLanguage = 'en';

  bool isCurrentAppLangEn() {
    return currentAppLanguage == 'en';
  }

  String getCurrentLanguageName(BuildContext context) {
    return isCurrentAppLangEn()
        ? "${AppLocalizations.of(context)!.english}"
        : "${AppLocalizations.of(context)!.arabic}";
  }

  void changeAppLanguage(String lang) {
    if (currentAppLanguage == lang) {
      return;
    } else {
      currentAppLanguage = lang;
    }
    notifyListeners();
  }
}
