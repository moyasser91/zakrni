import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zakrni/authintcation/login/login%20screen.dart';
import 'package:zakrni/authintcation/register/register_screen.dart';
import 'package:zakrni/constance/my_theme.dart';
import 'package:zakrni/provider/appLocalization.dart';
import 'package:zakrni/provider/list_provider.dart';
import 'package:zakrni/provider/user_provider.dart';
import 'package:zakrni/screen/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zakrni/screen/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(
     MultiProvider(
         providers: [
           ChangeNotifierProvider(create: (context) => ListProvider(),),
           ChangeNotifierProvider(create: (context) => UserProvider(),),
           ChangeNotifierProvider(create: (context) => AppLocalization(),)
         ],
          child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var langugeprovider = Provider.of<AppLocalization>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
    initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context) => HomeScreen(),
        RegisterScreen.routeName : (context) => RegisterScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        SplashScreen.routeName : (context) => SplashScreen(),
      },
      locale: Locale(langugeprovider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: langugeprovider.appTheme,

    );
  }
}

// home: AnimatedSplashScreen(
// splashIconSize: 300,
// splashTransition: SplashTransition.rotationTransition,
// splash:CircleAvatar(
// radius: 130,
// backgroundImage: AssetImage("assets/images/splash.png"),),
// nextScreen: LoginScreen()),