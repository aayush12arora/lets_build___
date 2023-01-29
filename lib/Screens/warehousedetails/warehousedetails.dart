import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/Screens/Homepageforexportor/HomePageex.dart';
import 'package:xen_popup_card/xen_card.dart';

import '../popuptotransfer.dart';

class WareHousedetails extends StatefulWidget {
Map<String,dynamic>usermap = new HashMap();

WareHousedetails(this.usermap) ;

@override
State<WareHousedetails> createState() => _WareHousedetailsState(usermap);
}

class _WareHousedetailsState extends State<WareHousedetails> {
  List dropdownItemList = [
    {'label': 'Customer', 'value': 'Customer'}, // label is required and unique
    {'label': 'Exporter', 'value': 'Exporter'},
    {'label': 'Re-Exporter', 'value': 'Re-Exporter'},

  ];
  Map<String, dynamic>usermap = new HashMap();
  Map<String, dynamic>partiware = new HashMap();
  Map<String, dynamic> Selectedware = new HashMap();
  var wares = <Map>[];

  _WareHousedetailsState(this.usermap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(

              child: Row(
                children: [

                  Text(usermap['Name'], style: TextStyle(fontSize: 33,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Location:-', style: TextStyle(fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
                Text(usermap['Location'], style: TextStyle(fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade900)),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Capacity', style: TextStyle(fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
                Text(usermap['Capacity'], style: TextStyle(fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade900)),
              ],
            ),
            Row(
              children: [
                Text('Category', style: TextStyle(fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
                Text(usermap['Category'], style: TextStyle(fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade900)),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(onPressed: () {
                cardWithBodyOnly();
              }, child: Text('Continue')),
            )


          ],
        ),
      ),
    );
  }

  XenCardGutter gutter = const XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "close"),
    ),
  );

  void cardWithBodyOnly() {
    showDialog(
      context: context,
      builder: (builder) =>
          XenPopupCard(
            body: ListView(
              children: [
                Text('Select your where house',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27,),),
SizedBox(
  height: 15,
),
              //   width: 250,
              Container(
              height: 240,
              child: StreamBuilder<QuerySnapshot>(
                //here where is used for filteration
                // various filter are greaterthanequalto,islessthanequalto,islessthan,isEqualto,whereIn (takes a list and find that elements present in the list)

                // stream: FirebaseFirestore.instance.collection("Users").where("Age",isLessThanOrEqualTo: 21).snapshots(),
                stream:  FirebaseFirestore.instance.collection("Warehouses").where('Originaluid',isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
                builder:(context,snapshot){
                  if(snapshot.connectionState==ConnectionState.active){
                    if(snapshot.hasData&&snapshot.data!=null){
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 350,
                            child: ListView.separated(itemBuilder: (context,index){

                              Map<String,dynamic>usermap_ = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                              return InkWell(
                                onTap: (){
                                  int b2cap= int.parse(usermap['Capacity']);
                                  b2cap++;
                                  log(b2cap.toString());
                                  int b1cap= int.parse(usermap_['Capacity']);
                                  b1cap--;
                                  log(b1cap.toString());
                                  usermap['Capacity']=b2cap.toString();
                                  usermap_['Capacity']=b1cap.toString();
                              //   FirebaseFirestore.instance.collection("Warehouses").doc(usermap_['Originaluid']).delete();
                                 // FirebaseFirestore.instance.collection("Warehouses").doc(usermap['Originaluid']).delete();
                                  FirebaseFirestore.instance.collection("Warehouses").doc(usermap_['Originaluid']).set(usermap_,SetOptions(
                                    merge: true
                                  ));

                                  FirebaseFirestore.instance.collection("Warehouses").doc(usermap['Originaluid']).set(usermap ,SetOptions(
                                      merge: true
                                  ) );

                                 Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context)=>HomePageexp()));
                                },
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(

                                        backgroundColor: Colors.purpleAccent.shade100
                                    ),
                                  ),
                                  title:Container(margin: new EdgeInsets.only(left: 20),

                                      child: Text(usermap_["Name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                  subtitle:Container(margin: new EdgeInsets.only(left: 20),
                                      child: Text(usermap_["Location"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                  trailing:Text(usermap_['Capacity'].toString()),


                                ),
                              );
                            },scrollDirection: Axis.vertical,
                              shrinkWrap: true,itemCount: snapshot.data!.docs.length,separatorBuilder: (context,index){
                                return Divider(height: 10,thickness: 5,);
                              },),
                          ),
                        );
                    }
                    else{
                      return Text('No Data');
                    }
                  }
                  else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
              ],
            ),
          ),
    );
  }

}

