import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/Register_Warehouses/addwarehouses.dart';
import 'package:hackathanon/Screens/Homepageforexportor/HomePageex.dart';
import 'package:hackathanon/models/warehousemodel.dart';

class Dashboard extends StatefulWidget {
String name="";
  Dashboard(this.name);

  @override
  State<Dashboard> createState() => _DashboardState(name);
}

class _DashboardState extends State<Dashboard> {
  String? uuid = FirebaseAuth.instance.currentUser?.uid;

  List<dynamic> hus = [];
  void makelist() async{

    String? uuid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Warehouses")
        .get() ;


      for(var doc in snapshot.docs){
    log(doc.data().toString());
    hus.add(doc.data());
  }

    log(hus.length.toString());

  }



  var houses =null;
  String name = "";

  _DashboardState(this.name);


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        leading: IconButton(onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageexp()));
        },
          icon: Icon(
            Icons.home
          ),
        ),


      ),
      body: Container(
        color: Colors.orange.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome ,$name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 33,color: Colors.white),),
            SizedBox(
              height: 20,
            ),
            Container(
              //   width: 250,
              height: 240,
              child: StreamBuilder<QuerySnapshot>(
                //here where is used for filteration
                // various filter are greaterthanequalto,islessthanequalto,islessthan,isEqualto,whereIn (takes a list and find that elements present in the list)

                // stream: FirebaseFirestore.instance.collection("Users").where("Age",isLessThanOrEqualTo: 21).snapshots(),
                stream:  FirebaseFirestore.instance.collection("Warehouses").where('Originaluid',isEqualTo:uuid ).snapshots(),
                builder:(context,snapshot){
                  if(snapshot.connectionState==ConnectionState.active){
                    if(snapshot.hasData&&snapshot.data!=null){
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: ListView.separated(itemBuilder: (context,index){

                              Map<String,dynamic>usermap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                              return ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(

                                    backgroundColor: Colors.purpleAccent.shade100
                                  ),
                                ),
                                title:Container(margin: new EdgeInsets.only(left: 20),

                                    child: Text(usermap["Name"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                subtitle:Container(margin: new EdgeInsets.only(left: 20),
                                    child: Text(usermap["Location"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                                trailing:Text(usermap['Capacity'].toString()),


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
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddWarehouses(name)));
      }, icon:Icon(Icons.add)),
                Text("Add warehouses")
              ],
            )
          ],
        ),
      ),
    );

  }


//  List<dynamic> getwarehouses() async{
//     List<Warehouse> warehouses = [];
//  String? uuid =   FirebaseAuth.instance.currentUser?.uid;
//  //DocumentSnapshot snapshot_ = (await FirebaseFirestore.instance.collection("Bussinesses").doc(uuid)..collection("Warehouses")) as DocumentSnapshot<Object?>get();
// late DocumentReference documentReference;
// late CollectionReference collectionReference;
//
// QuerySnapshot snapshot  = await FirebaseFirestore.instance.collection("Warehouses").get();
//
//   for(var doc in snapshot.docs){
// warehouses.add(doc.data() as Warehouse);
//      log(doc.data().toString());
//    }
//    log(snapshot.docs.toString());
//
//
// //
// //    DocumentSnapshot snapshot = (await FirebaseFirestore.instance.collection("Bussinesses").doc(uuid).collection("Warehouses").snapshots()) as DocumentSnapshot<Object?>;
// // Warehouse warehouse = snapshot.data() as Warehouse;
// return warehouses;
//   }
  
}

