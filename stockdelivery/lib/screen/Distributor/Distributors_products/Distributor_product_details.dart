import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/mywidget/shaderText.dart';
import 'package:stockdelivery/screen/Signin.dart';

import '../../../mywidget/Mywidget.dart';


class Dis_product_detail extends StatelessWidget {
  bool instock=false;
  products p;
   Dis_product_detail({Key? key, required this.p }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if(p.total_no_of_cartons>=20)
  {
    instock=true;
  }
    return Scaffold(
      appBar: appbar("Product Detail"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(productimage+p.pimage),fit: BoxFit.cover
            )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 380),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30,left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 160,
                            alignment: Alignment.centerLeft,
                         child: Row(children: [
                          Icon(Icons.circle,size: 10,color: instock?Colors.green:Color.fromARGB(255, 215, 215, 215),),SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        shadertext(text: p.pname.toString(), colors1: Colors.black, colors2: Color.fromARGB(255, 231, 143, 0)),
                          Text(p.category.toString(),style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 109, 109, 109)),)
                          ],),
                         ],),   
                          ),
                          
                          Container(
                            alignment: Alignment.centerRight,
                            width: 160,
                            child: Text(p.saleprice_per_carton.toString()+" P.C",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        ],
                      ),
                  Divider(),
                  SizedBox(height: 15,),
                  Row(children: [
                    shadertext(text: "Available Cartons: ", colors1: Colors.red, colors2: Colors.black),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 195,
                          child: Text(p.total_no_of_cartons.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                  ],),
                  Divider(),
                   SizedBox(height: 15,),
                  Row(children: [
                    shadertext(text: "Quantity per Carton: ", colors1: Colors.black, colors2: Colors.red),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 180,
                          child: Text(p.quantitypercarton.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                  ],),
                  Divider(),
                  SizedBox(height: 15,),
                  shadertext(text: "Description ", colors1: Colors.red, colors2: Colors.black),
                  SizedBox(height: 10,),
                  Container(
                    height: 50,width: double.infinity,
                    child: Text(p.description.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                  )
                    ],
                  ),
                )

              ),
            ),
            )
    );
  }
}

// Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(children: [
//             CircleAvatar(
//               radius: 70,
//               child: ClipOval(
//                 child: Image.network(productimage+p.pimage,fit: BoxFit.cover,),
//                 ),
//                 ),
//                 SizedBox(height: 20,),
//             Text("Name : "+p.pname .toString(),style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
//             SizedBox(height: 20,),
//             Divider(color: Colors.black,thickness: 0.1,),
//             SizedBox(height: 20,),
//             Text("Quantity Per Carton : "+p.quantitypercarton.toString()),
//             SizedBox(height: 20,),
//             Divider(color: Colors.black,thickness: 0.1,),
//             SizedBox(height: 20,),
//             Text("Cateory : "+p.category.toString()),
//             SizedBox(height: 20,),
//             Divider(color: Colors.black,thickness: 0.1,),
//             SizedBox(height: 20,),
//             Text("Description : "+p.description.toString()),
//             SizedBox(height: 20,),
//             Divider(color: Colors.black,thickness: 0.1,),
//           ],),
//         ),
//       ),