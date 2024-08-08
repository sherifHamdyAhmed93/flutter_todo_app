import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';

class DialogUtils {
  static void showLoader(
      {required BuildContext context, required String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.blackColor),
                  ),
                )
              ],
            ),
          );
        });
  }

  static void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      String title = '',
      required String message,
      String? posActionName,
      Function? posAction,
      String? cancelActionName,
      Function? cancelAction}) {
    List<Widget> actions = [];

    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)));
    }

    if (cancelActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            cancelAction?.call();
          },
          child: Text(cancelActionName)));
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.blackColor),
            ),
            content: Text(message),
            actions: actions,
          );
        });
  }
}
