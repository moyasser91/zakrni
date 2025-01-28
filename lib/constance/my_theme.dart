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
   titleLarge: GoogleFonts.cairo(
      color: MyColorApp.whiteColor,
    fontSize: 27,
    fontWeight: FontWeight.w500
   ),
   titleMedium: GoogleFonts.cairo(
          color: MyColorApp.blackColor,
          fontSize: 20,
   ),
    titleSmall: GoogleFonts.cairo(
      color: MyColorApp.blackColor,
      fontSize: 20,
    ),
  )
  );
 static final ThemeData darkTheme = ThemeData(
     primaryColor: MyColorApp.primaryColordark,
     scaffoldBackgroundColor: MyColorApp.backgroundLightColordark,
     appBarTheme: AppBarTheme(
         backgroundColor: MyColorApp.primaryColordark,
         elevation: 0
     ),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
         selectedItemColor: MyColorApp.primaryColordark,
         unselectedItemColor: Colors.grey
     ),
     textTheme: TextTheme(
       titleLarge: GoogleFonts.cairo(
           color: MyColorApp.whiteColor,
           fontSize: 27,
           fontWeight: FontWeight.w500
       ),
       titleMedium: GoogleFonts.cairo(
         color: MyColorApp.blackColor,
         fontSize: 20,
       ),
       titleSmall: GoogleFonts.cairo(
         color: MyColorApp.blackColor,
         fontSize: 20,
       ),
     )
 );

}