import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zakrni/data_model/data_task.dart';
import 'package:zakrni/data_model/my_user_model.dart';

class FirebaseFunction{

  static CollectionReference<DataTask>? getTasksCollection(String userId){
    return getUsersCollection()?.doc(userId).collection(DataTask.collectionName).
    withConverter<DataTask>(
      fromFirestore: (snapshot, options) => DataTask.fromFirestoreJson(snapshot.data()!),
      toFirestore: (taskValue, options) => taskValue.toFirestoreJson(),);
  }

  ///el function de marbota b file dataTask عشان شايل البيانات
  static Future<void> addTaskToFirebase(DataTask dataTask , String userId) async {
    /// 1- إنشاء الـ Collection
    var taskCollection = getTasksCollection(userId);

    /// التحقق من أن الـ Collection موجود
    if (taskCollection == null) {
      throw Exception("taskCollection is null. Please check your Firestore configuration.");
    }

    /// 2- إنشاء document جديد داخل الـ Collection
    var taskDocReference = taskCollection.doc();

    /// التحقق من أن المرجع للمستند موجود
    if (taskDocReference == null) {
      throw Exception("Failed to create a document reference.");
    }

    /// 3- حفظ auto id داخل id الكلاس
    dataTask.id = taskDocReference.id;

    /// 4- رفع البيانات إلى Firestore
    await taskDocReference.set(dataTask);

    // print("Task added successfully with ID: ${dataTask.id}");
  }

  static Future<void> deleteTaskFromfireStore(DataTask dataTask,String userId)
  {
   return  getTasksCollection(userId)!.doc(dataTask.id).delete();
  }

  static Future<void> upDateTask(DataTask dataTask,String userId){
    return getTasksCollection(userId)!.doc(dataTask.id).update({
      'title': dataTask.title,
      'description': dataTask.description,
      'dateTime': dataTask.dateTime.toIso8601String(),
      'isDone':dataTask.isDone,
    });

  }
  
  
  static CollectionReference<MyUserModel>? getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUserModel.collectionNameUser).withConverter<MyUserModel>(
    fromFirestore: (snapshot, options) => MyUserModel.fromFirestorejson(snapshot.data()!),
    toFirestore: (myUser, options) =>  myUser.toFirestoreJson(),);
  }

  static Future<void>? addUserToFirestore(MyUserModel myUserModel)async{
   return await getUsersCollection()?.doc(myUserModel.useriid).set(myUserModel);
  }

  static Future<MyUserModel?> readUserFromFirestore(String userId )async{
  var querySnapshot = await getUsersCollection()?.doc(userId).get();
  return querySnapshot?.data() ;
  }


}