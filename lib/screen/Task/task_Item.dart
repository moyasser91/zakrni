import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/Logic/firebase/firebase_function.dart';
import 'package:zakrni/constance/my_color.dart';
import 'package:zakrni/data_model/data_task.dart';
import 'package:zakrni/provider/list_provider.dart';
import 'package:zakrni/provider/user_provider.dart';
import 'package:zakrni/screen/edit_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TaskItem extends StatefulWidget {
  TaskItem({required this.dataTask});
  DataTask dataTask ;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(

    // // Specify a key if the Slidable is dismissible.
    // key: const ValueKey(1),

    // The start action pane is the one at the left or the top side.
    startActionPane: ActionPane(
      extentRatio: .40,
    // A motion is a widget used to control how the pane animates.
    motion: const ScrollMotion(),

    // A pane can dismiss the Slidable.
    // dismissible: DismissiblePane(onDismissed: () {}),

    // All actions are defined in the children parameter.
    children:  [
    // A SlidableAction can have an icon and/or a label.
    SlidableAction(

    onPressed: (context) {
      FirebaseFunction.deleteTaskFromfireStore(widget.dataTask,userProvider.updateUserModel!.useriid!).
      then((value) {
        listProvider.getAllTaskFromFirestore(userProvider.updateUserModel!.useriid!);
      },).
      timeout(Duration(seconds: 1),
          onTimeout:() {
            listProvider.getAllTaskFromFirestore(userProvider.updateUserModel!.useriid!);
          },
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(AppLocalizations.of(context)!.deleteSucsuss) ));
    },
    backgroundColor: Color(0xFFFE4A49),
    foregroundColor: Colors.white,
    icon: Icons.delete,
      borderRadius: BorderRadius.circular(16),
    label: 'Delete',
    ),
    ],),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.4,color:widget.dataTask.isDone==true?MyColorApp.colorIsDone:Colors.grey,
          ),
              color:Color(0xfff3f3f3),
              borderRadius: BorderRadius.circular(15)
            ),
          width: double.infinity,
          height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color:widget.dataTask.isDone==true?MyColorApp.colorIsDone:Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    width: 5,height: 105,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditScreen(dataTaskEdit: widget.dataTask),));
                      },
                      child: Column(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(widget.dataTask.title,style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 23,                      color:widget.dataTask.isDone==true?MyColorApp.colorIsDone:Theme.of(context).primaryColor,
                        ),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        Text(widget.dataTask.description,style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16,color: Colors.grey.shade800),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      ],),
                    ),
                  ),
                ),
                Container(

                  decoration: BoxDecoration(
                      color:widget.dataTask.isDone==true?MyColorApp.colorIsDone:Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  width:  widget.dataTask.isDone==true?90:50
                  ,height: 31,
                  child: InkWell(
                    onTap: () {
                      widget.dataTask.isDone = true ;
                      FirebaseFunction.upDateTask(widget.dataTask , userProvider.updateUserModel!.useriid!);
                      setState(() {

                      });
                    },
                      child: widget.dataTask.isDone==true?Center(child: Text(AppLocalizations.of(context)!.isDone,style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),)):Icon(Icons.check,color: Colors.white,size: 25,)),
                ),
              ],),
            ),
          ),
        ),
    );
  }


}


