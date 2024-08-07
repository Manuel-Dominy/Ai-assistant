import 'package:flutter/material.dart';

class message{
  final String st;
  final bool user;
  late Color co;
    message(this.st,this.user){
      co=user?Color.fromARGB(255, 174, 157, 157):Colors.blue;
  }
  

}