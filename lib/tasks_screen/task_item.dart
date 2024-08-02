import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/edit_task_screen/edit_task_screen.dart';
import 'package:flutter_todo_app/model/task.dart';
import 'package:flutter_todo_app/provider/task_provider.dart';
import 'package:provider/provider.dart';

import '../provider/app_theme_provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.task});

  Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late TaskProvider taskProvider;

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    taskProvider = Provider.of<TaskProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EditTaskScreen.screenName, arguments: widget.task);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Slidable(
          // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                borderRadius: BorderRadius.circular(10),
                onPressed: didTapOnDelete,
                backgroundColor: AppColors.redColor,
                foregroundColor: AppColors.whiteColor,
                icon: Icons.delete,
                label: 'Delete',
              ),
              // SlidableAction(
              //   onPressed: doNothing,
              //   backgroundColor: Color(0xFF21B7CA),
              //   foregroundColor: Colors.white,
              //   icon: Icons.share,
              //   label: 'Share',
              // ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          // endActionPane: const ActionPane(
          //   motion: ScrollMotion(),
          //   children: [
          //     SlidableAction(
          //       // An action can be bigger than the others.
          //       flex: 2,
          //       onPressed: doNothing,
          //       backgroundColor: Color(0xFF7BC043),
          //       foregroundColor: Colors.white,
          //       icon: Icons.archive,
          //       label: 'Archive',
          //     ),
          //     SlidableAction(
          //       onPressed: doNothing,
          //       backgroundColor: Color(0xFF0392CF),
          //       foregroundColor: Colors.white,
          //       icon: Icons.save,
          //       label: 'Save',
          //     ),
          //   ],
          // ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: Container(
            // margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(8),
            // height: 100,
            decoration: BoxDecoration(
                color: themeProvider.getContainerBackground(),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(left: 10),
                  height: 80,
                  width: 4,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: widget.task.isDone
                                    ? AppColors.greenColor
                                    : AppColors.primaryColor),
                      ),
                      Text(
                        widget.task.desc,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                buildDoneOrCheckButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void didTapOnDelete(BuildContext context) {
    taskProvider.deleteTaskFromFirebase(widget.task);
  }

  void didTapOnDone() {
    widget.task.isDone = true;
    taskProvider
        .updateTaskFromFirebase(widget.task)
        .timeout(Duration(seconds: 1), onTimeout: () {
      print('Task is  done');
      setState(() {});
    });
  }

  Widget buildDoneOrCheckButton() {
    return widget.task.isDone
        ? Text(
            'Done!',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.greenColor),
          )
        : ElevatedButton(
            onPressed: didTapOnDone,
            child: Icon(
              Icons.check,
              color: AppColors.whiteColor,
              size: 30,
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          );
  }
}

/*
*  Container(
                  child: Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
                    size: 30,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                )
* */