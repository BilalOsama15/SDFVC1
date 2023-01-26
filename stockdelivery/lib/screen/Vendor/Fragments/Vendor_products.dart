import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stockdelivery/apisetget/VendorsAPI/ProductApis.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';
import 'package:stockdelivery/screen/Vendor/Vendor_drawer.dart';
import 'package:stockdelivery/screen/Vendor/add_Update_products/productupdation.dart';
import '../../../methods/apicalling.dart';
import '../../../models/products.dart';
import '../add_Update_products/Vendor_additems.dart';
import '../add_Update_products/Vendor_updateitems.dart';
class Vendor_products extends StatefulWidget {
  const Vendor_products({Key? key}) : super(key: key);

  @override
  State<Vendor_products> createState() => _Vendor_productsState();

}

class _Vendor_productsState extends State<Vendor_products> {
  bool _isGrid = false;
  @override
  void initState() {
      userproducts=  getdata(usermodel!.id);
    super.initState();
  }
    Future<void> refresh()
    async {
      setState(() {
            userproducts= getdata(usermodel!.id);
      });
    }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vendor Products"),
      actions: [
        GestureDetector(
          onTap: (){
            _isGrid = !_isGrid;
            setState(() {
              
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.filter),
          ))
      ],
      ),
      drawer: drawer(),
      floatingActionButton: FloatingActionButton(onPressed: () async {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const additems()));
           

      },child: Icon(Icons.add),),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: FutureBuilder<List<products>?>(
            
            future:userproducts,
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
                      if(_isGrid)
                      {
                        return GridView.builder(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            mainAxisExtent: 230
                            ),
                          itemCount: snapshot.data!.length,
                           itemBuilder: ((context, index) {
                             return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  maintainproduct(product: snapshot.data![index],)));
                              },
                               child: Padding(
                                 padding: const EdgeInsets.only(top: 8),
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
                                        width: 230,
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
                                                child: Text("Name :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
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
                                                child: Text("T carton :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
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
                                                child: Text("Qty P.C :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
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
                                                child: Text("Price P.C :",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
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
                               ),
                             );
                           }));
                      }
                      else
                      {
                        return ListView.builder(
                            
                          itemCount: snapshot.data!.length,
                           itemBuilder: ((context, index) {
                             return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  maintainproduct(product: snapshot.data![index],)));
                              },
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(productimage+snapshot.data![index].pimage.toString(),),fit: BoxFit.cover),
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,top: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 7,),
                                            Row(
                                              children: [
                                                Container(width: 60,
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
                                                child: Text("T Carton: ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                                ),
                                                Container(width: 110,
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
                                                Container(width: 110,
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
                                                Container(width: 110,
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
                               ),
                             );
                           }));
                      }
                      

                    }
                    
                  }
                
                }
                return CircularProgressIndicator();
            }),
        ),
      )
        
        
      
        
      
      
  );
    
  }
}

