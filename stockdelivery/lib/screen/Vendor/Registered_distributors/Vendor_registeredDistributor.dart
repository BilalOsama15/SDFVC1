import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/Vendors_distributor.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/mywidget/usertypeDropDown.dart';

import '../../../models/lists.dart';
import '../../../mywidget/Mywidget.dart';
import 'Vendor_RegisterDistributordetails.dart';
class Rdistributors extends StatefulWidget {
  const Rdistributors({Key? key}) : super(key: key);

  @override
  State<Rdistributors> createState() => _RdistributorsState();
}
  var _formKey=GlobalKey<FormState>();
TextEditingController security=TextEditingController();
TextEditingController status=TextEditingController();
class _RdistributorsState extends State<Rdistributors> {
 String us ="all";
 bool isreadonly = false;
  String stat="pending";
  var data = [
    "pending",
    "active",
    "block"
  ];
  @override
  void initState() {
    super.initState();
   distributor= getdistributorsforapply(usermodel!.id,stat,us);
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Register Distributer"),
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            if(value==data[0])
            {
              stat=value.toString();
              isreadonly = false;
            distributor= getdistributorsforapply(usermodel!.id,stat,us);
            setState(() {
              
            });
              print(value);
              
            }
            else if(value==data[1])
            {
              stat=value.toString();
              isreadonly = true;
              distributor= getdistributorsforapply(usermodel!.id,stat,us);
            setState(() {
               
            });
              print(value);
            }
            else if(value==data[2])
            {
              stat=value.toString(); 
              isreadonly = true;
              distributor= getdistributorsforapply(usermodel!.id,stat,us);
            setState(() {
                           
            });
              print(value);
            }
          },
          itemBuilder: (context)=>[
          PopupMenuItem(value: data[0],child: Text("Pending")),
          PopupMenuItem(value: data[1],child: Text("Active")),
          PopupMenuItem(value: data[2],child: Text("Block")),
          
        ])
      ],),
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
                      us="all";
                      distributor= getdistributorsforapply(usermodel!.id,stat,us);
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      height: 30,width: 100,
                      decoration: BoxDecoration(
                        color:us=="all"?Colors.amber: Color.fromARGB(255, 255, 235, 174),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                      ),
                      alignment: Alignment.center,
                      child: Text("All"),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                     onTap: (){
                      us="distributor";
                      distributor= getdistributorsforapply(usermodel!.id,stat,us);
                      setState(() {
                      });
                    },
                    child: Container(
                      height: 30,width: 100,
                      decoration: BoxDecoration(
                        color:us=="distributor"?Colors.amber: Color.fromARGB(255, 255, 235, 174),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                      ),
                      alignment: Alignment.center,
                      child: Text("Distributor"),
                    ),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      us="shopkeeper";
                      distributor= getdistributorsforapply(usermodel!.id,stat,us);
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      height: 30,width: 100,
                      decoration: BoxDecoration(
                        color:us=="shopkeeper"?Colors.amber: Color.fromARGB(255, 255, 235, 174),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                      ),
                      alignment: Alignment.center,
                      child: Text("Shopkeeper"),
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
                                    title: Text("Edit Distributors"),
                                        actions: [
                                        TextFormField(controller: security,
                                          validator: (value){
                                                          if(value==null || value.isEmpty) {
                                                            return "Field Cannot be empty";
                                                          }

                                                          return null;},
                                          
                                          keyboardType:TextInputType.number ,
                                          style:TextStyle(height: 1),
                                          strutStyle: StrutStyle(height: 0.5),
                                          readOnly: isreadonly,
                                          decoration: InputDecoration(label: Text("Enter Security Amt"),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),gapPadding: 10.0),
                                          prefixIcon: Icon(Icons.security))
                                          ),                                                     
                                    SizedBox(height: 20,),
                                    DropdownButtonFormField(items: data.map((String category) {
      validator: (value){
                        if(value==null || value.isEmpty) {
                            return "Field Cannot be empty";
                        }
                        return null;};
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
                                          if(newvalue=="Active" || newvalue=="Block")
                                            {
                                             isreadonly=true; 
                                            }
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
                                            await vd.updatedistributorfordistribution(status.text.toString(),security.text.toString(),usermodel!.id.toString(),snapshot.data![index].id.toString());
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