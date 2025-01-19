import 'package:flutter/material.dart';
import 'package:zakrni/constance/my_color.dart';

class AddScreen extends StatefulWidget {

   AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var formKey = GlobalKey<FormState>();
  static var selectedDateByUser = DateTime.now();
  static final TextEditingController controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
        SizedBox(height: 10,),
        Center(child: Text("Add a New Task",style: Theme.of(context).textTheme.titleMedium,)),
        SizedBox(height: 40,),
        Form(
          key: formKey,
            child: Column(children: [
              TextFormField(
                validator: (text) {
                  if(text == null || text.isEmpty)
                    {
                      return "please Enter Title text";
                    }
                  return null ;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 2,
                decoration: InputDecoration(
                  labelText: "Title",
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
              TextFormField(

                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                validator: (text) {
                  if(text == null || text.isEmpty)
                  {
                    return "please Enter Description text";
                  }
                  return null ;
                },
                decoration: InputDecoration(
                  labelText: "Description",
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
                  Text('Select Date',style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 19,color: Colors.grey.shade800,fontWeight: FontWeight.normal),),
                  Text('${selectedDateByUser.day} / ${selectedDateByUser.month} / ${selectedDateByUser.year}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 19,color: Colors.grey.shade800,fontWeight: FontWeight.normal),),
                ],),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: () {
                  addTask();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffaf9264),
                    borderRadius: BorderRadius.circular(12)                ),
                  child: Center(child: Text("Create Task",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyColorApp.whiteColor,fontSize: 22),)),
                ),
              )


            ],))
      ],),
    ),
  );
  }

  void addTask()
  {
    if(formKey.currentState?.validate()==true){
      //add task
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
