import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_Drawer.dart';
import 'package:stockdelivery/screen/Distributor/Distributors_products/Distributor_product_details.dart';
import 'package:stockdelivery/screen/Distributor/Distributors_products/update_distributor_Pro.dart';

import '../../../models/lists.dart';
class Distributor_products extends StatefulWidget {
  const Distributor_products({Key? key}) : super(key: key);

  @override
  State<Distributor_products> createState() => _Distributor_productsState();
}

class _Distributor_productsState extends State<Distributor_products> {
  
  Future<void> refresh()
    async {
      setState(() {
            distributorproducts= getDistributorProducts(usermodel!.id);
      });
    }

    @override
  // void initState() {
      
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    distributorproducts= getDistributorProducts(usermodel!.id);
    return Scaffold(
      appBar: appbar("Distributor Products"),
      drawer: Dis_drawer(),
      body: Padding(padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex:1, child: Center(child: Text("My Products",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),))),
          Expanded(
            flex: 8,
            child: RefreshIndicator(
          onRefresh: refresh,
          child: FutureBuilder<List<products>?>(
            
            future:distributorproducts,
            builder: (BuildContext context,AsyncSnapshot<List<products>?> snapshot) {
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
                    if(snapshot.data!.isEmpty)
                    {
                      return Center(child: Text("No Product to Show"));
                    }
                    else
                    { 
                      return GridView.builder(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            mainAxisExtent: 220
                            ),
                          itemCount: snapshot.data!.length,
                           itemBuilder: ((context, index) {
                             return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  updateDistributorProduct(pro: snapshot.data![index],)));
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
                                      width: 220,
                                      decoration: BoxDecoration(
                                        
                                        image: DecorationImage(image: NetworkImage(productimage+snapshot.data![index].pimage.toString(),),fit: BoxFit.cover),
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
                                              Container(width: 50,
                                              height: 20,
                                              child: Text("Name: ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                              ),
                                              Container(width: 110,
                                              height: 20,
                                              child: Text(snapshot.data![index].pname.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                                              ),
        
                                            ],
                                          ),
                                          Divider(height:5),
                                            Row(
                                            children: [
                                              Container(width: 60,
                                              height: 20,
                                              child: Text("T carton: ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                              ),
                                              Container(width: 100,
                                              height: 20,
                                              child: Text(snapshot.data![index].total_no_of_cartons.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                                              ),
        
                                            ],
                                          ),
                                          Divider(height:5),
                                            Row(
                                            children: [
                                              Container(width: 60,
                                              height: 20,
                                              child: Text("Qty P.C: ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                              ),
                                              Container(width: 100,
                                              height: 20,
                                              child: Text(snapshot.data![index].quantitypercarton.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                                              ),
        
                                            ],
                                          ),
                                          Divider(height:5),
                                            Row(
                                            children: [
                                              Container(width: 60,
                                              height: 20,
                                              child: Text("Price P.C: ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                              ),
                                              Container(width: 100,
                                              height: 20,
                                              child: Text(snapshot.data![index].saleprice_per_carton.toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                                              ),
        
                                            ],
                                          ),
                                          Divider(height:5),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                               ),
                             );
                           }));

                    }
                    
                  }
                
                }
                return CircularProgressIndicator();
            }),
        
            ),
          )
      ]),
      ),
    );
  }
}
