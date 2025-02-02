import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/constance/my_theme.dart';
import 'package:zakrni/provider/list_provider.dart';
import 'package:zakrni/provider/user_provider.dart';
import 'package:zakrni/screen/Task/task_Item.dart';


import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/constance/my_theme.dart';
import 'package:zakrni/provider/list_provider.dart';
import 'package:zakrni/provider/user_provider.dart';
import 'package:zakrni/screen/Task/task_Item.dart';

import '../../provider/appLocalization.dart';

class TasksListScreens extends StatefulWidget {
  @override
  State<TasksListScreens> createState() => _TasksListScreensState();
}

class _TasksListScreensState extends State<TasksListScreens> {
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLocalization>(context);
    var listProvider = Provider.of<ListProvider?>(context);
    var userProvider = Provider.of<UserProvider?>(context);

    // إذا كانت القائمة فارغة، نقوم بتحميل المهام من Firestore
    if (listProvider!.taskList.isEmpty) {
      listProvider.getAllTaskFromFirestore(userProvider!.updateUserModel!.useriid!);
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 52,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
            EasyDateTimeLine(
              initialDate: listProvider.selectedDateByUserFromCalenderShow,
              onDateChange: (selectedDate) {
                listProvider.selectedDateByUserFromCalenderShow = selectedDate;
                listProvider.getAllTaskFromFirestore(userProvider!.updateUserModel!.useriid!);
              },
              activeColor: const Color(0xffcaaf89), // 0xffd9e4a7
              headerProps: EasyHeaderProps(showSelectedDate: false, showHeader: false),
              dayProps: const EasyDayProps(
                landScapeMode: false,
                borderColor: Colors.white54,
                dayStructure: DayStructure.dayNumDayStr,
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: Color(0xffd3b963), // 0xffb3c193
                height: 100,
              ),
            ),
          ],
        ),
        Expanded(
          child: listProvider.taskList.isEmpty
          // عرض رسالة إذا كانت القائمة فارغة
              ? Center(
            child: Text("لم تقم بأضافه مهامات في هذا اليوم",

              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
            ),
          )
          // عرض العناصر من القائمة إذا كانت تحتوي على مهام
              : ListView.builder(
            itemBuilder: (context, index) => TaskItem(dataTask: listProvider.taskList[index]),
            itemCount: listProvider.taskList.length,
          ),
        ),
      ],
    );
  }
}

//initialDate: listProvider.selectedDateByUserFromCalenderShow,
//             onDateChange: (selectedDate) /// call back function
//             {
//               //`selectedDate` the new date selected.
//               listProvider.selectedDateByUserFromCalenderShow = selectedDate ;
//               listProvider.getAllTaskFromFirestore(userProvider.updateUserModel!.useriid!);
//
//             },
