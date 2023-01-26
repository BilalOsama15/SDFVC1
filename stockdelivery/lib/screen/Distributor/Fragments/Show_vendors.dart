import 'package:flutter/material.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_Drawer.dart';
import '../../../methods/apicalling.dart';
import '../../../models/lists.dart';
import '../../../models/users.dart';
import '../../../mywidget/Mywidget.dart';
import '../Show_vendos/Distributor_Vendor_details.dart';
class Show_vendor extends StatefulWidget {
  const Show_vendor({ Key? key }) : super(key: key);

  @override
  State<Show_vendor> createState() => _Show_vendorState();
}
class _Show_vendorState extends State<Show_vendor> {
  double rating=0.0;
  @override
  void initState() {
    super.initState();
  vendors= getvendors(usermodel!.id.toString());
  }
  // Method For Getting Category wise..
   getcategoryvendors(cate)
    {
     vendors=getcategory(usermodel!.id.toString(),cate);
       setState(() {
       });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Distributor Dashboard"),
      drawer: Dis_drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Text("Category",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height:20),
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
                    onTap: () {
                       getcategoryvendors("Snacks");
                        },
                    child: categorycontainer("https://cdn-icons-png.flaticon.com/512/3050/3050153.png", "Snacks")),
                     SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                       getcategoryvendors("Sweets");
                        },
                    child: categorycontainer("https://cdn-icons-png.flaticon.com/512/3050/3050153.png", "Sweets")),
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
            Text("Vendors",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black),),
            SizedBox(height: 20,),
            Container(
              height: 380,
              child: FutureBuilder<List<modelsignin>?>
              (future: vendors,
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
                      return Center(child: Text("No Vendors To Show"));
                    }
                    else
                    {
                      return ListView.builder(
                itemCount: snapshot.data!.length ,
                itemBuilder: (context,index)
              {
                
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dis_Ven_Detail(m: snapshot.data![index])));
                      },
                      leading: Container(
                        height:50,width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                          image: NetworkImage(userimage+snapshot.data![index].uimage),fit: BoxFit.cover)),),
                    title: Text(snapshot.data![index].uname.toString(),style: TextStyle(fontWeight: FontWeight.w600),),
                    subtitle: Text(snapshot.data![index].ucity.toString()+"\n"+snapshot.data![index].userType.toString()),
                    trailing: showRating(rating: rating)
                  
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
              
              
            )
      
          ],),
        ),
      ),
       
    );
  }
}

