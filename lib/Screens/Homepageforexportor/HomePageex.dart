import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathanon/Screens/warehousedetails/warehousedetails.dart';

class HomePageexp extends StatefulWidget {
  const HomePageexp({Key? key}) : super(key: key);

  @override
  State<HomePageexp> createState() => _HomePageexpState();
}

class _HomePageexpState extends State<HomePageexp> {
  @override
  String searchValue = '';
  final List<String> _suggestions = ['Albania', 'Algeria', 'Andorra' , 'Anguilla' , 'Antigua and Barbuda' , 'Argentina' , 'Armenia' , 'Aruba' , 'Australia' , 'Austria' , 'Azerbaijan' , 'Bahamas' , 'Bahrain' ,'Bangladesh','Barbados','Belarus','Belgium','Belize','Benin','Bermuda','Botswana','Brazil','Bulgaria','Burkina Faso','Burundi','Cambodia','Cameroon','Canada','Chile','China','Colombia','Costa Rica','Croatia','Cuba','Cyprus','Denmark','Dominica','Ecuador','Egypt','El Salvador','Estonia','Ethiopia','Fiji','Finland','France','French Polynesia','Gabon','Gambia','Georgia','Germany','Ghana','Greece','Greenland','Grenada','Guadeloupe','Guatemala','Hungary','Iceland','Indonesia','Iran','Iraq','Ireland','Israel','Italy','Jamaica','Japan','Jordan','Kazakhstan','Kenya','Kuwait','Kyrgyzstan','Latvia','Angola','Bhutan','Comoros','Eritrea','Djibouti','French Guiana','Guinea-Bissau','Haiti','Lebanon'];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

            appBar: EasySearchBar(

                title: const Text('Example'),
                onSearch: (value) => setState(() => searchValue = value),
                suggestions: _suggestions
            ),
            drawer: Drawer(
                child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Text('Drawer Header'),
                      ),
                      ListTile(
                          title: const Text('Item 1'),
                          onTap: () => Navigator.pop(context)
                      ),
                      ListTile(
                          title: const Text('Item 2'),
                          onTap: () => Navigator.pop(context)
                      )
                    ]
                )
            ),
            body: Center(
                child: Column(
                 children: [
                   Container(
                     //   width: 250,
                     height: 240,
                     child: StreamBuilder<QuerySnapshot>(
                       //here where is used for filteration
                       // various filter are greaterthanequalto,islessthanequalto,islessthan,isEqualto,whereIn (takes a list and find that elements present in the list)

                       // stream: FirebaseFirestore.instance.collection("Users").where("Age",isLessThanOrEqualTo: 21).snapshots(),
                       stream:  FirebaseFirestore.instance.collection("Warehouses").where('Location',isEqualTo: searchValue).snapshots(),
                       builder:(context,snapshot){
                         if(snapshot.connectionState==ConnectionState.active){
                           if(snapshot.hasData&&snapshot.data!=null){
                             return
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Expanded(
                                   child: ListView.separated(itemBuilder: (context,index){

                                     Map<String,dynamic>usermap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                                     return InkWell(
                                       onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>WareHousedetails(usermap)));
                                       },
                                       child: ListTile(
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
                )
            )
        );

  }
}

