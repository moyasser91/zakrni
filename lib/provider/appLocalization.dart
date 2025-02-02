import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppLocalization extends ChangeNotifier{

  String appLanguage = 'ar' ;
  ThemeMode appTheme = ThemeMode.light ;

  void changeLanguage(String newLanguage)
  {
    if(appLanguage!=newLanguage){
      appLanguage=newLanguage ;
    }
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme)
  {
    if(appTheme != newTheme){
      appTheme=newTheme;
    }
    notifyListeners();
  }

}