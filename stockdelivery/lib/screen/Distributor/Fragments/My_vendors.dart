import 'package:flutter/material.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/mywidget/usertypeDropDown.dart';

import '../../../methods/apicalling.dart';
import '../../../models/signin.dart';
import '../../../mywidget/Mywidget.dart';
import '../Distributor_Drawer.dart';
import '../Distributor_Vendors/Dis_Vendor_details.dart';
class My_vendors extends StatefulWidget {
  const My_vendors({Key? key}) : super(key: key);

  @override
  State<My_vendors> createState() => _My_vendorsState();
}
class _My_vendorsState extends State<My_vendors> {
  String stat="Active";
  void initState() {
    super.initState();
  vendorsfororder= statusvendors(usermodel!.id.toString(),stat);
  }
  @override
  Widget build(BuildContext context) {
    var data = [
      "Pending",
      "Active",
      "Block"
    ];
    TextEditingController _filter = TextEditingController();
     getcategoryvendors(cate)
    {
     vendorsfororder=getcategorymyvendors(usermodel!.id.toString(),stat,cate);
       setState(() {
       });
    }


    return Scaffold(
      appBar: AppBar(title: Text("My Vendors"),
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            if(value==data[0])
            {
            vendorsfororder= statusvendors(usermodel!.id.toString(),data[0]);
            setState(() {
              stat=value.toString();
            });              
            }
            else if(value==data[1])
            {
              vendorsfororder= statusvendors(usermodel!.id.toString(),data[1]);
            setState(() {
               stat=value.toString();
            });
            }
            else if(value==data[2])
            {
              vendorsfororder= statusvendors(usermodel!.id.toString(),data[2]);
            setState(() {
              stat=value.toString();              
            });
            }
          },
          itemBuilder: (context)=>[
          PopupMenuItem(value: data[0],child: Text("Pending")),
          PopupMenuItem(value: data[1],child: Text("Active")),
          PopupMenuItem(value: data[2],child: Text("Block")),
          
        ])
      ],
      
      ),
      drawer: Dis_drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            SizedBox(height: 10,),
            Text("Category",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      getcategoryvendors("Dairy");
                      },
                    child: categorycontainer("https://cdn-icons-png.flaticon.com/512/3050/3050158.png", "Dairy")),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                       getcategoryvendors("Drinks");
                        },
                    child: categorycontainer("https://cdn-icons-png.flaticon.com/512/3050/3050153.png", "Drinks")),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      getcategoryvendors("Frozen");
                    
                    },
                    child: categorycontainer("https://icon-library.com/images/frozen-food-icon/frozen-food-icon-3.jpg", "Frozen")),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      getcategoryvendors("Daily Usage");                    
                    },
                    child: categorycontainer("https://cdn4.vectorstock.com/i/1000x1000/95/83/food-products-icon-vector-28759583.jpg", "Daily Usage")),
                  SizedBox(width: 10,),  
                  InkWell(
                    onTap: (){
                      getcategoryvendors("Others");                    
                    },
                    child: categorycontainer("http://ashrafifoods.pk/wp-content/uploads/2018/09/other-products-1.png", "Others")),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text(stat+" Vendors",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 20,),
            SingleChildScrollView(
              child: Container(
                height: 535,
                child: FutureBuilder<List<modelsignin>?>
                (future: vendorsfororder,
                builder: (BuildContext context,AsyncSnapshot<List<modelsignin>?> snapshot)
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
                        return Center(child: Text("No " + stat +" Vendors"));
                      }
                      else{
                        return ListView.builder(
                  itemCount: snapshot.data!.length ,
                  itemBuilder: (context,index)
                {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dis_vendor_detail(user: snapshot.data![index],status: stat,)));
                        },
                        leading: Container(
                            height:50,width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              image: DecorationImage(
                              image: NetworkImage(userimage+snapshot.data![index].uimage),fit: BoxFit.cover)),),
                      title: Text(snapshot.data![index].uname.toString()),
                      subtitle: Text(snapshot.data![index].ucity.toString()+"\n"+snapshot.data![index].userType.toString()),
                      trailing: showRating(rating: snapshot.data![index].rating.toDouble()),
                    
                      ),
                    ),
                  );
                });      
                      }
                                    
                    }
                  
                  }
                  return Center(child: CircularProgressIndicator());
                }
                )
                
                
              ),
            )
      
          ],),
        ),
      ),
       
    );
  }
}
