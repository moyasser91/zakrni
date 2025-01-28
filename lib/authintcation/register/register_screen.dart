import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/Logic/firebase/firebase_function.dart';
import 'package:zakrni/authintcation/login/login%20screen.dart';
import 'package:zakrni/authintcation/register/text_form.dart';
import 'package:zakrni/data_model/my_user_model.dart';
import 'package:zakrni/provider/user_provider.dart';
import '../../constance/my_color.dart';
import '../../screen/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register' ;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool isloadinggoogle = false ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*.06,),
              Text(AppLocalizations.of(context)!.register_new_acc,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black,fontSize: 24)),
              SizedBox(height:MediaQuery.of(context).size.height*.008,),
              Row(
                children: [
                  Container(
                    color: Colors.blue,
                    width: 90,
                    height: 3,
                  ),
                  SizedBox(width: 6,),
                  Container(
                    color: Colors.blue,
                    width: 11,
                    height: 3,
                  ),
                ],
              ),
             SizedBox(height:MediaQuery.of(context).size.height*.001,),
              Center(child: Image.asset('assets/images/loigin.png',width: 360,height: 160,fit: BoxFit.fill,)),
              SizedBox(height:MediaQuery.of(context).size.height*.01,),

              Form(
                  key: formKey ,
                  child: SingleChildScrollView(
                child: Column(
                  spacing: 18,
                  children: [
                  TextForm(
                    hint: AppLocalizations.of(context)!.name,
                    myController: nameController,
                    keyboardType: TextInputType.name,
                    validatorUser: (textValue) {
                      if(textValue == null || textValue.trim().isEmpty){
                        return "Please Enter Your Name" ;
                      }
                        return null ;
                    },),
                  TextForm(
                    hint: AppLocalizations.of(context)!.email,
                    myController: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validatorUser: (textValue) {
                      if(textValue == null || textValue.trim().isEmpty){
                        return "Please Enter Your Email" ;
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(textValue);

                      if(emailValid==false){
                        return 'please Enter Valid ( @ - gmail.com) Email' ;
                      }

                      return null ;
                  },),
                  TextForm(
                    hint: AppLocalizations.of(context)!.password,
                    myController: passwordController,
                    validatorUser: (textValue) {
                      if(textValue == null || textValue.trim().isEmpty){
                        return "Please Enter Your Password" ;
                      }
                      if(textValue.length < 5  )
                        {
                          return "Please Enter Larger Than 5 Character" ;
                        }
                      return null ;
                    },),
                  TextForm(
                      hint: AppLocalizations.of(context)!.confirm_pass,
                      myController: confirmPassController,
                      validatorUser: (textValue) {
                        if(textValue == null)
                          {
                            return "Please Confirm Password" ;
                          }
                      },),
                ],),
              )),
              SizedBox(height: 40,),
              InkWell(
                onTap: () {
                  registerButton();
                },
                child: Container(
                  width: double.infinity,
                  height: 57,
                  decoration: BoxDecoration(
                      color: MyColorApp.primaryColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: isloading?CircularProgressIndicator(
                    color: Colors.white,
                  ): Text(AppLocalizations.of(context)!.register_button,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,fontSize: 20),)),
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height*0.03,
              // ),
              // Center(
              //     child: Text(
              //       'OR',
              //       style: TextStyle(fontSize: 12, color: Colors.black45),
              //     )),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.09,
              ),
              // InkWell(
              //   onTap: () {
              //     signInWithGoogle();
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     height: 57,
              //     decoration: BoxDecoration(
              //       color: Colors.grey.shade300,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Center(
              //       child: isloading?CircularProgressIndicator(
              //         color: Colors.white,
              //       ):Text(
              //         AppLocalizations.of(context)!.login_google,
              //         style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 17,color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height*0.009,
              // ),
              // InkWell(
              //   onTap: () {
              //     /// login google
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     height: 57,
              //     decoration: BoxDecoration(
              //       color: Colors.grey.shade300,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Center(
              //       child: isloading?CircularProgressIndicator(
              //         color: Colors.white,
              //       ):Text(
              //         AppLocalizations.of(context)!.login_facebook,
              //         style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 17,color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height*.05,
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName) ;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.have_acc, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15,color: Colors.grey.shade600 ),),
                    Text(AppLocalizations.of(context)!.have_acc_login, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15,color:MyColorApp.primaryColor),),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  void registerButton()async{
    if(formKey.currentState!.validate()) {
      setState(() {
        isloading = true ;
      });
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUserModel myUserModel = MyUserModel(
            useriid:credential.user?.uid,
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text);
        var userProvider = Provider.of<UserProvider>(context,listen: false);
          userProvider.updateUser(myUserModel);
        await FirebaseFunction.addUserToFirestore(myUserModel);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(AppLocalizations.of(context)!.register_sucsuss) ));
        print(credential.user?.uid ??'');
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            isloading = false ;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'warning',
            titleTextStyle: TextStyle(color: Colors.black),
            desc:'The password provided is too weak.',
          ).show();
          setState(() {

          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isloading = false ;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'warning',
            titleTextStyle: TextStyle(color: Colors.black),
            desc:'The account already exists for that email.',
          ).show();
          setState(() {

          });
        }
        else if (e.code == 'network-request-failed') {
          setState(() {
            isloading = false ;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Warning',
            titleTextStyle: TextStyle(color: Colors.black),
            desc: 'No internet Connection',
          ).show();
          print('Wrong password dialog shown');
        }
      } catch (e) {
        setState(() {
          isloading = false ;
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          titleTextStyle: TextStyle(color: Colors.black),
          desc: e.toString(),
        ).show();
      }
    }else{
      setState(() {
        isloading = false ;
      });
      print('Error valid');
    }
  }
}


