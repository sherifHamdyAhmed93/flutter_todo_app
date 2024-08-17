import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/components/custom_text_field.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/model/user.dart';
import 'package:flutter_todo_app/provider/app_theme_provider.dart';
import 'package:flutter_todo_app/provider/authUserProvider.dart';
import 'package:flutter_todo_app/register/register_view_model/register_navigator.dart';
import 'package:flutter_todo_app/register/register_view_model/register_view_model.dart';
import 'package:flutter_todo_app/utils/alert_dialog.dart';
import 'package:flutter_todo_app/utils/lang_translater.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  static String screenName = "signup_screen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    implements RegisterNavigator {
  late RegisterViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = RegisterViewModel(registerNavigator: this);
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
              title: Text(AppLocalizations.of(context)!.create_account_title),
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
                      child: CustomTextField(
                          hintText: AppLocalizations.of(context)!.name_hint,
                          controller: viewModel.nameController,
                          validator: (value) => KeyTranslator.translate(
                              context, viewModel.validateName())),
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
                      child: CustomTextField(
                          hintText: AppLocalizations.of(context)!
                              .confirm_password_hint,
                          controller: viewModel.confirmPasswordController,
                          inputType: TextInputType.number,
                          obscure: true,
                          validator: (value) => KeyTranslator.translate(
                              context, viewModel.validateConfirmPassword())),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: viewModel.register,
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
        message: AppLocalizations.of(context)!.register_success_message,
        posActionName: AppLocalizations.of(context)!.ok_button,
        posAction: () {
          AuthUserProvider authUserProvider =
              Provider.of<AuthUserProvider>(context, listen: false);
          authUserProvider.updateUser(user);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.screenName, (Route<dynamic> route) => false);
        });
  }
}
