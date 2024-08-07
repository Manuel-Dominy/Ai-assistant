
import 'package:ai_assistant/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return Homescreen();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    Size mq=MediaQuery.sizeOf(context);
    return Scaffold(
      body:Center(
        child: Image.asset('assets/images/logo.png',width: mq.width *.2,),
      ),
    );
  }
}