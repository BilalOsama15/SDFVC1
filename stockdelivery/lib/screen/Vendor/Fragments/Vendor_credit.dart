import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/screen/Vendor/Credit_management/checkcreditbuyerorders.dart';
import 'package:stockdelivery/screen/Vendor/OrdersManagement/Vendor_orders.dart';

import '../Credit_management/Notification.dart';
import '../Credit_management/payments_details.dart';
import '../Vendor_drawer.dart';
class Vendorcredit extends StatefulWidget {
  const Vendorcredit({Key? key}) : super(key: key);

  @override
  State<Vendorcredit> createState() => _VendorcreditState();
}

class _VendorcreditState extends State<Vendorcredit> {
  var data = [
    "All",
      "Distributor",
      "ShopKeeper",  
    ];
    String type="all";
    int i = 0;
  @override
  void initState() {
    credituser=getcredituser(usermodel!.id,type);
   NotificationLen= getNotificationLength(usermodel!.id,"vendor");

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Users"),centerTitle: true,
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Notificatio()));
          },
          child: Badge(
            badgeContent: 
            FutureBuilder<int?>(future: NotificationLen,
            builder: (BuildContext context,AsyncSnapshot<int?> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Text(0.toString(),style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),);
              }
              else if(snapshot.connectionState==ConnectionState.done)
              {
                if(snapshot.hasError)
                {
                  return Text(0.toString(),style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),);
                }
                else if(snapshot.hasData)
                {
                  if(snapshot.data==null){
                    return Text(0.toString(),style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),);
                  }
                    return Text(snapshot.data.toString(),style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),);
                  
                }
                
              }
          return Text(0.toString(),style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),);
            },
            ),
            position: BadgePosition(end:1,top: 5),
            child: Icon(Icons.notifications))),
        PopupMenuButton(
          onSelected: (value) {
            if(value==data[0])
            {
              type = "all";
              credituser=getcredituser(usermodel!.id,type);
              setState(() {
                
              });
            }
            else  if(value==data[1])
            {
              type = "distributor";
              credituser=getcredituser(usermodel!.id,type);
              setState(() {
                
              });
            }
            else if(value==data[2])
            {
               type = "shopkeeper";
               credituser=getcredituser(usermodel!.id,type);
              setState(() {
                
              });
            }
          },
          itemBuilder: (context)=>[
          PopupMenuItem(value: data[0],child: const Text("All")),
          PopupMenuItem(value: data[1],child: const Text("Distributor")),
          PopupMenuItem(value: data[2],child: const Text("ShopKeeper")),
          
        ])
      ],),
      body: FutureBuilder<List<modelsignin>?>(
          future: credituser,
        builder: (BuildContext context,AsyncSnapshot<List<modelsignin>?> snapshot) {
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
                  if(snapshot.data!.isEmpty){
                    return Center(child: Text("No Buyer Has Taken Credit"));
                  }
                  return ListView.builder(
              itemCount:snapshot.data!.length,
              itemBuilder: (context,index)
              {
                return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> credituserorders(id: snapshot.data![index].id.toString(), type: snapshot.data![index].userType.toString(),)));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 180, width: MediaQuery.of(context).size.width,
                                              decoration:  BoxDecoration(
                                                color: Color.fromARGB(255, 232, 232, 232),
                                                borderRadius: BorderRadius.all(Radius.circular(15))
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: 100,width: 100,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                                            image: DecorationImage(image: NetworkImage(userimage +snapshot.data![index].uimage),fit: BoxFit.cover)
                                                          ),
                                                        ),
                                                        SizedBox(width: 30,),
                                                        Container(
                                                          height: 100,
                                                        width:  150,
                                                        child: Column( 
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Name: "+snapshot.data![index].uname.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                            SizedBox(height: 5,),
                                                            Text("City: "+snapshot.data![index].ucity.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                            SizedBox(height: 5,),
                                                            Text("UserType: "+snapshot.data![index].userType.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                            SizedBox(height: 5,),
                                                            Text("Remaining Credit: "+snapshot.data![index].remaining_credit.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                            SizedBox(height: 5,),
                                                            showRating(rating: snapshot.data![index].rating.toDouble()),
                                                             
                                                            
                                                          ],
                                                        ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    GestureDetector(
                                                    onTap: () async{
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> pymentsDetails(sid: usermodel!.id,bid:snapshot.data![index].id,)));
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 300,
                                                      decoration:  BoxDecoration(
                                                    color: Color.fromARGB(255, 26, 25, 25),
                                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                                      ),
                                                      child: Center(child: Text("View Payments",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),)),
                                                    ),
                                                  ),
                                                  
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                
              }
            );
                }
                
              }
   return Center(child: CircularProgressIndicator());
  }
  )


    
    );
  }
}