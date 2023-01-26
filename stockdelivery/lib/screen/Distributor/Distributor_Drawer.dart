import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/screen/Distributor/Fragments/Show_vendors.dart';
import 'package:stockdelivery/screen/Distributor/showapplyShopkeeper.dart';

import '../userUpdate.dart';
import 'Distributor_dashboard.dart';

class Dis_drawer extends StatefulWidget {
  const Dis_drawer({Key? key}) : super(key: key);

  @override
  State<Dis_drawer> createState() => _Dis_drawerState();
}

class _Dis_drawerState extends State<Dis_drawer> {
  @override
  
  Widget build(BuildContext context) {
  
    return Drawer(
      child: ListView(
         
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage('https://media.istockphoto.com/photos/spring-sunlight-in-green-branch-of-tree-with-shadow-on-white-wall-picture-id1312059732?b=1&k=20&m=1312059732&s=170667a&w=0&h=d2Ce9Smdj56exK4utRiNrdNr0vuXaQ4qsfJi1iAHPRo='),fit:BoxFit.cover ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                    children: [
                      Container(
                        height: 60,width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(image: NetworkImage(userimage + usermodel!.uimage),fit: BoxFit.cover
                          
                          )
                        ),
                      ),
                      
                SizedBox(width: 5,),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> userupdate()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Icon(Icons.edit,size: 15,),
                  ))
                    ],
                  
                ),SizedBox(height: 10,),
                Text(usermodel!.uname.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.teal),),SizedBox(height: 5,),
                Text(usermodel!.userType.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black),),
                showRating(rating: usermodel!.rating.toDouble())
            ],)
            ),
            ListTile(
              onTap: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Show_vendor()));},
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.near_me),
              title: Text("Vendors",),
             
            ),
             ListTile(
               onTap: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Show_vendor()));},
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.production_quantity_limits),
              title: Text("MY Products",),
              
            ),
             ListTile(
               onTap: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Show_vendor()));},
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.admin_panel_settings),
              title: Text("MY Vendors",),
              
            ),
             
              ListTile(
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.outbox_rounded),
              title: Text("Orders",),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Show_vendor()));
              },),
              
             ListTile(
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.credit_card),
              title: Text("Credit",),
              onTap: (){
                
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Show_vendor()));
              },),

                ListTile(
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.credit_card),
              title: Text("Apply Shopkeeper",),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>showapplyShopkeeper()));
              },),
              

            SizedBox(height: 270,),
            Divider(),
            TextButton.icon(onPressed: (){}, icon: Icon(Icons.exit_to_app), label: Text("Sign out"),)

          ],
          
          ),
    );
  }
}

