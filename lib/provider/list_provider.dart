import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Logic/firebase/firebase_function.dart';
import '../data_model/data_task.dart';

class ListProvider extends ChangeNotifier{
  int counter = 0 ;
  List<DataTask> taskList = [] ;
  DateTime selectedDateByUserFromCalenderShow = DateTime.now();


  void getAllTaskFromFirestore(String userId)async {
    QuerySnapshot<DataTask> querySnapshotGet = await FirebaseFunction.getTasksCollection(userId)!.get();
    ///get All Task
    taskList = querySnapshotGet.docs.map((doc){
      return doc.data();
    }).toList();

    ///Fillltring ALl task SelctDate
      taskList =  taskList.where((taskDate){
      if(selectedDateByUserFromCalenderShow.day==taskDate.dateTime.day &&
          selectedDateByUserFromCalenderShow.month==taskDate.dateTime.month&&
          selectedDateByUserFromCalenderShow.year==taskDate.dateTime.year ){
        return true ;
      }
      return false ;
    }).toList();

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .orderBy('age', descending: true)
    //     .get()
    //     .then(...);

      ///sorting tasks
    taskList.sort((DataTask dataTask1 , DataTask dataTask2){
      return dataTask2.dateTime.compareTo(dataTask1.dateTime);
    });



    notifyListeners();
  }




  // void getAllTaskFromFirestoreNotFiltter()async {
  //   QuerySnapshot<DataTask> querySnapshotGet = await FirebaseFunction.getTasksCollection()!.get();
  //   taskList = querySnapshotGet.docs.map((doc){
  //     return doc.data();
  //   }).toList();
  //
  //   notifyListeners();
  // }


}