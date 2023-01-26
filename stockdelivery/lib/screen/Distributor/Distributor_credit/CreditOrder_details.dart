import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/screen/Vendor/Credit_management/Credit_orderDetail.dart';

import '../../../methods/apicalling.dart';
import '../../../models/userorders.dart';
import '../../../mywidget/Mywidget.dart';
import '../../Vendor/Credit_management/payments_details.dart';

class credit_Order_details_distributor extends StatefulWidget {
  final int id;
  final String btype;
  const credit_Order_details_distributor({Key? key,required this.id, required this.btype }) : super(key: key);

  @override
  State<credit_Order_details_distributor> createState() => _credit_Order_details_distributorState(id,btype);
}

class _credit_Order_details_distributorState extends State<credit_Order_details_distributor> {
  int id;
  String btype;
  _credit_Order_details_distributorState(this.id,this.btype);
  
    
    bool color=false;
    @override
  void initState() {
    credituserorder= creditusersordersfordistributor(id.toString(),btype,usermodel!.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text("Vendor Credits"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 670,
              child: FutureBuilder<List<userorders>?>(
                                future: credituserorder,
                                builder: (BuildContext context,AsyncSnapshot<List<userorders>?> snapshot){
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
                                         // int state = int.parse(snapshot.data![index].order_state.toString());
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                               Navigator.push(context, MaterialPageRoute(builder: (context) =>  C_O_D(userorder: snapshot.data![index], uType: btype,)));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 100, width: MediaQuery.of(context).size.width,
                                              decoration:  BoxDecoration(
                                                color: Color.fromARGB(255, 232, 232, 232),
                                                borderRadius: BorderRadius.all(Radius.circular(15))
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:  [
                                                        Container(width: 70, child: Text("Order Id:\n"+snapshot.data![index].id.toString(),textAlign: TextAlign.center,)),
                                                        SizedBox(width: 40,),
                                                        Container(width: 70, child: Text("Order Type:\n"+snapshot.data![index].order_type.toString(),textAlign: TextAlign.center)),
                                                        SizedBox(width: 40,),
                                                        Container(width: 100, child: Text("Order Amount:\n"+snapshot.data![index].total_amount.toString(),textAlign: TextAlign.center)),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                         Container(width: 150, child: Text("Place Date:\n"+(snapshot.data![index].order_place_date!).toString(),textAlign: TextAlign.center)),                                                        
                                                         Container(width: 150, child: Text("Deliver Date:\n"+(snapshot.data![index].order_deliver_date!).toString(),textAlign: TextAlign.center)),                                                        
                                                       
                                                       
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      );
                                      }
                                      
                                    }
                                  }
                                  return const Text("Something Not Good");
                                }),
            ),
          ],
        ),
      ),
   );
  }
}
