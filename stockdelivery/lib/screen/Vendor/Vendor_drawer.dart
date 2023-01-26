import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/screen/userUpdate.dart';

import 'Fragments/UserOrders.dart';
import 'Fragments/Vendor_credit.dart';
import 'OrdersManagement/Vendor_orders.dart';
import 'Registered_distributors/Vendor_registeredDistributor.dart';
import 'add_Update_products/Vendor_additems.dart';


class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);
  @override
  
  Widget build(BuildContext context) {
  
    return Drawer(
      child: ListView(
         
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/drawerimage.jpg'),fit:BoxFit.cover ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                  backgroundColor: Colors.black,
                  radius:30,
                  child: ClipOval(
                    child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,)),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> userupdate()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Icon(Icons.edit,size: 15,),
                  ))
                    ],
                  ),
                SizedBox(height: 5,),
                Text(usermodel!.uname.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.teal),),SizedBox(height: 5,),
                Text(usermodel!.userType.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black),),SizedBox(height: 5,),
                showRating(rating: usermodel!.rating.toDouble())
            ],)
            ),
            ListTile(
              onTap: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => const additems()));},
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.add),
              title: Text("Add Product",),
             
            ),
             ListTile(
               onTap: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => const userOrders()));},
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.ac_unit),
              title: Text("Order Status",),
              
            ),
             ListTile(
               onTap: (){Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Vendorcredit()));},
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.credit_card),
              title: Text("Check credit",),
              
            ),
             
              ListTile(
              hoverColor: Colors.blueAccent,
              leading: Icon(Icons.vertical_distribute_outlined),
              title: Text("Distributors",),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Rdistributors()));
              },
              
            ),
            SizedBox(height: 270,),
            Divider(),
            TextButton.icon(onPressed: (){}, icon: Icon(Icons.exit_to_app), label: Text("Sign out"),)

          ],
          
          ),
    );
  }
}

