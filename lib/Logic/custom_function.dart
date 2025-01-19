import 'package:flutter/material.dart';

import '../screen/Add_screen/add_screen.dart';
import '../screen/Task/tasks_list_screens.dart';
import '../screen/setting/settings_screen.dart';

class CustomFunction{

  /// change color
  static Color buttoncolor(int index, int selectedIndex) {
    if (index == selectedIndex) {
      return Colors.white;
    } else {
      return Colors.grey.shade600;
    }}

  //**************************************************************

  static List<Widget>?screenTabs=
  [ TasksListScreens(), AddScreen(), SettingsScreen(), ];
}