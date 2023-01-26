import 'dart:async';

import 'package:flutter/material.dart';

import 'Login.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
          ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Login())
          ));}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: Container(height: 500,width: 400, child: Image.asset('assets/images/logo.png',height: 200,width: 300,),)),
    );
  }
}