import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KeyTranslator {
  static String? translate(BuildContext context, String? key) {
    var translatedMessage = key;
    switch (key) {
      case 'invalid_credential':
        translatedMessage = AppLocalizations.of(context)!.invalid_credential;
        break;
      case 'email_is_empty_error':
        translatedMessage = AppLocalizations.of(context)!.email_is_empty_error;
        break;
      case 'email_is_not_valid_error':
        translatedMessage =
            AppLocalizations.of(context)!.email_is_not_valid_error;
        break;
      case 'password_is_empty_error':
        translatedMessage =
            AppLocalizations.of(context)!.password_is_empty_error;
        break;
      case 'password_length_error':
        translatedMessage = AppLocalizations.of(context)!.password_length_error;
        break;
      case 'weak_password_error':
        translatedMessage = AppLocalizations.of(context)!.weak_password_error;
        break;
      case 'email_already_exist':
        translatedMessage = AppLocalizations.of(context)!.email_already_exist;
        break;
      case 'confirm_password_is_not_match_password_error':
        translatedMessage = AppLocalizations.of(context)!
            .confirm_password_is_not_match_password_error;
        break;
      case 'confirm_password_is_empty_error':
        translatedMessage =
            AppLocalizations.of(context)!.confirm_password_is_empty_error;
        break;
      case 'name_is_empty_error':
        translatedMessage = AppLocalizations.of(context)!.name_is_empty_error;
        break;
    }
    return translatedMessage;
  }
}
