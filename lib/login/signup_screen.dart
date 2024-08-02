import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/login/custom_text_field.dart';
import 'package:flutter_todo_app/utils/alert_dialog.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  static String screenName = "signup_screen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController(text: 'Sherif');

  TextEditingController emailController =
      TextEditingController(text: 'sherif@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');

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
                    child: CustomTextField(
                        hintText: 'Confirm Password',
                        controller: confirmPasswordController,
                        inputType: TextInputType.number,
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Confrim Password';
                          } else if (value.length < 6) {
                            return 'Password length must be as least 6 characters';
                          } else if (value != passwordController.text) {
                            return 'Confirm Password must be same as password';
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
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideLoader(context);
        DialogUtils.showMessage(
            context: context,
            title: 'Success',
            message: 'Register Successfully',
            posActionName: 'OK',
            posAction: () {
              Navigator.pushNamed(context, HomeScreen.screenName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoader(context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message: 'The password provided is too weak.',
            posActionName: 'OK',
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          DialogUtils.hideLoader(context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message: 'The account already exists for that email.',
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
