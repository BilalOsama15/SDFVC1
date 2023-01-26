import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/screen/Distributor/Show_vendos/Distributor_Vendor_details.dart';

import '../../../models/rdistributors.dart';
import '../../../mywidget/Mywidget.dart';


class D_details extends StatelessWidget {
 final modelsignin mdetail;
  const D_details({Key? key,required this.mdetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Distributor Detail"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(children: [
            CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Image.network(userimage+mdetail.uimage,fit: BoxFit.cover,),
                ),
                ),
                SizedBox(height: 20,),
            Text("Name : "+mdetail.uname.toString(),style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 25,),
            Divider(color: Colors.black,thickness: 0.1,),
            SizedBox(height: 25,),
            Text("E-mail : "+mdetail.uemail.toString()),
            SizedBox(height: 25,),
            Divider(color: Colors.black,thickness: 0.1,),
            SizedBox(height: 25,),
            Text("Mobile No : "+mdetail.umobileno.toString()),
            SizedBox(height: 25,),
            Divider(color: Colors.black,thickness: 0.1,),
            SizedBox(height: 25,),
            Text("Security : "+mdetail.userType.toString()),
            SizedBox(height: 25,),
            Divider(color: Colors.black,thickness: 0.1,),
            SizedBox(height: 25,),
            Text("City : "+mdetail.ucity.toString()),
            SizedBox(height: 25,),
            Divider(color: Colors.black,thickness: 0.1,),
          ],),
        ),
      ),
    );
  }
}