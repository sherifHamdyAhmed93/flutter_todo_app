import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/model/user.dart';
import 'package:flutter_todo_app/view_model/login_navigator.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var globalKeys = GlobalKey<FormState>();

  LoginNavigator loginNavigator;

  LoginViewModel({required this.loginNavigator});

  String? validateEmail() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text ?? "");
    if (emailController.text == null || emailController.text.isEmpty) {
      return 'email_is_empty_error';
    } else if (!emailValid) {
      return 'email_is_not_valid_error';
    }
    return null;
  }

  String? validatePassword() {
    if (passwordController.text == null || passwordController.text.isEmpty) {
      return 'password_is_empty_error';
    } else if (passwordController.text.length < 6) {
      return 'password_length_error';
    }
    return null;
  }

  Future<void> login() async {
    if (globalKeys.currentState?.validate() == true) {
      loginNavigator.showLoader();
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        MyUser? user = await FirebaseUtils.readUserFromFirestore(
            credential.user?.uid ?? '');

        if (user == null) {
          return;
        }

        loginNavigator.hideLoader();
        loginNavigator.showSuccessMessageAndNavigateToHome(user);
      } on FirebaseAuthException catch (e) {
        loginNavigator.hideLoader();
        print(e.code);
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          loginNavigator.showError('invalid_credential');
        } else {
          loginNavigator.showError(e.message ?? '');
        }
      } catch (e) {
        print(e.toString());
        loginNavigator.hideLoader();
        loginNavigator.showError(e.toString());
      }
    }
  }
}
