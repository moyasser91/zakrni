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
              Text(AppLocalizations.of(context)!.registerNewAcc,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black,fontSize: 24)),
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
                        return AppLocalizations.of(context)!.pleaseEnterYourName ;
                      }
                        return null ;
                    },),
                  TextForm(
                    hint: AppLocalizations.of(context)!.email,
                    myController: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validatorUser: (textValue) {
                      if(textValue == null || textValue.trim().isEmpty){
                        return AppLocalizations.of(context)!.pleaseEnterYourEmail ;
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(textValue);

                      if(emailValid==false){
                        return AppLocalizations.of(context)!.pleaseEnterValid ;
                      }

                      return null ;
                  },),
                  TextForm(
                    hint: AppLocalizations.of(context)!.password,
                    myController: passwordController,
                    validatorUser: (textValue) {
                      if(textValue == null || textValue.trim().isEmpty){
                        return AppLocalizations.of(context)!.pleaseConfirmPassword ;
                      }
                      if(textValue.length < 5  )
                        {
                          return AppLocalizations.of(context)!.pleaseEnterLargerThan5Character ;
                        }
                      return null ;
                    },),
                  TextForm(
                      hint: AppLocalizations.of(context)!.confirmPass,
                      myController: confirmPassController,
                      validatorUser: (textValue) {
                        if(textValue == null)
                          {
                            return AppLocalizations.of(context)!.pleaseConfirmPassword ;
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
                  ): Text(AppLocalizations.of(context)!.registerButton,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,fontSize: 20),)),
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
                    Text(AppLocalizations.of(context)!.haveAcc, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15,color: Colors.grey.shade600 ),),
                    Text(AppLocalizations.of(context)!.haveAccLogin, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15,color:MyColorApp.primaryColor),),

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(AppLocalizations.of(context)!.registerSucsuss) ));
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
            titleTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
            desc:AppLocalizations.of(context)!.thePasswordProvidedIsTooWeak,
            descTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14)
          ).show();
          setState(() {

          });
        } else if (e.code == AppLocalizations.of(context)!.emailAlreadyInUse) {
          setState(() {
            isloading = false ;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.rightSlide,
            title: 'warning',
            titleTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
            desc:AppLocalizations.of(context)!.theAccountAlreadyExistsForThatEmail,
            descTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14)
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
            titleTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
            desc: AppLocalizations.of(context)!.noInternetConnection,
            descTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14)
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
          titleTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
          desc: e.toString(),
          descTextStyle:  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13)
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


