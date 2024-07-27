import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';
import '../provider/app_theme_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime _selectedDateTime = DateTime.now();
  String _title = '';
  String _desc = '';

  var keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    Task? task = ModalRoute.of(context)?.settings.arguments as Task?;

    return Container(
      decoration: BoxDecoration(
          color: themeProvider.getContainerBackground(),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text(
                task == null
                    ? AppLocalizations.of(context)!.add_new_task
                    : AppLocalizations.of(context)!.edit_task,
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
                        onChanged: (value) {
                          _title = value;
                        },
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .enter_your_task_hint,
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeProvider
                                        .getUnderLineBorderColor())),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeProvider
                                        .getUnderLineBorderColor()))),
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
                        onChanged: (value) {
                          _desc = value;
                        },
                        maxLines: 4,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .enter_task_description_hint,
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeProvider
                                        .getUnderLineBorderColor())),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: themeProvider
                                        .getUnderLineBorderColor()))),
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
                task == null
                    ? AppLocalizations.of(context)!.add_task_button_title
                    : AppLocalizations.of(context)!.edit_task_button_title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.whiteColor),
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
    if (keys.currentState?.validate() == true) {
      Task task = Task(title: _title, desc: _desc, dateTime: _selectedDateTime);
      FirebaseUtils.addTaskToFirebase(task).timeout(Duration(seconds: 1),
          onTimeout: () {
        print('Task added successfully');
        Navigator.pop(context);
      });
    }
  }
}
