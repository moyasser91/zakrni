import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:zakrni/constance/my_theme.dart';
import 'package:zakrni/screen/Task/task_Item.dart';

class TasksListScreens extends StatelessWidget {
  const TasksListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
            height: 110,
            width:double.infinity,
            color: MyThemeData.lightTheme.primaryColor,),
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) /// call back function
            {
              //`selectedDate` the new date selected.
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.dropDown,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNumMonth,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffbdbd7a),
                     // Color(0xff15776e),
                      Color(0xffa39854),
                    ],
                  ),
                ),
              ),

            ),
          )

        ],),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => TaskItem(),
            itemCount: 8,


          ),
        )
      ],
    );
  }
}
