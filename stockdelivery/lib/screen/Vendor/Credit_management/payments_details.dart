import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/apisetget/VendorsAPI/paymentAPI.dart';
import 'package:stockdelivery/models/payments.dart';
import 'package:stockdelivery/models/userorders.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';

import '../../../methods/apicalling.dart';

class pymentsDetails extends StatefulWidget {
  final int sid;
  final int bid;
  const pymentsDetails({Key? key,required this.sid, required this.bid}) : super(key: key);

  @override
  State<pymentsDetails> createState() => _pymentsDetailsState(sid,bid);
}

class _pymentsDetailsState extends State<pymentsDetails> {
  _pymentsDetailsState(this.sid,this.bid);
  int? sid,bid;
  bool chk=false;
  String? total_paid,remaining_amount;

  @override
  void initState() {
      paymen = getpayments(sid.toString(),bid.toString());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("User Payments Details"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Payment?>(
          future: paymen,
          builder: (BuildContext context,AsyncSnapshot<Payment?> snapshot) {
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
                                        if(snapshot.data!.pay!.isEmpty ||snapshot.data!.pay==null)
                                        {
                                          return Center(child: Text("Nothing To Show"));
                                        }
                                        else
                                        {
                                          return Column(
                                            children: [
                                               Container(
                                                height: 50, width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 10,),
                                                    Text("Total Paid Amount\n${snapshot.data!.total_paid}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,height: 1.5,color: Color.fromARGB(255, 1, 116, 209)),textAlign: TextAlign.center,),SizedBox(width: 20,),
                                                    Text("Remaining Credit\n${snapshot.data!.remaining_amount}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,height: 1.5,color: Color.fromARGB(255, 1, 152, 6)),textAlign: TextAlign.center,),SizedBox(width: 20,),
                                                    
                                                  ],
                                                ),
                                              ),
                                            
                                              SizedBox(height: 10,),
                                              Container(
                                                    height: 30,
                                                    color: Color.fromARGB(255, 236, 236, 236),
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Row(
                                                        children: [
                                                
                                                  Container(
                                                      alignment: Alignment.center,
                                                      height: 30, width: 70,child:Text("Sr.No",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                                  ),
                                                  Container(
                                                      alignment: Alignment.center,
                                                      height: 30, width: 130,child:Text("Payment Date",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                                                  ),
                                                  Container(
                                                      alignment: Alignment.center,
                                                      height: 30, width: 130,child:Text("Payment Amount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                                                  ),
                                                ],
                                              ),
                                                    ),
                                                    
                                                  ),
                                              
                                              Divider(),

                                              Container(
                                                height: 550,
                                                child: ListView.builder(
                                                itemCount: snapshot.data!.pay!.length,
                                                itemBuilder: (context, index){
                                                  
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 6,right: 6),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children:  [
                                                            Container(
                                                            alignment: Alignment.center,
                                                            height: 30, width: 70,child:Text(((index)+1).toString())
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,            
                                                            height: 30, width: 130,child:Text(snapshot.data!.pay![index].payment_date.toString())
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            height: 30, width: 130,child:Text(snapshot.data!.pay![index].paid_amount.toString())
                                                          ),
                                                           
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Divider()
                                                  ],
                                                );
                                        },
                                        ),
                                              ),
                                            ],
                                          );
                                        }
                                        
                                      }
                                    }
                                    return const Text("Something Not Good");
        },),
      )
    );
  }
}