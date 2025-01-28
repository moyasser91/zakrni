import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/constance/my_theme.dart';
import 'package:zakrni/provider/list_provider.dart';
import 'package:zakrni/provider/user_provider.dart';

import '../../authintcation/login/login screen.dart';
import '../../provider/appLocalization.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLocalization>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Padding(
            padding:  EdgeInsets.only(left: 12,top: 50,bottom: 5,right: 12),
            child: Text(AppLocalizations.of(context)!.language!,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                  elevation: 50,
                  shape: BorderDirectional(),
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 15,),
                      InkWell(
                        onTap: () {
                          langProvider.changeLanguage('en');
                        },
                        child: langProvider.appLanguage=='en'?
                        selsectedLanguage(AppLocalizations.of(context)!.english!):
                        unselsectedLanguage(AppLocalizations.of(context)!.english!)
                      ),
                          Divider(thickness: 1,color: Colors.brown.shade300,height: 1,),
                          InkWell(
                            onTap: () {
                              langProvider.changeLanguage('ar');
                            },
                            child: langProvider.appLanguage=='ar'?
                            selsectedLanguage(AppLocalizations.of(context)!.arabic!):
                            unselsectedLanguage(AppLocalizations.of(context)!.arabic!)
                          ),
                          Divider(thickness: 1,color: Colors.brown.shade300,height: 1,),

                        ],),
                    );
                  },);
            },
            child: Container(
              margin: EdgeInsets.all(12),
              width: double.infinity,
              height: 50,
              color: Color(0xffbda174),
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(langProvider.appLanguage=='en'?AppLocalizations.of(context)!.english!:AppLocalizations.of(context)!.arabic!,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                  Icon(Icons.arrow_drop_down_outlined,color: Colors.white,)
                ],),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 12,top: 20,bottom: 5,right: 12),
            child: Text(AppLocalizations.of(context)!.theme!,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                elevation: 50,
                shape: BorderDirectional(),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 15,),
                        InkWell(
                            onTap: () {
                              langProvider.changeTheme(ThemeMode.light);
                            },
                            child: langProvider.appTheme==ThemeMode.light?
                            selsectedLanguage(AppLocalizations.of(context)!.light!):
                            unselsectedLanguage(AppLocalizations.of(context)!.light!) ),
                        Divider(thickness: 1,color: Colors.brown.shade300,height: 1,),
                        InkWell(
                            onTap: () {
                              langProvider.changeTheme(ThemeMode.dark);
                            },
                            child: langProvider.appTheme==ThemeMode.dark?
                            selsectedLanguage(AppLocalizations.of(context)!.dark!):
                            unselsectedLanguage(AppLocalizations.of(context)!.dark!) ),
                        Divider(thickness: 1,color: Colors.brown.shade300,height: 1,),

                      ],),
                  );
                },);
            },
            child: Container(
              margin: EdgeInsets.all(12),
              width: double.infinity,
              height: 50,
              color: Color(0xffbda174),
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.light,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                    Icon(Icons.arrow_drop_down_outlined,color: Colors.white,)
                  ],),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 12,top: 20,bottom: 5,right: 12),
            child: Text(AppLocalizations.of(context)!.logout!,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),),
          ),
          InkWell(
              onTap: () {
                listProvider.taskList = [] ;
                userProvider.updateUserModel =null ;
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  height: 50,
                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Icon(Icons.logout_outlined,color: Colors.white,),
                      Text(AppLocalizations.of(context)!.logout!,style: Theme.of(context).textTheme.titleMedium?.copyWith(color:Colors.white),),
                    ],),
                  ) ),
              ))

        ],
      ),
    );
  }


  Widget selsectedLanguage(String lan) {
    return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(lan,style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold
        ),),
        Icon(Icons.check,color: Theme.of(context).primaryColor,size: 28,)
      ],
    );
  }
  Widget unselsectedLanguage(String lan){
    return Row(
      children: [
        Text(lan,style: Theme.of(context).textTheme.titleMedium?.copyWith(),),
        // Icon(Icons.check,size: 28,)
      ],
    );
  }
}







