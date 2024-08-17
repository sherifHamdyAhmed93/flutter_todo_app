import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/provider/app_theme_provider.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      this.inputType = TextInputType.name,
      required this.validator,
      this.obscure = false,
      required this.controller});

  String hintText;
  TextInputType inputType;
  String? Function(String?) validator;
  bool obscure;

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      keyboardType: inputType,
      decoration: InputDecoration(
          filled: true,
          fillColor: themeProvider.getFieldBackgroundColor(),
          labelText: hintText,
          labelStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: themeProvider.isCurrentAppThemeLight()
                  ? AppColors.hintColor
                  : AppColors.hintDarkColor),
          errorStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.redColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }
}
