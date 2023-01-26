import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../methods/apicalling.dart';
import '../../../models/signin.dart';
import '../../../models/userorders.dart';
import '../../../mywidget/Mywidget.dart';
import '../../../mywidget/show_Rating.dart';
import '../../Distributor/Distributor_orders/Dis_Order_product_details.dart';

class C_O_D extends StatefulWidget {
    final userorders userorder;
    final String uType;
  const C_O_D({Key? key, required this.userorder, required this.uType}) : super(key: key);

  @override
  State<C_O_D> createState() => _C_O_DState(userorder.id,userorder.order_status);
}

class _C_O_DState extends State<C_O_D> {
  _C_O_DState(this.oid,this.orderstatus);
  var data=[
    "active",
    "cancelled",
    "packed",
    "on the way",
    "delivered"
  ];
  int? oid=0;
  String? orderstatus="";
  int rating =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       userwithproduct=widget.uType=="shopkeeper" || widget.uType=="distributor"?getorderproducts(oid!):getorderproductsfromdistributorside(oid!,widget.uType);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Order Details"),
      body: FutureBuilder<modelsignin?>(
        future: userwithproduct,
        builder: (BuildContext context,AsyncSnapshot<modelsignin?> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator());
              }
              else if(snapshot.connectionState==ConnectionState.done)
              {
                if(snapshot.hasError)
                {
                  return Center(child: Text("Snapshot Error"),);
                }
                else if(snapshot.hasData)
                {
                  if(snapshot.data!.item!.isEmpty)
                  {
                    return Center(child: Text("No Product to Show"));
                  }
                  else
                  {
        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(height: 5,),
                Text("User Order",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green),),
                Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Container(
          height: 180,
          color: Color.fromARGB(107, 232, 232, 232),
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(userimage+snapshot.data!.uimage.toString(),fit: BoxFit.cover,),
          ),
        ),
        SizedBox(width: 10,),
        Container(
          height: 180,
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(snapshot.data!.uname.toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.red),),
              SizedBox(height: 12,),
              Text("Email: "+snapshot.data!.uemail.toString(),style: TextStyle(fontSize: 14,)),
              SizedBox(height: 12,),
              Text("Mobile No: "+snapshot.data!.umobileno.toString(),style: TextStyle(fontSize: 14,)),
              SizedBox(height: 12,),
              Text("City: "+snapshot.data!.ucity.toString(),style: TextStyle(fontSize: 14,)),
              SizedBox(height: 12,),
              Text("User Type: "+snapshot.data!.userType.toString(),style: TextStyle(fontSize: 14)),
              SizedBox(height: 12,),
              showRating(rating: double.parse(snapshot.data!.rating.toString()))
              
            ],
          ),
        ),
        
      ],),
                ),
                Text("Order Status",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green),),
                Divider(),
                Text(orderstatus!.toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),),
                
                Divider(),
                Text("Order Products",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 230,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 1,
                  mainAxisExtent: 160
                  ),
                itemCount: snapshot.data!.item!.length,
                 itemBuilder: ((context, index) {
                   return GestureDetector(
                    onTap: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Disorderproduct_detail(pid:int.parse(snapshot.data!.item![index].productid.toString()))));
                    },
                     child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(productimage+snapshot.data!.item![index].pimage.toString(),),fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 7,),
                                Row(
                                  children: [
                                    Container(width: 60,
                                    height: 20,
                                    child: Text("Name: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(width: 90,
                                    height: 20,
                                    child: Text(snapshot.data!.item![index].pname.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                                    ),

                                  ],
                                ),
                                Divider(height:10),
                                  Row(
                                  children: [
                                    Container(width: 60,
                                    height: 20,
                                    child: Text("QTY: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(width: 90,
                                    height: 20,
                                    child: Text(snapshot.data!.item![index].productquantity.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                                    ),

                                  ],
                                ),
                                
                                Divider(height:10),
                                  Row(
                                  children: [
                                    Container(width: 60,
                                    height: 20,
                                    child: Text("T.Price: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    ),
                                    Container(width: 90,
                                    height: 20,
                                    child: Text(snapshot.data!.item![index].productPrice.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                                    ),
                                   
                                  ],
                                ),
                                Divider(height:10),
                              ],
                            ),
                          )
                        ],
                      ),
                     ),
                   );
                 })),
              ),
            ),
            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Container(
                        height: 50,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Center(child: Text("Total Amount:  "+widget.userorder.total_amount.toString()+"/-RS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                      ),
                    ],
                  ),
                )

          ],
        );
      }
                }
              }
              return Center(child: CircularProgressIndicator());
        },
      ),

    );
  }
}


