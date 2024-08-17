import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/model/user.dart';
import 'package:flutter_todo_app/register/register_view_model/register_navigator.dart';

class RegisterViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  var globalKeys = GlobalKey<FormState>();

  RegisterNavigator registerNavigator;

  RegisterViewModel({required this.registerNavigator});

  String? validateName() {
    if (nameController.text == null || nameController.text.isEmpty) {
      return 'name_is_empty_error';
    }
    return null;
  }

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

  String? validateConfirmPassword() {
    var password = passwordController.text;
    var confirmPassword = confirmPasswordController.text;

    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'confirm_password_is_empty_error';
    } else if (confirmPassword.length < 6) {
      return 'password_length_error';
    } else if (confirmPassword != password) {
      return 'confirm_password_is_not_match_password_error';
    }
    return null;
  }

  Future<void> register() async {
    if (globalKeys.currentState?.validate() == true) {
      registerNavigator.showLoader();
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        MyUser user = MyUser(
            id: credential.user?.uid ?? '',
            email: emailController.text,
            name: nameController.text);

        await FirebaseUtils.addUserToFirestore(user);

        registerNavigator.hideLoader();
        registerNavigator.showSuccessMessageAndNavigateToHome(user);
      } on FirebaseAuthException catch (e) {
        registerNavigator.hideLoader();
        print(e.code);
        if (e.code == 'weak-password') {
          registerNavigator.showError('weak_password_error');
        } else if (e.code == 'email-already-in-use') {
          registerNavigator.showError('email_already_exist');
        } else {
          registerNavigator.showError(e.message ?? '');
        }
      } catch (e) {
        print(e.toString());
        registerNavigator.hideLoader();
        registerNavigator.showError(e.toString());
      }
    }
  }
}
