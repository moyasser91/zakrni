import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zakrni/constance/my_color.dart';

class MyThemeData{

 static final ThemeData lightTheme = ThemeData(
  primaryColor: MyColorApp.primaryColor,
  scaffoldBackgroundColor: MyColorApp.backgroundLightColor,
  appBarTheme: AppBarTheme(
   backgroundColor: MyColorApp.primaryColor,
   elevation: 0
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
   selectedItemColor: MyColorApp.primaryColor,
   unselectedItemColor: Colors.grey
  ),
  textTheme: TextTheme(
   titleLarge: GoogleFonts.poppins(
      color: MyColorApp.whiteColor,
    fontSize: 27,
    fontWeight: FontWeight.w500
   ),
   titleMedium: GoogleFonts.poppins(
          color: MyColorApp.blackColor,
          fontSize: 20,
   ),
    titleSmall: GoogleFonts.alexandria(
      color: MyColorApp.blackColor,
      fontSize: 20,
    ),
  )
  );

}