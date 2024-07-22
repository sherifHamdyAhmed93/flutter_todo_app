import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/edit_task_screen/edit_task_screen.dart';
import 'package:flutter_todo_app/model/task.dart';
import 'package:provider/provider.dart';

import '../provider/app_theme_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditTaskScreen.screenName,
            arguments:
                Task(taskName: "", taskDesc: "", taskTime: DateTime.now()));
      },
      child: Container(
        margin: EdgeInsets.all(10),
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
                    'Play basket ball',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Play basket ball',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            Container(
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
          ],
        ),
      ),
    );
  }
}
