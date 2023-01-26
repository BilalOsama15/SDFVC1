import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../methods/apicalling.dart';
import '../../models/Db_helper.dart';
import '../../models/cart_provider.dart';
import '../../models/products.dart';
import '../Distributor/Distributor_Vendors/Dis_ven_products_detail.dart';
import '../Distributor/add_tocart_button.dart';
import '../Distributor/cartScreen.dart';

class addtocartDistributor extends StatefulWidget {
    final int id;
  const addtocartDistributor({Key? key, required this.id}) : super(key: key);

  @override
  State<addtocartDistributor> createState() => _addtocartDistributorState(id);
}

class _addtocartDistributorState extends State<addtocartDistributor> {
   int id;
  _addtocartDistributorState(this.id);
  DBHelper db=DBHelper();
  @override
  void initState() {
     db.deleteall();
    distributorproducts= getdatafordistributor(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(centerTitle: true,title: Text("Distributor Products"),actions: [
         IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(seller_id: id,)));
        }, icon: Icon(Icons.shopping_cart))
        //  Badge(badgeContent: Consumer<cartprovider>(
        //   builder: ((context, value, child) {
        //     return Text(value.getCounter().toString(),
        //     style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.bold),);
        //   }),
           
        //  ),
        // child: IconButton(onPressed: () {
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(seller_id: id,)));
        // }, icon: Icon(Icons.shopping_cart)),padding: EdgeInsets.all(5),position: BadgePosition(end: 2,top: 2), )
        
    ]
    ),
    body:FutureBuilder<List<products>?>(
      future: distributorproducts,
      builder: (BuildContext context, AsyncSnapshot<List<products>?> snapshot){
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
                    return Center(child: Text("No Products Available"));
                  }
                  else
                  {
                    return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: ((context, index){
          var item = snapshot.data![index];
        return Padding(
          padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
          child: InkWell(
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Dis_ven_product_detail(p:snapshot.data![index])));
            },
            child: Container(
              height: 140, width:300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(image: NetworkImage(productimage+snapshot.data![index].pimage),fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(item.pname.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.red),)),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 110,
                          child: Text(item.saleprice_per_carton.toString()+" P.C",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),)),
                        
                       ],),
                       SizedBox(height:10),
                       Row(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          child: Text("Available Cartons",style: TextStyle(fontSize: 12,)),),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 90,
                          child: Text(item.total_no_of_cartons.toString(),style: TextStyle(fontSize: 12,),)),
                        
                       ],),
                       SizedBox(height: 5,),
                       Row(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          child: Text("Qty Per Carton",style: TextStyle(fontSize: 12,)),),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 90,
                          child: Text(item.quantitypercarton.toString(),style: TextStyle(fontSize: 12,),)),
                        
                       ],),
                       addtocart_button(p: item)
          
                       
                    ],
                  )
                ],),
              ),
            
            ),
          )

        );
      }));
                  }
                    
                }
              
              }
              return Center(child: CircularProgressIndicator());
            }
    )
    );
  }
}