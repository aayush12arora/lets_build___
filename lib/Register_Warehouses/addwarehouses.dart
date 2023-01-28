import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/DashBoardforbussiness/dashboard.dart';
import 'package:hackathanon/RegistrationforExportor_re_exporter/login.dart';
import 'package:hackathanon/models/warehousemodel.dart';



class AddWarehouses extends StatefulWidget {
  String pname="";
  AddWarehouses(this.pname);

  @override

  _AddWarehouses createState() => _AddWarehouses(pname);
}
class _AddWarehouses extends State<AddWarehouses> {
String pname="";

_AddWarehouses(this.pname);

List dropdownItemList = [
    {'label': 'Custo', 'value': 'Customer'}, // label is required and unique
    {'label': 'Exporter', 'value': 'Exporter'},
    {'label': 'Re-Exporter', 'value': 'Re-Exporter'},

  ];


  String? location;
  String? capacity;
  String? name;
  String? category;
  var locationtext = TextEditingController();
  var capacitytext= TextEditingController();
  var nametext = TextEditingController();
  var categorytext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: locationtext,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Location',
                        hintText: 'Enter Your location',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(

                      controller: capacitytext,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Capacity',
                        hintText: 'Enter capacity',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                   //   obscureText: true,
                      controller:  nametext,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: categorytext,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),

                        labelText: 'Category',
                        hintText: 'Enter Category',
                      ),
                    ),
                  ),
                  ElevatedButton(

                    child: Text('Submit'),
                    onPressed: (){
                      location = locationtext.text.toString();
                      category = categorytext.text.toString();
                      capacity = capacitytext.text.toString();
                      name= nametext.text.toString();
                      Warehouse warehouse1= new Warehouse(location, capacity, name, category);
                      addwarehouses(warehouse1);

Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Dashboard(pname)));
                    },
                  )
                ],
              )
          ),
        )
    );
  }


  Future<void> addwarehouses(Warehouse warehouses) async {
    final  Map<String,dynamic> warehousedata = new HashMap();
    warehousedata['Name']= warehouses.name;
    warehousedata['Location']=warehouses.location;
    warehousedata['Capacity']=warehouses.capacity;
    warehousedata['Category']=warehouses.category;

    String? uuid = await FirebaseAuth.instance.currentUser?.uid;
    warehousedata['Originaluid']=uuid;
    await FirebaseFirestore.instance.collection("Warehouses").add(warehousedata);

  }
}

