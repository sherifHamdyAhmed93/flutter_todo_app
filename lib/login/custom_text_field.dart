import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';

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
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      keyboardType: inputType,
      decoration: InputDecoration(
          labelText: hintText,
          errorStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.redColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor))),
    );
  }
}
