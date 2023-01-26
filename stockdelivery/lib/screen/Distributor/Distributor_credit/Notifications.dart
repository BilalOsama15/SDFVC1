import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../methods/apicalling.dart';
import '../../../models/PaymentNotification.dart';

class Distributor_Notifications extends StatefulWidget {
  const Distributor_Notifications({Key? key}) : super(key: key);

  @override
  State<Distributor_Notifications> createState() => _Distributor_NotificationsState();
}

class _Distributor_NotificationsState extends State<Distributor_Notifications> {
   void initState() {
    paymentNotification= getnotificationsfordistributor(usermodel!.id.toString(),data[0]);
    super.initState();
  }
  var data = [
      "request",
      "accept",
      "decline",
    ];
    String? status="request" ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Users"),centerTitle: true,
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            if(value==data[0])
            {
              status = "request";
    paymentNotification= getnotificationsfordistributor(usermodel!.id.toString(),data[0]);
              setState(() {
                
              });
            }
            else if(value==data[1])
            {
              status = "accept";
    paymentNotification= getnotificationsfordistributor(usermodel!.id.toString(),data[1]);
              setState(() {
                
              });
            }
             else if(value==data[2])
            {
              status = "decline";
    paymentNotification= getnotificationsfordistributor(usermodel!.id.toString(),data[2]);
              setState(() {
                
              });
            }
          },
          itemBuilder: (context)=>[
          PopupMenuItem(value: data[0],child: const Text("Request")),
          PopupMenuItem(value: data[1],child: const Text("Accept")),
          PopupMenuItem(value: data[2],child: const Text("Decline")),
          
        ])
      ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           Text(status.toString().toUpperCase(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
           SizedBox(height: 10,),
            Container(
              height: 600,
            
              child: FutureBuilder<List<PaymentNotification>?>(
                future: paymentNotification,
                builder: (BuildContext context,AsyncSnapshot<List<PaymentNotification>?> snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting)
                                          {
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          else if(snapshot.connectionState==ConnectionState.done)
                                          {
                                            if(snapshot.hasError)
                                            {
                                              return const Center(child: Text("Snapshot Error"),);
                                            }
                                            else if(snapshot.hasData)
                                            {
                                              if(snapshot.data!.isEmpty)
                                              {
                                                return Center(child: Text("Nothing To Show"));
                                              }
                                              else
                                              {
                                                return ListView.builder(
                                                itemCount: snapshot.data!.length,
                                                itemBuilder: (context, index){
                                                  return snapshot.data![index].buyerType.toString()=="vendor"?Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      height: 100,width: MediaQuery.of(context).size.width,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                        color: Color.fromARGB(255, 236, 236, 236),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Text(snapshot.data![index].buyerType.toString().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
                                                              Text(snapshot.data![index].payDate.toString() ,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),),
                                            
                                                            ],
                                                          ),
                                                          Container(height: 30,width: 250,
                                                          alignment: Alignment.center,
                                                          child: Text("You Have Send ${snapshot.data![index].payAmount}Rs/- to ${snapshot.data![index].buyerName}",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              GestureDetector(
                                                                
                                                              onTap: () async {
                                                                if(snapshot.data![index].status=="request")
                                                                {
                                                                  showSnackBar(context, "Not Clear", Colors.red);
                                                                }
                                                                else
                                                                {
                                                                  showLoader(context);
                                                                int statusz =  await P_api.clearNotification(snapshot.data![index].nid.toString());
                                                                  statusz==200?showSnackBar(context, "Notification Clear", Colors.green):showSnackBar(context, "Not Clear", Colors.red);
                                                                  hideLoader(context);
                                                                }
                                                                },
                                                                child: Container(
                                                                  height: 25,width: 150,
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                    color:snapshot.data![index].status=="request"? Color.fromARGB(255, 185, 185, 185):Color.fromARGB(255, 20, 20, 20)
                                                                  ),
                                                                  child: Text("Clear Notification",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                                                                ),
                                                              ),
                                                              
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ):Container(
                                                    height: 100,width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      color: Color.fromARGB(255, 236, 236, 236),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Text(snapshot.data![index].buyerType.toString().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w300),),
                                                            Text(snapshot.data![index].payDate.toString() ,style: TextStyle(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w300),),
                                                            
                                                          ],
                                                        ),
                                                        Container(height: 30,width: 250,
                                                        alignment: Alignment.center,
                                                        child: Text("${snapshot.data![index].buyerName} Has Send You ${snapshot.data![index].payAmount}Rs/-",style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.bold)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                showLoader(context);
                                                              int status =  await P_api.UpdateStatusNotification(snapshot.data![index].nid.toString(),"decline");
                                                                status==200?showSnackBar(context, "Notification Status Decline", Colors.green):showSnackBar(context, "Not Declined", Colors.red);
                                                                hideLoader(context);
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                height: 25,width: 130,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                  color:status=="request"? Colors.red:Color.fromARGB(255, 185, 185, 185)
                                                                ),
                                                                child: Text("Decline",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
                                                              ),
                                                            ),
                                                            SizedBox(width: 20,),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                showLoader(context);
                                                              int status =  await P_api.addPayment(usermodel!.id.toString(),snapshot.data![index].id.toString(),snapshot.data![index].payAmount.toString(),snapshot.data![index].payDate.toString());
                                                                status==200?showSnackBar(context, "Payment Added", Colors.green):showSnackBar(context, "Payment Not Added", Colors.red);
                                                                hideLoader(context);
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                height: 25,width: 130,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                  color:status=="request"? Color.fromARGB(255, 0, 169, 53):Color.fromARGB(255, 185, 185, 185)
                                                                ),
                                                                child: Text("Accepted",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                // return Column(
                                                //   children: [
                                                //     GestureDetector(
                                                //       onTap: () {
                                                //       },
                                                //       child: Padding(
                                                //         padding: const EdgeInsets.only(left: 6,right: 6),
                                                //         child: Row(
                                                //           mainAxisAlignment: MainAxisAlignment.center,
                                                //           children:  [
                                                //             Container(
                                                //             alignment: Alignment.center,
                                                //             height: 30, width: 70,child:Text(((index)+1).toString())
                                                //           ),
                                                //           Container(
                                                //             alignment: Alignment.center,            
                                                //             height: 30, width: 130,child:Text(snapshot.data![index].payment_date.toString())
                                                //           ),
                                                //           Container(
                                                //             alignment: Alignment.center,
                                                //             height: 30, width: 130,child:Text(snapshot.data![index].paid_amount.toString())
                                                //           ),
                                                           
                                                //           ],
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     Divider()
                                                //   ],
                                                // );
                                              },
                                              );
                                              }
                                              
                                            }
                                          }
                                          return const Text("Something Not Good");
              },),
            )
          ],),
        ),
      )
    );
  }
}