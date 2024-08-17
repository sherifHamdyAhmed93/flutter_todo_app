import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/login/custom_text_field.dart';
import 'package:flutter_todo_app/login/signup_screen.dart';
import 'package:flutter_todo_app/model/user.dart';
import 'package:flutter_todo_app/provider/app_theme_provider.dart';
import 'package:flutter_todo_app/provider/authUserProvider.dart';
import 'package:flutter_todo_app/utils/alert_dialog.dart';
import 'package:flutter_todo_app/utils/lang_translater.dart';
import 'package:flutter_todo_app/view_model/login_navigator.dart';
import 'package:flutter_todo_app/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static String screenName = "login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  late LoginViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = LoginViewModel(loginNavigator: this);
  }

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
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
              title: Text(AppLocalizations.of(context)!.login_title),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              key: viewModel.globalKeys,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.28),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        AppLocalizations.of(context)!.welcome_back,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomTextField(
                          hintText: AppLocalizations.of(context)!.email_hint,
                          controller: viewModel.emailController,
                          inputType: TextInputType.emailAddress,
                          validator: (value) => KeyTranslator.translate(
                              context, viewModel.validateEmail())),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomTextField(
                          hintText: AppLocalizations.of(context)!.password_hint,
                          controller: viewModel.passwordController,
                          inputType: TextInputType.number,
                          obscure: true,
                          validator: (value) => KeyTranslator.translate(
                              context, viewModel.validatePassword())),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: viewModel.login,
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20)),
                          child: Text(AppLocalizations.of(context)!
                              .login_button_title)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignupScreen.screenName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.or_create_account,
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
      ),
    );
  }

  @override
  void showLoader() {
    // TODO: implement showLoader
    DialogUtils.showLoader(
        context: context,
        message: AppLocalizations.of(context)!.loading_message);
  }

  @override
  void hideLoader() {
    DialogUtils.hideLoader(context);
  }

  @override
  void showError(String key) {
    // TODO: implement showError
    DialogUtils.showMessage(
      context: context,
      title: AppLocalizations.of(context)!.error_title,
      message: KeyTranslator.translate(context, key) ?? key,
      posActionName: AppLocalizations.of(context)!.ok_button,
    );
  }

  @override
  void showSuccessMessageAndNavigateToHome(MyUser user) {
    DialogUtils.showMessage(
        context: context,
        title: AppLocalizations.of(context)!.success_title,
        message: AppLocalizations.of(context)!.login_success_message,
        posActionName: AppLocalizations.of(context)!.ok_button,
        posAction: () {
          AuthUserProvider authUserProvider =
              Provider.of<AuthUserProvider>(context, listen: false);
          authUserProvider.updateUser(user);
          Navigator.pushReplacementNamed(context, HomeScreen.screenName);
        });
  }
}
