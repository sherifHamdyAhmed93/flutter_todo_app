import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/login/custom_text_field.dart';
import 'package:flutter_todo_app/login/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static String screenName = "login_screen";

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var globalKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: AppColors.backgroundLightColor,
            child: Image.asset(
              'assets/images/login_background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Create Account'),
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomTextField(
                        hintText: 'name',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your name';
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

  void validate() {
    if (globalKeys.currentState?.validate() == true) {}
  }
}
