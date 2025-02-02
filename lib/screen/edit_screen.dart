import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/Logic/firebase/firebase_function.dart';
import 'package:zakrni/data_model/data_task.dart';
import 'package:zakrni/provider/list_provider.dart';
import '../constance/my_color.dart';
import '../provider/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "edit";
  DataTask dataTaskEdit ;
  EditScreen({required this.dataTaskEdit});
  late DateTime selectedDateByUser ;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late String idEdit;
  late String titleEdit;
  late String descEdit;
  late DateTime dataSelectedEdit;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late ListProvider listProvider ;
  late UserProvider userProvider ;

  @override
  void initState() {
    super.initState();
    // idEdit = widget.dataTaskEdit.id ;
    titleEdit = widget.dataTaskEdit.title;
    descEdit = widget.dataTaskEdit.description ;
    dataSelectedEdit = widget.dataTaskEdit.dateTime ;

    titleController.text = titleEdit ;
    descriptionController.text = descEdit ;
  }

   void updateTask()async{
    DataTask dataTask = DataTask(
      id: widget.dataTaskEdit.id,
        title: titleEdit,
        description: descEdit,
        dateTime: dataSelectedEdit );

    await FirebaseFunction.upDateTask(dataTask,userProvider.updateUserModel!.useriid!);
    listProvider.getAllTaskFromFirestore(userProvider.updateUserModel!.useriid!);
    setState(() {

    });

  }

  void showCalender()async {
    var chosenUserDateSelected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 20000)),

    );
    dataSelectedEdit = chosenUserDateSelected ?? dataSelectedEdit;
    setState(() {

    });}

    @override
    Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:
          Image.asset('assets/images/appbar.png',width: 115,height: 42,fit: BoxFit.fill,),
          toolbarHeight: MediaQuery
              .of(context)
              .size
              .height * .09,
          titleSpacing: 20,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Center(child: Text(AppLocalizations.of(context)!.editTask, style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,)),
                SizedBox(height: 40,),
                Form(
                    child: Column(children: [
                      TextFormField(
                        controller: titleController,
                        onChanged: (textValue) {
                          titleEdit = textValue;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 2,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.title,
                          labelStyle: Theme
                              .of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.grey.shade600,
                              fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.black,), // تحديد لون الحافة
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Theme
                                .of(context)
                                .primaryColor, width: 2), // تأثير عند التركيز
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade600,
                                width: 1.2), // تأثير عند التفاعل
                          ),
                        ),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 25,),
                      TextFormField(

                        ///description
                        controller: descriptionController,
                        onChanged: (textValue) {
                          descEdit = textValue;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 3,

                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.description,
                          labelStyle: Theme
                              .of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.grey.shade600,
                              fontSize: 18),
                          border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.black,), // تحديد لون الحافة
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Theme
                                .of(context)
                                .primaryColor, width: 2), // تأثير عند التركيز
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade600,
                                width: 1.2), // تأثير عند التفاعل
                          ),
                        ),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 17),
                      ),
                      SizedBox(height: 25,),
                      InkWell(
                        onTap: () {
                          showCalender();
                          setState(() {

                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!.selectDate, style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 19,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.normal),),
                            Text('${dataSelectedEdit.day} / ${dataSelectedEdit
                                .month} / ${dataSelectedEdit.year}',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                    fontSize: 19, color: Colors.grey.shade800)),
                          ],),
                      ),
                      SizedBox(height: 25,),
                      InkWell(
                        onTap: () {
                          updateTask();
                         listProvider.getAllTaskFromFirestore(userProvider.updateUserModel!.useriid!);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(AppLocalizations.of(context)!.taskUpdatedSuccessfully) ));
                          setState(() {

                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xffaf9264),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(child: Text(AppLocalizations.of(context)!.updateTask, style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                              color: MyColorApp.whiteColor, fontSize: 22),)),
                        ),
                      )


                    ],))
              ],),
          ),
        ),
      );
    }
  }

