import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:zakrni/Logic/custom_function.dart';
import 'package:zakrni/constance/my_theme.dart';
import 'package:zakrni/screen/Add_screen/add_screen.dart';
import 'package:zakrni/screen/Task/tasks_list_screens.dart';
import 'package:zakrni/screen/setting/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home" ;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selctedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Zakrni",style:Theme.of(context).textTheme.titleLarge,),
        toolbarHeight: MediaQuery.of(context).size.height*.09,
        titleSpacing: 20,
      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        index: selctedIndex,
        items: [
          CurvedNavigationBarItem(child : Icon(Icons.view_agenda_outlined,color: CustomFunction.buttoncolor(0, selctedIndex),),label:"List" ),
          CurvedNavigationBarItem(child : Icon(Icons.add,color: CustomFunction.buttoncolor(1,selctedIndex)),label:"Add" ),
          CurvedNavigationBarItem(child : Icon(Icons.settings,color: CustomFunction.buttoncolor(2,selctedIndex)),label:"Setting" ),
        ],
        onTap: (value) {
          selctedIndex = value ;
          setState(() {

          });
        },
      ),

      body:CustomFunction.screenTabs?[selctedIndex]
    );
  }




}
