import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/login/custom_text_field.dart';
import 'package:flutter_todo_app/model/user.dart';
import 'package:flutter_todo_app/provider/app_theme_provider.dart';
import 'package:flutter_todo_app/provider/authUserProvider.dart';
import 'package:flutter_todo_app/utils/alert_dialog.dart';
import 'package:provider/provider.dart';

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
            title: Text(AppLocalizations.of(context)!.create_account_title),
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
                        hintText: AppLocalizations.of(context)!.name_hint,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .name_is_empty_error;
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomTextField(
                        hintText: AppLocalizations.of(context)!.email_hint,
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value ?? "");
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .email_is_empty_error;
                          } else if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .email_is_not_valid_error;
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomTextField(
                        hintText: AppLocalizations.of(context)!.password_hint,
                        controller: passwordController,
                        inputType: TextInputType.number,
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .password_is_empty_error;
                          } else if (value.length < 6) {
                            return AppLocalizations.of(context)!
                                .password_length_error;
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CustomTextField(
                        hintText:
                            AppLocalizations.of(context)!.confirm_password_hint,
                        controller: confirmPasswordController,
                        inputType: TextInputType.number,
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .confirm_password_is_empty_error;
                          } else if (value.length < 6) {
                            return AppLocalizations.of(context)!
                                .password_length_error;
                          } else if (value != passwordController.text) {
                            return AppLocalizations.of(context)!
                                .confirm_password_is_not_match_password_error;
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
                        child: Text(AppLocalizations.of(context)!
                            .create_account_button)),
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
      DialogUtils.showLoader(
          context: context,
          message: AppLocalizations.of(context)!.loading_message);
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

        AuthUserProvider authUserProvider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authUserProvider.updateUser(user);

        DialogUtils.hideLoader(context);
        DialogUtils.showMessage(
            context: context,
            title: AppLocalizations.of(context)!.success_title,
            message: AppLocalizations.of(context)!.register_success_message,
            posActionName: AppLocalizations.of(context)!.ok_button,
            posAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.screenName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoader(context);
          DialogUtils.showMessage(
            context: context,
            title: AppLocalizations.of(context)!.error_title,
            message: AppLocalizations.of(context)!.weak_password_error,
            posActionName: AppLocalizations.of(context)!.ok_button,
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoader(context);
          DialogUtils.showMessage(
            context: context,
            title: AppLocalizations.of(context)!.error_title,
            message: AppLocalizations.of(context)!.email_already_exist,
            posActionName: AppLocalizations.of(context)!.ok_button,
          );
        }
      } catch (e) {
        print(e);
        DialogUtils.hideLoader(context);
        DialogUtils.showMessage(
          context: context,
          title: AppLocalizations.of(context)!.error_title,
          message: e.toString(),
          posActionName: AppLocalizations.of(context)!.ok_button,
        );
      }
    }
  }
}
