import 'dart:collection';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/RegistrationforExportor_re_exporter/login.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  var erroremail =null;
  bool loading = false;
  var errorpass = null;

  var errorname = null;
  var errorage = null;

  var errorconfirmpass=null;

  var emailtext = TextEditingController();

  var nametext = TextEditingController();

  var passwordtext = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Create\nAccount",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
               
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
color: Colors.white,
                          width: 4
                        ),
                        borderRadius: BorderRadius.circular(40)
                      ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildName(),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildAnimatedText(),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 33,right: 33),
                    child: TextField(
                      controller: nametext,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        errorText: errorname,
                        hintText: 'Organisation Name',

                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: emailtext,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      hintText: 'Email',
                      errorText: erroremail,
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: passwordtext,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      errorText: errorpass,
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: TextButton(onPressed: () {


                            createaccount();
// navigate to login
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyLogin()));
                          },
                            child: Text('Sigin',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xff4c505b),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {

                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
  Widget buildName() => Text(
    "Hey There",
    style: TextStyle(fontSize: 35.00),
  );

  Widget buildAnimatedText() => AnimatedTextKit(
    animatedTexts: [
      buildText("  Sign Up"),
    ],
    repeatForever: true,
    pause: const Duration(milliseconds: 50),
    displayFullTextOnTap: true,
    stopPauseOnTap: true,
  );

  buildText(String text) {
    return TypewriterAnimatedText(
      text,
      textStyle: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      speed: const Duration(milliseconds: 100),
    );
  }


  void createaccount() async{

    errorname=null;
    erroremail =null;
    errorpass = null;
    errorconfirmpass=null;
    String downloadurl="";

    String Name = nametext.text.toString().trim();
    String Email = emailtext.text.toString().trim();
    String Password = passwordtext.text.toString().trim();


    if(Email==""||Password==""||Name==""){

      errorname="provide all details";
      erroremail="provide all details";
      errorconfirmpass="provide all details";
      errorpass="provide all details";
      log("provide all details");
      log("provide all details");
    }
    else{
      try {
        FirebaseAuth auth= FirebaseAuth.instance;
        UserCredential userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: Email, password: Password);
        log("done");
        if(userCredentials.user!=null){
          final  User? user = auth.currentUser;
          String Uid__ = user!.uid;
          final  Map<String,dynamic> userdata = new HashMap();
          userdata['Oraganization Name']= Name;
          userdata['Email']=Email;




          await FirebaseFirestore.instance.collection("Bussinesses").doc(Uid__).set(userdata);

          //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));
        }
      } on FirebaseAuthException catch(ex){
        errorpass=ex.code.toString();
        errorconfirmpass= ex.code.toString();
        setState(() {

        });
        log(ex.code.toString());
      }

      nametext.clear();
      emailtext.clear();
      passwordtext.clear();

    }

  }







}
