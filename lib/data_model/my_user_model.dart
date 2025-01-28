 class MyUserModel{

  static const collectionNameUser  ='users';

   String? useriid ;
   String? name ;
   String? email;
   String? password ;


   MyUserModel({
     required this.useriid ,
     required this.name ,
     required this.email ,
     required this.password}) ;


   MyUserModel.fromFirestorejson(Map<String,dynamic> data):this(
     useriid: data['useriid'],
     name: data['name'],
     email: data['email'],
     password: data['password'],

   ) ;


    Map<String,dynamic> toFirestoreJson()
   {
     return{
       "useriid" : useriid,
       "name" : name ,
       "email" :email,
       "password":password
     };
   }
 }