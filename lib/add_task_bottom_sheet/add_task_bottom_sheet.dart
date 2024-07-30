import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/firestore/firebase_utils.dart';
import 'package:flutter_todo_app/provider/task_provider.dart';
import 'package:provider/provider.dart';

import '../model/task.dart';
import '../provider/app_theme_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  Task? task;
  late TaskProvider taskProvider;

  var keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    taskProvider = Provider.of<TaskProvider>(context);
    if (task == null) {
      task = ModalRoute.of(context)?.settings.arguments as Task?;
      if (task == null) {
        task = Task(title: '', desc: '', dateTime: DateTime.now());
      }
    }
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: themeProvider.getContainerBackground(),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Text(
                  task!.id.isEmpty
                      ? AppLocalizations.of(context)!.add_new_task
                      : AppLocalizations.of(context)!.edit_task,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                          initialValue: task?.title,
                          onChanged: (value) {
                            task?.title = value;
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
                            task?.desc = value;
                          },
                          initialValue: task?.desc,
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
                              '${task!.dateTime.day} / ${task!.dateTime.month} / ${task!.dateTime.year}',
                              style: Theme.of(context).textTheme.caption,
                            ))
                      ],
                    )),
              ],
            ),
            Visibility(
              visible: task?.isDone == false,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10)),
                  onPressed: didTapOnAddTask,
                  child: Text(
                    task!.id.isEmpty
                        ? AppLocalizations.of(context)!.add_task_button_title
                        : AppLocalizations.of(context)!.edit_task_button_title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppColors.whiteColor),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void showTimePicker() async {
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: task?.dateTime ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    task?.dateTime = selectedDate ?? task!.dateTime;

    setState(() {});
  }

  void didTapOnAddTask() {
    if (keys.currentState?.validate() == true) {
      if (task!.id.isEmpty) {
        _addNewTask();
      } else {
        updateTask();
      }
    }
  }

  void updateTask() {
    taskProvider.updateTaskFromFirebase(task!).timeout(Duration(seconds: 1),
        onTimeout: () {
      print('Task updated Successfully');
      taskProvider.getAllTasks();
      Navigator.pop(context);
    });
  }

  void _addNewTask() {
    FirebaseUtils.addTaskToFirebase(task!).timeout(Duration(seconds: 1),
        onTimeout: () {
      print('Task added successfully');
      taskProvider.getAllTasks();
      Navigator.pop(context);
    });
  }
}
