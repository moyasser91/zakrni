class DataTask{
  static const String collectionName= "tasks";

  String id ;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  DataTask({
    this.id = '' ,
    required this.title ,
    required this.description ,
    required this.dateTime ,
    this.isDone = false}) ;


  // Task.fromFirestoreJson(Map<String,dynamic> data){
  //   id = data['id'];
  //   title = data['title'];
  //   description = data['description'];
  //   dateTime = data['dataTime'];
  //   isDone = data['isDone'];
  // }

  DataTask.fromFirestoreJson(Map<String,dynamic> data):this(
      id : data['id'],
      title : data['title'],
      description : data['description'] ,
      dateTime : DateTime.fromMillisecondsSinceEpoch(data['dataTime']),
      isDone : data['isDone'],
  );

  //function to convert object to json
  Map<String,dynamic>toFirestoreJson(){
    return {
      'id':id,
      'title':title,
      'description':description,
      'dataTime':dateTime.millisecondsSinceEpoch,///epoctime yenf3 a3mel ai operation 3la el rakam ali rage3
      "isDone":isDone
    };
  }



  }

