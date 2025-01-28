import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/Logic/firebase/firebase_function.dart';
import 'package:zakrni/authintcation/register/register_screen.dart';
import 'package:zakrni/authintcation/register/text_form.dart';
import 'package:zakrni/constance/my_color.dart';
import 'package:zakrni/data_model/my_user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/user_provider.dart';
import '../../screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login' ;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
bool isloadinglogin = false;
bool isloadinggoogle = false;
bool isloadingfacebook = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              SizedBox(height:MediaQuery.of(context).size.height*.06,),
          
                 Text(AppLocalizations.of(context)!.login_your_acc,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black,fontSize: 24)),
              SizedBox(height:MediaQuery.of(context).size.height*.004,),
              Row(
                children: [
                  Container(
                    color: Colors.blue,
                    width: 90,
                    height: 3,
                  ),
                  SizedBox(width: 5,),
                  Container(
                    color: Colors.blue,
                    width: 13,
                    height: 3,
                  ),
                ],
              ),
             // SizedBox(height:MediaQuery.of(context).size.height*008,),            SizedBox(height:MediaQuery.of(context).size.height*.1,),
              Center(child: Image.asset('assets/images/loigin.png',width: 350,height: 170,fit: BoxFit.fill,)),
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(spacing: 20,children: [
                      SizedBox(height: 5,),
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

                    ],),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              InkWell(
                onTap: () {
                  loginfunction();
                },
                child: Container(
                  width: double.infinity,
                  height: 57,
                  decoration: BoxDecoration(
                    color: MyColorApp.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: isloadinglogin?CircularProgressIndicator(
                      color: Colors.white,
                    ):Text(
                      AppLocalizations.of(context)!.login_button,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height*0.06,
              // ),
              // Center(
              //     child: Text(
              //       'OR',
              //       style: TextStyle(fontSize: 16, color: Colors.black45),
              //     )),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.2,
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
              //       child: isloadinggoogle?CircularProgressIndicator(
              //         color: Colors.black
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
              //
              //
              //
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     height: 57,
              //     decoration: BoxDecoration(
              //       color: Colors.grey.shade300,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Center(
              //       child: isloadingfacebook?CircularProgressIndicator(
              //         color: Colors.white,
              //       ):Text(
              //         AppLocalizations.of(context)!.login_facebook,
              //         style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 17,color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height*.04,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dont_have_acc,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15,color: Colors.grey.shade600 ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.dont_have_acc_regis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15,  color: MyColorApp.primaryColor,
                        ),
          
                      ),
                    ],
                  ),
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }

  void loginfunction() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isloadinglogin = true ;
      });
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseFunction.readUserFromFirestore(credential.user!.uid);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.updateUser(user);  // تمرير كائن MyUserModel هنا


        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Login Successfully') ));
        print(credential.user?.uid);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException caught: ${e.code}');
        if (e.code == 'invalid-credential') {
          setState(() {
            isloadinglogin = false ;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            titleTextStyle: TextStyle(color: Colors.black),

            desc: 'No user found for that email.',
          ).show();
          print('No user found dialog shown -------- ');
        }
        else if (e.code == 'wrong-password') {
          setState(() {
            isloadinglogin = false ;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            titleTextStyle: TextStyle(color: Colors.black),
            desc: 'Wrong password provided for that user.',
          ).show();
          print('Wrong password dialog shown');
        }
        else if (e.code == 'network-request-failed') {
          setState(() {
            isloadinglogin = false ;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'Error',
            titleTextStyle: TextStyle(color: Colors.black),
            desc: 'No internet Connection',
          ).show();
          print('Wrong password dialog shown');
        }
      } catch (e) {
        setState(() {
          isloadinglogin = false ;
        });
        // Handle any other types of errors
        print('Error: $e');
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          titleTextStyle: TextStyle(color: Colors.black),

          desc: e.toString(),
        ).show();
      }
    } else {
      setState(() {
        isloadinglogin = false ;
      });
      print('Form is not valid');
    }
  }
}


