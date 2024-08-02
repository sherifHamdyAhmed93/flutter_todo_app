import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../add_task_bottom_sheet/add_task_bottom_sheet.dart';
import '../colors/app_colors.dart';
import '../provider/app_theme_provider.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  static const String screenName = 'edit_task_screen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.12,
            color: AppColors.primaryColor,
          ),
          Expanded(
            child: AddTaskBottomSheet(),
          )
        ],
      ),
    );
  }
}
