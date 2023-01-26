import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/apisetget/ShopkeeperAPI/providerList.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';

import '../../methods/apicalling.dart';
import '../../models/signin.dart';
import '../Vendor/Registered_distributors/Vendor_RegisterDistributordetails.dart';

class showapplyShopkeeper extends StatefulWidget {
  const showapplyShopkeeper({Key? key}) : super(key: key);

  @override
  State<showapplyShopkeeper> createState() => _showapplyShopkeeperState();
}
 var _formKey=GlobalKey<FormState>();
TextEditingController security=TextEditingController();
TextEditingController status=TextEditingController();
class _showapplyShopkeeperState extends State<showapplyShopkeeper> {
  String stat="active";
  var data = [
    "active",
    "block"
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    distributor = registershopkeeper(usermodel!.id,stat);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Shopkeeper"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  InkWell(
                     onTap: (){
                      stat="active";
                      distributor= registershopkeeper(usermodel!.id,stat);
                      setState(() {
                      });
                    },
                    child: Container(
                      height: 30,width: 100,
                      decoration: BoxDecoration(
                        color:stat=="active"?Colors.amber: Color.fromARGB(255, 255, 235, 174),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                      ),
                      alignment: Alignment.center,
                      child: Text("Active"),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      stat="block";
                      distributor= registershopkeeper(usermodel!.id,stat);
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      height: 30,width: 100,
                      decoration: BoxDecoration(
                        color:stat=="block"?Colors.amber: Color.fromARGB(255, 255, 235, 174),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                      ),
                      alignment: Alignment.center,
                      child: Text("Block"),
                    ),
                  ),
                  
                ],
              ),
            ),
            SizedBox(height: 12,),
            Container(
              height: MediaQuery.of(context).size.height - 160,
              child: FutureBuilder<List<modelsignin>?>(
                future: distributor,
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
                          return Center(child: Text("No Buyer Will Apply"));
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  D_details(mdetail: snapshot.data![index])));
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
                            trailing: IconButton(onPressed: () async {
                              await showDialog(context: context, builder: (builder){
                                return Form(
                                  key: _formKey,
                                  child: AlertDialog(
                                    title: Text("Update Shopkeeper Status"),
                                        actions: [
                                                                                          
                                    SizedBox(height: 20,),
                                    DropdownButtonFormField(items: data.map((String category) {
                                    validator: (value){
                                    if(value==null || value.isEmpty) {
                                        return "Field Cannot be empty";
                                    }
                                    return null;
                                    };
                                return new DropdownMenuItem(
                                  value: category,
                                  child: Row(
                                  children: <Widget>[
                                            Text(category),
                                        ],)
                                    );
                                }).toList(),
                                onChanged: (newvalue)
                                        {  
                                          
                                          status.text=newvalue.toString();
                                        setState(() {   }
                                        );
                                },
                                    decoration: InputDecoration(label: Text("Select Status"),
                                    prefixIcon: Icon(Icons.select_all),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),gapPadding: 10.0),
                                    focusColor: Colors.white
                                    ),
                                    focusColor: Colors.white,
                                ),
                                    SizedBox(height: 20,),
                                    Row(children: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Cancel")),
                                    TextButton(onPressed: ()async{
                                        if(_formKey.currentState!.validate())
                                        {
                                            await R_S.updateShopkeeperstatus(usermodel!.id,snapshot.data![index].id,stat);
                                            setState(() {
                                          Navigator.pop(context);
                                        });
                                      
                                        }
                                       
                                        
                                
                                
                                    }, child: Text("Okay")),

                                    
                                    ],),
                                      
                                  
                                                         ],
                                                         
                                  ),
                                );
                                    

                                });
                            }, icon: Icon(Icons.change_circle)),
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
  ),
            ),
          ],
        )


    ),
      
    );
  }
}