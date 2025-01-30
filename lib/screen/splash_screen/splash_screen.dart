import 'package:flutter/material.dart';
import 'package:zakrni/authintcation/login/login%20screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash" ;
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),() {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(child:
          Center(child:
          Image.asset('assets/images/flutter_splah.png',width: 290,height: 148,fit: BoxFit.fill,))),
          Text("Developed By MoO Yasser Algndy",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black87,fontSize: 14),),
        ],),
      ),
    );
  }
}
