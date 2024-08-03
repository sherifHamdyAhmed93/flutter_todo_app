import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/login/custom_text_field.dart';
import 'package:flutter_todo_app/login/signup_screen.dart';
import 'package:flutter_todo_app/model/user.dart';
import 'package:flutter_todo_app/provider/app_theme_provider.dart';
import 'package:flutter_todo_app/utils/alert_dialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static String screenName = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var globalKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Stack(
      children: [
        Container(
            color: themeProvider.isCurrentAppThemeLight()
                ? AppColors.backgroundLightColor
                : AppColors.backgroundDarkColor,
            child: Image.asset(
              'assets/images/login_background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Login'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Form(
            key: globalKeys,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.23),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Welcome back',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomTextField(
                        hintText: 'Email',
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value ?? "");
                          if (value == null || value.isEmpty) {
                            return 'Enter your email';
                          } else if (!emailValid) {
                            return 'Email is not valid';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomTextField(
                        hintText: 'Password',
                        controller: passwordController,
                        inputType: TextInputType.number,
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Password';
                          } else if (value.length < 6) {
                            return 'Password length must be as least 6 characters';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                        onPressed: validate,
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20)),
                        child: Text('Create')),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(SignupScreen.screenName);
                      },
                      child: Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void validate() async {
    if (globalKeys.currentState?.validate() == true) {
      DialogUtils.showLoader(context: context, message: 'Loading...');
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

        DialogUtils.hideLoader(context);
        DialogUtils.showMessage(
            context: context,
            title: 'Success',
            message: 'Logined Successfully',
            posActionName: 'OK',
            posAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.screenName);
            });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoader(context);
        if (e.code == 'user-not-found') {
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message: 'No user found for that email.',
            posActionName: 'OK',
          );
        } else if (e.code == 'wrong-password') {
          print('The account already exists for that email.');
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message: 'Wrong password provided for that user.',
            posActionName: 'OK',
          );
        } else if (e.code == 'invalid-credential') {
          print(
              'The supplied auth credential is incorrect, malformed or has expired');
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
            posActionName: 'OK',
          );
        } else {
          print(e.code);
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message: 'An error occurred: ${e.message}',
            posActionName: 'OK',
          );
        }
      } catch (e) {
        print(e);
        DialogUtils.hideLoader(context);
        DialogUtils.showMessage(
          context: context,
          title: 'Error',
          message: e.toString(),
          posActionName: 'OK',
        );
      }
    }
  }
}
