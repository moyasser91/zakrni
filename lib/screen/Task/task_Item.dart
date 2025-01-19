import 'package:flutter/material.dart';
import 'package:zakrni/screen/Add_screen/add_screen.dart';

class TaskItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.4,color: Colors.grey),
          color:Color(0xffefefef),
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
                    color:Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15)
                ),
                width: 5,height: 105,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Title",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 23,color:Colors.brown),),
                  Text("Desciption task",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16,color: Colors.grey.shade800),),
                ],),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color:Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)
              ),
              width: 50,height: 31,
              child: Icon(Icons.check,color: Colors.white,size: 25,),
            ),
          ],),
        ),
      ),
    );
  }
}
