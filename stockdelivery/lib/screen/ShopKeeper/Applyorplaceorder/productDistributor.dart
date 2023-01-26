import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/shopkeeperDistributor.dart';

import '../../../models/products.dart';
import '../../../models/signin.dart';
import '../../../mywidget/show_Rating.dart';
import 'distributor_Details.dart';

class product_Dis extends StatefulWidget {
    final products p;
  const product_Dis({Key? key,required this.p }) : super(key: key);

  @override
  State<product_Dis> createState() => _product_DisState();
}

class _product_DisState extends State<product_Dis> {
  
  @override
  void initState() {
  distributor_W_product =  productGetByDistributor(widget.p.id,usermodel!.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<distributor_W_products>?>
                (future: distributor_W_product,
                builder: (BuildContext context,AsyncSnapshot<List<distributor_W_products>?> snapshot)
                {
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
                        return Center(child: Text("No data"));
                      }
                      else{
                        return ListView.builder(
                  itemCount: snapshot.data!.length ,
                  itemBuilder: (context,index)
                {
                  return InkWell(
                    onTap: (){
                      var data = snapshot.data![index];
                      String? s = data.status==null ? "":data.status;
                       modelsignin m = modelsignin(data.uname, data.ucity, "", data.umobileno, data.uemail, "", data.uroles,data.uaccoutstatus);
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> distributorDetail(m:m, id: int.parse(data.uid.toString()), status: s!,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 170, width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Color.fromARGB(255, 255, 255, 255)
                        ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    image: DecorationImage(image: NetworkImage(userimage+snapshot.data![index].uimage.toString()),fit: BoxFit.cover)
                                  ),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Container(child: 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: "+snapshot.data![index].uname.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text("City: "+snapshot.data![index].ucity.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                                    SizedBox(height: 5,),
                                    Text("Mobile No: "+snapshot.data![index].umobileno.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                                    SizedBox(height: 5,),
                                    Text("Email: "+snapshot.data![index].uemail.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
                                    
                                  ],
                              ),),
                              SizedBox(width: 20,),
                              
                               
                            ],
                          ),
                          SizedBox(height: 10,),
                          Divider(thickness: 2,),
                          Container(child: 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Product Name: ${snapshot.data![index].dp!.pname.toString()}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                    SizedBox(height: 10,),
                                    Text("Product Price: ${snapshot.data![index].dp!.saleprice_per_carton.toString()}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                  
                                  ],
                              ),),
                        ],
                      ),
                  
                      //     child: ListTile(
                      //       onTap: () {
                      //      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Dis_vendor_detail(user: snapshot.data![index],status: stat,)));
                      //       },
                      //       leading: Container(
                      //           height:50,width: 50,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.all(Radius.circular(8)),
                      //             image: DecorationImage(
                      //             image: NetworkImage(userimage+snapshot.data![index].uimage.toString()),fit: BoxFit.cover)),),
                      //     title: Text(snapshot.data![index].uname.toString()),
                      //     subtitle: Text(snapshot.data![index].ucity.toString()+"\n"+snapshot.data![index].uemail .toString()),
                      //     trailing: Text("P.Name: "+snapshot.data![index].dp!.pname.toString()+"\n"+"P.Price"+snapshot.data![index].dp!.saleprice_per_carton.toString()),
                      // //  showRating(rating: snapshot.data![index].rating.toDouble()),
                      //     ),
                      ),
                    ),
                  );
                });      
                      }
                                    
                    }
                  
                  }
                  return Center(child: CircularProgressIndicator());
                }
                ),
    );
  }
}