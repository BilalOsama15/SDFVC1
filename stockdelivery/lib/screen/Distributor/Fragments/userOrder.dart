import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../methods/apicalling.dart';
import '../../../models/signin.dart';
import '../../../mywidget/show_Rating.dart';
import '../Distributor_orders/Distributer_orders.dart';

class User_order_dist extends StatefulWidget {
  const User_order_dist({Key? key}) : super(key: key);

  @override
  State<User_order_dist> createState() => _User_order_distState();
}

class _User_order_distState extends State<User_order_dist> {
  var data = [
      "All",
      "Vendor",
      "ShopKeeper",  
    ];
    String type="all";
  @override
  void initState() {
    credituser=getOrderUsersdistributor(usermodel!.id,type);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Users"),centerTitle: true,
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            if(value==data[0])
            {
              type = "all";
              credituser=getOrderUsersdistributor(usermodel!.id,type); 
                           setState(() {
                
              });
            }
            else if(value==data[1])
            {
              type = "vendor";
              credituser=getOrderUsersdistributor(usermodel!.id,type); 
                           setState(() {
                
              });
            }
            else if(value==data[2])
            {
               type = "shopkeeper";
               credituser=getOrderUsersdistributor(usermodel!.id,type);
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
                    return Center(child: Text("No Buyer Has Place Order"));
                  }
                  return ListView.builder(
              itemCount:snapshot.data!.length,
              itemBuilder: (context,index)
              {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      onTap: (){
                       
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Distributor_orders(id: snapshot.data![index].id, type: snapshot.data![index].userType.toString(),)));
                      },
                      leading:Container(
                        height:50,width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                          image: NetworkImage(userimage+snapshot.data![index].uimage),fit: BoxFit.cover)
                      ),
                      ),
                      title: Text(snapshot.data![index].uname.toString()),
                      subtitle: Text(snapshot.data![index].ucity.toString()+"\n"+snapshot.data![index].userType.toString()),
                      trailing: showRating(rating: snapshot.data![index].rating.toDouble(),)
                    ),
                  ),
                  ),
                );
              }
            );
                }
                
              }
   return Center(child: Text("Something Wrong"));
  }
  )
    );
  }
}