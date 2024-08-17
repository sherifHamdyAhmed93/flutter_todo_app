import 'package:flutter_todo_app/model/user.dart';

abstract class RegisterNavigator {
  void showLoader();

  void hideLoader();

  void showError(String key);

  void showSuccessMessageAndNavigateToHome(MyUser user);
}
