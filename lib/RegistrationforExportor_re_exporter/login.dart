import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/DashBoardforbussiness/dashboard.dart';
import 'package:hackathanon/RegistrationforExportor_re_exporter/register.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  Map<String,dynamic>? Orgname = new HashMap();
  String name ="";
  var erroremail =null;
  bool loading = false;
  var errorpass = null;

  var errorname = null;
  var errorage = null;

  var errorconfirmpass=null;

  var emailtext = TextEditingController();

  var nametext = TextEditingController();

  var passwordtext = TextEditingController();
  String pass="";
  String Email="";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 35, top: 80),
            child: const Text(
              "Welcome\nBack",
              style: TextStyle(color: Colors.white, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(children: [
                TextField(
                  controller: emailtext,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    errorText: erroremail,
                    hintText: 'Email',

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordtext,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    errorText: errorpass,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     TextButton(
                      child:Text('Sign In',style: TextStyle(
                        color: Color(0xff4c505b),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      )),
                       onPressed: () {
                         Email = emailtext.text.toString();
                          pass = passwordtext.text.toString();
                         authenticate() ;

                       },
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
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                       Navigator.push(context,MaterialPageRoute(builder: (context) => MyRegister()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }


  void authenticate() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email,
          password: pass
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      else{
        log(pass);
        log(e.code.toString());
      }
    }
    String? uuid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot snapshot_ = await FirebaseFirestore.instance.collection("Bussinesses").doc(uuid).get();
Orgname= snapshot_.data() as Map<String, dynamic>?;

    name=Orgname!["Oraganization Name"];


    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context)=>Dashboard(name)));
    log(name);







  }
}
