import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_Drawer.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_credit/CreditOrder_details.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_credit/Notifications.dart';

import '../../../methods/apicalling.dart';
import '../../../models/signin.dart';
import '../../../mywidget/Mywidget.dart';
import '../../../mywidget/show_Rating.dart';
import '../../Vendor/Credit_management/checkcreditbuyerorders.dart';
import '../../Vendor/Credit_management/payments_details.dart';


class Distributorcredit extends StatefulWidget {
  const Distributorcredit({Key? key}) : super(key: key);

  @override
  State<Distributorcredit> createState() => _DistributorcreditState();
}

class _DistributorcreditState extends State<Distributorcredit> {
    TextEditingController payment = TextEditingController();
  var data = [
      "all",
      "vendor",
      "shopkeeper",
    ];
    String type="all";
    @override
  void initState() {
    credituser = getcredituserfordistributor(usermodel!.id,type);
       NotificationLen= getNotificationLength(usermodel!.id,"distributor");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Users"),centerTitle: true,
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Distributor_Notifications()));
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
              credituser=getcredituserfordistributor(usermodel!.id,type);
              setState(() {
                
              });
            }
            else if(value==data[1])
            {
               type = "vendor";
               credituser=getcredituserfordistributor(usermodel!.id,type);
              setState(() {
                
              });
            }
             else if(value==data[2])
            {
               type = "shopkeeper";
               credituser=getcredituserfordistributor(usermodel!.id,type);
              setState(() {
                
              });
            }
          },
          itemBuilder: (context)=>[
                      PopupMenuItem(value: data[0],child: const Text("All")),
          PopupMenuItem(value: data[1],child: const Text("Vendor")),
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
                    return Center(child: Text("No Credit Details"));
                  }
                  return ListView.builder(
              itemCount:snapshot.data!.length,
              itemBuilder: (context,index)
              {
                return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> credit_Order_details_distributor(id: snapshot.data![index].id, btype:snapshot.data![index].userType.toString() ,)));
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
                                                            Text("Remaining Credit: ${snapshot.data![index].remaining_credit}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                                            SizedBox(height: 5,),
                                                            showRating(rating: snapshot.data![index].rating.toDouble()),
                                                            
                                                          ],
                                                        ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10,),
                                                  snapshot.data![index].userType=="shopkeeper"?
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        GestureDetector(
                                                    onTap: () async{
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> pymentsDetails(sid: usermodel!.id,bid:snapshot.data![index].id,)));
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 300,
                                                      decoration:  BoxDecoration(
                                                        color: Color.fromARGB(255, 17, 17, 17),
                                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                                      ),
                                                      child: Center(child: Text("View Payments",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),)),
                                                    ),
                                                  ),
                                                  
                                                      ],
                                                    )  :Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        GestureDetector(
                                                    onTap: () async{
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> pymentsDetails(sid: snapshot.data![index].id,bid: usermodel!.id,)));
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 150,
                                                      decoration:  BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
                                                      ),
                                                      child: Center(child: Text("View Payments",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),)),
                                                    ),
                                                  ),
                                                   
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await showDialog(context: context, builder: (context)
                                                      {
                                                        return AlertDialog(
                                                          title: Text("Add Payment"),
                                                          content: loginTextField(controller: payment,text: "Enter Payment",icon: Icons.payment,type: TextInputType.number),
                                                          actions: [
                                                            TextButton(onPressed: (){
                                                              Navigator.of(context).pop();
                                                            }, child: Text("Cancel")),
                                                            TextButton(onPressed: () async {
                                                              showLoader(context);
                                                            int status = await P_api.AddNotification(snapshot.data![index].id.toString(),usermodel!.id.toString(),payment.text.toString());
                                                              hideLoader(context);
                                                              Navigator.of(context).pop();
                                                            }, child: Text("Send")),
                                                          ],
                                                        );
                                                      }
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 150,
                                                      decoration: const BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15))
                                                      ),
                                                      child: Center(child: Text("Add Payment",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                                                    ),
                                                  ),
                                                      ],
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