import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../provider/app_theme_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime _selectedDateTime = DateTime.now();
  var keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text(
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium?.copyWith(
                    color: themeProvider.isCurrentAppThemeLight()
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
              ),
              Form(
                  key: keys,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .enter_your_task_hint,
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_task_name_error;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 4,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .enter_task_description_hint,
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_task_desc_error;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.select_time,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                          onPressed: showTimePicker,
                          child: Text(
                            '${_selectedDateTime.day} / ${_selectedDateTime.month} / ${_selectedDateTime.year}',
                            style: Theme.of(context).textTheme.caption,
                          ))
                    ],
                  )),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10)),
              onPressed: didTapOnAddTask,
              child: Text(
                AppLocalizations.of(context)!.add_task_button_title,
                style: Theme.of(context).textTheme.titleLarge,
              ))
        ],
      ),
    );
  }

  void showTimePicker() async {
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    _selectedDateTime = selectedDate ?? _selectedDateTime;
    setState(() {});
  }

  void didTapOnAddTask() {
    if (keys.currentState?.validate() == true) {}
  }
}
