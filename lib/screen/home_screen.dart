import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/Logic/custom_function.dart';
import 'package:zakrni/provider/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/appLocalization.dart';
import '../provider/user_provider.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = "home" ;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selctedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLocalization>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          spacing: 7,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/appbar.png',width: 115,height: 40,fit: BoxFit.fill,),
         // Text(AppLocalizations.of(context)!.zakrni,style:Theme.of(context).textTheme.titleLarge,),
          Row(
            spacing :6,
            children: [
          //  Text("Welcome",style:Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 17),),
            Text("${userProvider.updateUserModel?.name??""}",style:Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15,color: Colors.white54),),
          ],)
],),
        actions: [
          ],
        toolbarHeight: MediaQuery.of(context).size.height*.12,
        titleSpacing: 10,

      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        index: selctedIndex,
        items: [
          CurvedNavigationBarItem(child : Icon(Icons.view_agenda_outlined,color: CustomFunction.buttoncolor(0, selctedIndex),),label:AppLocalizations.of(context)!.list ,labelStyle:Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontSize: 13) ),
          CurvedNavigationBarItem(child : Icon(Icons.add,color: CustomFunction.buttoncolor(1,selctedIndex)),label:AppLocalizations.of(context)!.add,labelStyle:Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontSize: 13)),
          CurvedNavigationBarItem(child : Icon(Icons.settings,color: CustomFunction.buttoncolor(2,selctedIndex)),label:AppLocalizations.of(context)!.setting,labelStyle:Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black,fontSize: 13)),
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
