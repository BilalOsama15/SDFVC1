import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/userorders.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_orders/Dis_Order_product_details.dart';

import '../../../models/Items.dart';
import '../../../models/lists.dart';
import '../../../models/orders.dart';
import '../../../models/signin.dart';
import '../../../mywidget/Mywidget.dart';



class Distributor_order_details extends StatefulWidget {
  final userorders userorder ;
  final String type;
  const Distributor_order_details({Key? key, required this.userorder,required this.type }) : super(key: key);

  @override
  State<Distributor_order_details> createState() => _Distributor_order_detailsState(userorder.id,userorder.order_status);
}

class _Distributor_order_detailsState extends State<Distributor_order_details> {
  int oid=0;
  _Distributor_order_detailsState(this.oid,this.orderstatus);
  var data=[
    "active",
    "cancelled",
    "Packed",
    "on the way",
    "Delivered"
  ];
  String? orderstatus;
  int status=0;
  int rating=0;
  void check()
  async{
status = await Rateapi.checkalreadyrated(oid.toString(),orderUser!.id.toString(),usermodel!.id.toString());
setState(() {
  
});
  }
  @override
  void initState() {
   userwithproduct=getorderproductsfromdistributorside(oid,widget.type);
  check();
    super.initState();
  }
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
                Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child:widget.type=="vendor" ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderstatus!,
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),),
                       orderstatus=="pending"?ElevatedButton(onPressed: () async {
                          showLoader(context);
                                     int statuscode= await D_O_A.updateorderstatus(widget.userorder.id,"cancelled");
                                      hideLoader(context);
                                      statuscode==200?showSnackBar(context, "Order Status Change Successfully", Colors.green):
                                                    showSnackBar(context, "Order Status Cannot Be Changed", Colors.red);
                                       setState(() {
                                      
                                    });
                        }, child: Text("Cancel Order")):orderstatus=="delivered" && status==200?ElevatedButton(onPressed: () async {
                          await  showDialog(context: context, builder:(builder){
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,width: 200,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Rate Your Seller",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w800,color: Colors.red),),
                                        SizedBox(height: 15,),
                                        Text("Please Leave A Star Rating",style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600),),
                                        SizedBox(height: 20,),
                                        RatingBar.builder(
                                          glow: false,                                          
                                          itemBuilder: (context,_)=>Icon(Icons.star,color:Colors.yellow), 
                                          onRatingUpdate: (ratings){
                                          setState(() {
                                            rating=ratings.toInt();
                                          });
                                        }),
                                        SizedBox(height: 10,),
                                        ElevatedButton(onPressed: ()async{
                                          showLoader(context);
                                          print(rating);
                                        int statuscode = await Rateapi.rateuser(widget.userorder.id.toString(),orderUser!.id.toString(),usermodel!.id.toString(),rating.toString());
                                          hideLoader(context);
                                        statuscode == 200?showSnackBar(context, "Rated Successfully", Colors.green):showSnackBar(context, "Not Rated Successfully", Colors.red);
                                          Navigator.of(context).pop();
                                        }, child: Text("Rate Now"))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              });
                        }, child: Text("Rate Seller")):Container()
                      ],
                    ): Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(orderstatus!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),),
                       widget.userorder.order_status=="cancelled"?Container(): 
                       PopupMenuButton(
                              onSelected: (value) async {
                               
                                if(value==data[0])
                                {
                                    orderstatus= "active";
                                    await  showDialog(context: context, builder:(builder){
                                return AlertDialog(
                                  title: Text("Are You Sure"),
                                  content: Text("Once You Change Your Status in 'Active' Then Again It will Not Change"),
                                  actions: [
                                    TextButton(onPressed: () async {
                                        Navigator.of(context).pop();
                                    }, child: Text("No"),
                                    ),
                        
                                    TextButton(onPressed: ()async {
                                      showLoader(context);
                                     int statuscode= await D_O_A.updateorderstatus(widget.userorder.id,orderstatus!);
                                      hideLoader(context);
                                      statuscode==200?showSnackBar(context, "Order Status Change Successfully", Colors.green):
                                                    showSnackBar(context, "Order Status Cannot Be Changed", Colors.red);
                                       setState(() {
                                      
                                    });
                                      Navigator.of(context).pop();
                                    }, child: Text("Yes"),
                                    )
                                  ],
                        
                                );
                              });
                                }
                                else if(value==data[1])
                                {
                                    orderstatus= "cancelled";
                                    await  showDialog(context: context, builder:(builder){
                                return AlertDialog(
                                  title: Text("Are You Sure"),
                                  content: Text("You Want To Cancel This Order! It can Not Be Active Again"),
                                  actions: [
                                    TextButton(onPressed: () async {
                                        Navigator.of(context).pop();
                                    }, child: Text("No"),
                                    ),
                        
                                    TextButton(onPressed: ()async {
                                      showLoader(context);
                                     int statuscode= await D_O_A.updateorderstatus(widget.userorder.id,orderstatus!);
                                      hideLoader(context);
                                      statuscode==200?showSnackBar(context, "Order Status Change Successfully", Colors.green):
                                                    showSnackBar(context, "Order Status Cannot Be Changed", Colors.red);
                                       setState(() {
                                      
                                    });
                                      Navigator.of(context).pop();
                                    }, child: Text("Yes"),
                                    )
                                  ],
                        
                                );
                              });
                                }
                                else if(value==data[2])
                                {
                                      orderstatus= "packed";
                                    await  showDialog(context: context, builder:(builder){
                                return AlertDialog(
                                  title: Text("Are You Sure"),
                                  content: Text("Once You Change Your Status in 'Packed' Then Again It will Not Change"),
                                  actions: [
                                    TextButton(onPressed: () async {
                                        Navigator.of(context).pop();
                                    }, child: Text("No"),
                                    ),
                        
                                    TextButton(onPressed: ()async {
                                      showLoader(context);
                                     int statuscode= await D_O_A.updateorderstatus(widget.userorder.id,orderstatus!);
                                      hideLoader(context);
                                      statuscode==200?showSnackBar(context, "Order Status Change Successfully", Colors.green):
                                                    showSnackBar(context, "Order Status Cannot Be Changed", Colors.red);
                                       setState(() {
                                      
                                    });
                                      Navigator.of(context).pop();
                                    }, child: Text("Yes"),
                                    )
                                  ],
                        
                                );
                              });
                                }
                                else if(value==data[3])
                                {
                                      orderstatus= "on the way";
                                     await  showDialog(context: context, builder:(builder){
                                return AlertDialog(
                                  title: Text("Are You Sure"),
                                  content: Text("Once You Change Your Status in 'On The Way' Then Again It will Not Change"),
                                  actions: [
                                    TextButton(onPressed: () async {
                                        Navigator.of(context).pop();
                                    }, child: Text("No"),
                                    ),
                        
                                    TextButton(onPressed: ()async {
                                      showLoader(context);
                                     int statuscode= await D_O_A.updateorderstatus(widget.userorder.id,orderstatus!);
                                      hideLoader(context);
                                      statuscode==200?showSnackBar(context, "Order Status Change Successfully", Colors.green):
                                                    showSnackBar(context, "Order Status Cannot Be Changed", Colors.red);
                                       setState(() {
                                      
                                    });
                                      Navigator.of(context).pop();
                                    }, child: Text("Yes"),
                                    )
                                  ],
                        
                                );
                              });
                                }
                                else if(value==data[4])
                                {
                                      orderstatus= "delivered";
                                     
                            await  showDialog(context: context, builder:(builder){
                                return AlertDialog(
                                  title: Text("Are You Sure"),
                                  content: Text("Once You Change Your Status in 'Delivered' Then Again It will Not Change"),
                                  actions: [
                                    TextButton(onPressed: () async {
                                        Navigator.of(context).pop();
                                    }, child: Text("No"),
                                    ),                      
                                    TextButton(onPressed: ()async {
                                      showLoader(context);
                                     int statuscode= await D_O_A.updateorderstatus(widget.userorder.id,orderstatus!);
                                      hideLoader(context);
                                      statuscode==200?showSnackBar(context, "Order Status Change Successfully", Colors.green):
                                        showSnackBar(context, "Order Status Cannot Be Changed", Colors.red);
                                      showDialog<void>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Center(
                                              child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: MediaQuery.of(context).size.height,
                                                width: MediaQuery.of(context).size.width,
                                                color: Colors.transparent,
                                              ),
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  color: Colors.white,
                                                ),
                                                child: const Center(
                                                  child: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation(Colors.pink),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ));
                                        });
                                       setState(() {
                                      
                                    });
                                      Navigator.of(context).pop();
                                    }, child: Text("Yes"),
                                    )
                                  ],
                        
                                );
                              });
                              await  showDialog(context: context, builder:(builder){
                             // int rating;
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,width: 200,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Rate Your Seller",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w800,color: Colors.red),),
                                        SizedBox(height: 15,),
                                        Text("Please Leave A Star Rating",style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600),),
                                        SizedBox(height: 20,),
                                        RatingBar.builder(
                                          glow: false,                                          
                                          itemBuilder: (context,_)=>Icon(Icons.star,color:Colors.yellow), 
                                          onRatingUpdate: (ratings){
                                          setState(() {
                                            rating=ratings.toInt();
                                          });
                                        }),
                                        SizedBox(height: 10,),
                                        ElevatedButton(onPressed: ()async{
                                          showLoader(context);
                                          print(rating);
                                        int statuscode = await Rateapi.rateuser(widget.userorder.id.toString(),orderUser!.id.toString(),usermodel!.id.toString(),rating.toString());
                                          hideLoader(context);
                                        statuscode == 200?showSnackBar(context, "Rated Successfully", Colors.green):showSnackBar(context, "Not Rated Successfully", Colors.red);
                                          Navigator.of(context).pop();
                                        }, child: Text("Rate Now"))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              });
                              
                                    
                                }
                                
                              },
                              itemBuilder: (context)=>[
                              PopupMenuItem(enabled: orderstatus=="pending"?true:false ,value: data[0],child: const Text("Active")),
                              PopupMenuItem(enabled: orderstatus!="delivered"?true:false ,value: data[1],child: const Text("Cancelled")),
                              PopupMenuItem(enabled: orderstatus=="active"?true:false ,value: data[2],child: const Text("Packed")),
                              PopupMenuItem(enabled: orderstatus=="packed"?true:false ,value: data[3],child: const Text("On The Way")),
                              PopupMenuItem(enabled: orderstatus=="on the way"?true:false ,value: data[4],child: const Text("Delivered")),
                              
                              
                            ])
                        
                      ],
                    ),
                    
                  ),

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
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Center(child: Text("Total Amount: "+widget.userorder.total_amount.toString()+"/-RS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
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


//.........

