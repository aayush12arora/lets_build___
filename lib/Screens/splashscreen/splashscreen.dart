import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/Screens/askwhoyouare/askwhoyouare.dart';
//import 'package:screens/IntroPage.dart';

class SplashScreen extends StatefulWidget{
  var name;
  SplashScreen();
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var name;
  _SplashScreenState();

//var name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), () {
// Navigate here
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DropdownButtonApp(),));
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.orange.shade200,
        child: Center(child: Text('Welcome',style: TextStyle(fontSize: 37,fontWeight: FontWeight.bold,color: Colors.white),)),
      ),
      //Text('Welcome',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 38),)


    );
  }


}