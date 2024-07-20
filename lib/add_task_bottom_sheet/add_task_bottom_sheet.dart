import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text(
                'Add new Task',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.blackColor),
              ),
              Form(
                  key: keys,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            hintText: 'enter your task',
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter task name';
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
                            hintText: 'enter task description',
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter task desc';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select Time',
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
                'Add Task',
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
