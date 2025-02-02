import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/Logic/firebase/firebase_function.dart';
import 'package:zakrni/constance/my_color.dart';
import 'package:zakrni/data_model/data_task.dart';
import 'package:zakrni/provider/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/user_provider.dart';


class AddScreen extends StatefulWidget {

   AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var formKey = GlobalKey<FormState>();
  static var selectedDateByUser = DateTime.now();
  String titleUser = ''  ;
  String descriptionUser = ''  ;
late ListProvider listProvider ;
late UserProvider userProvider ;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
        SizedBox(height: 10,),
        Center(child: Text(AppLocalizations.of(context)!.addNewTask,style: Theme.of(context).textTheme.titleMedium,)),
        SizedBox(height: 40,),
        Form(
          key: formKey,
            child: Column(children: [
              TextFormField(
                onChanged: (textValue) {
                  titleUser = textValue ;
                },
                validator: (text) {
                  if(text == null || text.isEmpty)
                    {
                      return AppLocalizations.of(context)!.pleaseEnterTitleText;
                    }
                  return null ;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 2,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.title,
                  labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey.shade600,fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.black,), // تحديد لون الحافة
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2), // تأثير عند التركيز
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade600,width: 1.2), // تأثير عند التفاعل
                  ),
                ),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
              ),
              SizedBox(height: 25,),
              TextFormField( ///description
                onChanged: (textValue) {
                  descriptionUser = textValue ;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                validator: (text) {
                  if(text == null || text.isEmpty)
                  {
                    return AppLocalizations.of(context)!.pleaseEnterDescriptionText;
                  }
                  return null ;
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.description,
                  labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey.shade600,fontSize: 18),
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.black,), // تحديد لون الحافة
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2), // تأثير عند التركيز
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade600,width: 1.2), // تأثير عند التفاعل
                  ),
                ),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 17),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: () {
                  showCalender();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(AppLocalizations.of(context)!.selectDate,style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 19,color: Colors.grey.shade800,fontWeight: FontWeight.normal),),
                  Text('${selectedDateByUser.day} / ${selectedDateByUser.month} / ${selectedDateByUser.year}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 19,color: Colors.grey.shade800,fontWeight: FontWeight.normal),),
                ],),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: () {
                  addTaskAndCheckValidator();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(AppLocalizations.of(context)!.taskAddSuccessfully) ));

                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffaf9264),
                    borderRadius: BorderRadius.circular(12)                ),
                  child: Center(child: Text(AppLocalizations.of(context)!.createTask,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyColorApp.whiteColor,fontSize: 22),)),
                ),
              )


            ],))
      ],),
    ),
  );
  }

  void addTaskAndCheckValidator()
  {
    if(formKey.currentState?.validate()==true){
      DataTask dataTask = DataTask(
          title: titleUser,
          description: descriptionUser,
          dateTime: selectedDateByUser
      );
      FirebaseFunction.addTaskToFirebase(dataTask,userProvider.updateUserModel!.useriid!)
          .then(
        (value) {
          listProvider.getAllTaskFromFirestore(userProvider.updateUserModel!.useriid!);

        }).timeout(Duration(seconds: 2),onTimeout: () {
        listProvider.getAllTaskFromFirestore(userProvider.updateUserModel!.useriid!);
      },);

    }

  }

   void showCalender()async{
    var chosenUserDateSelected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 10000)),

    );
     selectedDateByUser = chosenUserDateSelected ?? selectedDateByUser ;
    setState(() {

    });
  }
}
