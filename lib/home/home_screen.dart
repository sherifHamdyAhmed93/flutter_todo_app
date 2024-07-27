import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/tasks_screen/tasks_screen.dart';
import 'package:provider/provider.dart';

import '../add_task_bottom_sheet/add_task_bottom_sheet.dart';
import '../provider/app_theme_provider.dart';
import '../settings/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  static const String screenName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? AppLocalizations.of(context)!.tasks_tab
              : AppLocalizations.of(context)!.settings_tab,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: themeProvider.getNavBarBackgrounnd(),
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        elevation: 0,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index){
            _selectedIndex = index;
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                label: AppLocalizations.of(context)!.tasks_tab),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 30,
                ),
                label: AppLocalizations.of(context)!.settings_tab),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          didTapOnFloatingActionButton(themeProvider);
        },
        child: Icon(Icons.add,size: 35,color: AppColors.whiteColor,),
      ),
      body:Column(
        children: [
        Container(height: height*0.12,color: AppColors.primaryColor,),
          Expanded(child: _selectedIndex == 0 ? TasksScreen() : SettingsScreen())
        ],
      ),
    );
  }

  void didTapOnFloatingActionButton(AppThemeProvider themeProvider) {
    showModalBottomSheet(
        backgroundColor: themeProvider.getContainerBackground(),
        context: context,
        builder: (context) {
          return AddTaskBottomSheet();
        });
  }
}
