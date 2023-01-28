import 'dart:collection';
import 'dart:developer';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/RegistrationforExportor_re_exporter/login.dart';
import 'package:hackathanon/Widgets/dropdown.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() => runApp(const DropdownButtonApp());

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownButton Sample')),
        body: const Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  List dropdownItemList = [
    {'label': 'Customer', 'value': 'Customer'}, // label is required and unique
    {'label': 'Exporter', 'value': 'Exporter'},
    {'label': 'Re-Exporter', 'value': 'Re-Exporter'},

  ];
  String dropdownValue = list.first;
  Map<String,dynamic> Selectedperson = new HashMap();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Tell us who you are',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
        SizedBox(
          height: 20,
        ),
        CoolDropdown(
          dropdownList: dropdownItemList,
          onChange: (a) {
            setState(() {
              Selectedperson =  a;
            });

            log(Selectedperson['value']);
          },
          defaultValue: dropdownItemList[0],
          // placeholder: 'insert...',
        ),

        SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed: (){
          setState(() {
            //  Navigate as per....
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyLogin()));
          });
        }, child: Text('Continue'))
      ],
    );
  }
}
