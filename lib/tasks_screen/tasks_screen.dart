import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../provider/app_language_provider.dart';
import '../provider/app_theme_provider.dart';
import 'task_item.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLanguageProvider languageProvider =
        Provider.of<AppLanguageProvider>(context);
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            activeColor: AppColors.primaryColor,
            locale: languageProvider.currentAppLanguage,
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            headerProps: EasyHeaderProps(
              selectedDateStyle: Theme.of(context).textTheme.bodyLarge,
              monthStyle: Theme.of(context).textTheme.bodyLarge,
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              disabledDayStyle: DayStyle(
                dayStrStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: themeProvider.isCurrentAppThemeLight()
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
                dayNumStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: themeProvider.isCurrentAppThemeLight()
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
                monthStrStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: themeProvider.isCurrentAppThemeLight()
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
                decoration: BoxDecoration(
                  color: themeProvider.isCurrentAppThemeLight()
                      ? AppColors.cardBackgroundLightColor
                      : AppColors.cardBackgroundDarkColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              inactiveDayStyle: DayStyle(
                dayStrStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: themeProvider.isCurrentAppThemeLight()
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
                dayNumStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: themeProvider.isCurrentAppThemeLight()
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
                monthStrStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: themeProvider.isCurrentAppThemeLight()
                        ? AppColors.blackColor
                        : AppColors.whiteColor),
                decoration: BoxDecoration(
                  color: themeProvider.isCurrentAppThemeLight()
                      ? AppColors.cardBackgroundLightColor
                      : AppColors.cardBackgroundDarkColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              activeDayStyle: DayStyle(
                dayStrStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.whiteColor),
                dayNumStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.whiteColor),
                monthStrStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.whiteColor),
                decoration: BoxDecoration(
                  color: themeProvider.isCurrentAppThemeLight()
                      ? AppColors.primaryColor
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskItem();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: 10),
          )
        ],
      ),
    );
  }
}
