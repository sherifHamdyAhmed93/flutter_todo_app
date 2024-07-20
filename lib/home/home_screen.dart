import 'package:flutter/material.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:flutter_todo_app/settings_screen/settings_screen.dart';
import 'package:flutter_todo_app/tasks_screen/tasks_screen.dart';

import '../add_task_bottom_sheet/add_task_bottom_sheet.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),centerTitle: false,
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
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
            BottomNavigationBarItem(icon: Icon(Icons.list,size: 30,),label: 'Tasks' ),
            BottomNavigationBarItem(icon: Icon(Icons.settings,size: 30,),label: 'Settings' ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: didTapOnFloatingActionButton,
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

  void didTapOnFloatingActionButton() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddTaskBottomSheet();
        });
  }
}
