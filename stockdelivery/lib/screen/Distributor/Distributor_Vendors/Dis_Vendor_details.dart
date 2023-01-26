import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/cart_provider.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/models/users.dart';
import 'package:stockdelivery/mywidget/shaderText.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_Vendors/addtocartscreen.dart';

import '../../../mywidget/Mywidget.dart';

users? p;
class Dis_vendor_detail extends StatelessWidget {
   modelsignin user;
   String status;
   Dis_vendor_detail({Key? key,required this.user,required this.status }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final cart  = Provider.of<cartprovider>(context);
    return Scaffold(
      appBar: appbar("Vendor Detail"),
      body: Column(children: [
        Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/userbackground.jpg"),fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              children: [
                Container(height: 110,
                  width: 100,
                  decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(userimage+user.uimage),fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: Colors.white,width: 3)
                  ),),
                  SizedBox(height: 15,),
                  Text(user.uname.toString(),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.yellow),),
                  SizedBox(height: 15,),
                  showRating(rating: user.rating.toDouble())
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(children: [
                    shadertext(text: "Email: ", colors1: Colors.red, colors2: Colors.black),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 265,
                          child: Text(user.uemail.toString(),style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 23, 23, 23)),)),
                  ],),
                  Divider(),
                   SizedBox(height: 15,),
                  Row(children: [
                    shadertext(text: "Mobile No: ", colors1: Colors.black, colors2: Colors.red),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 235,
                          child: Text(user.umobileno.toString(),style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 23, 23, 23)),)),
                  ],),
                    Divider(),
                   SizedBox(height: 15,),
                  Row(children: [
                    shadertext(text: "User Status: ", colors1: Colors.black, colors2: Colors.red),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 230,
                          child: Text(user.accountStatus.toString(),style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 23, 23, 23)),)),
                  ],),
                    Divider(),
                   SizedBox(height: 15,),
                  Row(children: [
                    shadertext(text: "City: ", colors1: Colors.black, colors2: Colors.red),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 280,
                          child: Text(user.ucity.toString(),style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 23, 23, 23)),)),
                  ],),
                  SizedBox(height: 15,),
                  status=="Active"?ElevatedButton.icon(onPressed: () {
                        cart.setcartdataclear();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_to_cart(id: user.id,)));
              }, icon: Icon(Icons.forward), label: Text("Place Order")):
              ElevatedButton.icon(onPressed: () {
                
              }, icon: Icon(Icons.forward), label: Text("Your Status is "+status))
            ]),
          )
          ,
        )
      ],)
    );
  }
}


// Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(children: [
//             Expanded(
//               flex: 2,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 150,
//                     width: 150,
//                     decoration:BoxDecoration(image: DecorationImage(image: NetworkImage(userimage+user.uimage),fit: BoxFit.cover))),
                
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 7,
//               child: Column(children: [
//                   SizedBox(height: 25,),
//               Text("Name: "+user.uname .toString(),style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
//               SizedBox(height: 25,),
//               Divider(color: Colors.black,thickness: 0.1,),
//               SizedBox(height: 25,),
//               Text("E_mail: "+user.uemail.toString()),
//               SizedBox(height: 25,),
//               Divider(color: Colors.black,thickness: 0.1,),
//               SizedBox(height: 25,),
//               Text("Mobile No: "+user.umobileno .toString()),
//               SizedBox(height: 25,),
//               Divider(color: Colors.black,thickness: 0.1,),
//               SizedBox(height: 25,),
//               Text("Status: "+user.accountStatus .toString()),
//               SizedBox(height: 25,),
//               Divider(color: Colors.black,thickness: 0.1,),
//               SizedBox(height: 25,),
//               Text("City: "+user.ucity .toString()),
//               SizedBox(height: 25,),
//               ],),
//             ),
//             Expanded(
//               flex: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//               status=="Active"?TextButton.icon(onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_to_cart(id: user.id,)));
//               }, icon: Icon(Icons.forward), label: Text("Place Order")):
//               TextButton.icon(onPressed: () {
                
//               }, icon: Icon(Icons.forward), label: Text("Your Status is "+status))
            
//               ],),
//             )   
//           ],),
//         ),
//       ),