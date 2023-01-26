import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../methods/apicalling.dart';
import '../../../models/products.dart';
import '../../../mywidget/Mywidget.dart';
import '../../ShopKeeper/Applyorplaceorder/productvendor.dart';

class S_products extends StatefulWidget {
  const S_products({Key? key}) : super(key: key);

  @override
  State<S_products> createState() => _S_productsState();
}

class _S_productsState extends State<S_products> {
  
  @override
  Widget build(BuildContext context) {
        userproducts =getallproducts();
    return Scaffold(

      appBar: appbar("Seller Products"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Banner(
                message: "20% OFF",
                location: BannerLocation.bottomEnd,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [Color.fromARGB(255, 1, 70, 126),Colors.black],
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                            SizedBox(height: 80,),
                            Text("Stock Delivery From Vendor",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text("Today 20% OFF",style: TextStyle(color: Colors.white,fontSize: 12))
                          ],),
                        ),
                        Container( 
                          width: 150,
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/bannerImage.png",height: 200,width: 200,)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Dairy",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              _container("Dairy"),
               SizedBox(height: 20,),
              Text("Drinks",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              _container("Drinks"),
              SizedBox(height: 20,),
              Text("Snacks",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
             _container("Snacks"),
               SizedBox(height: 20,),
              Text("Daily Usage",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
             _container("Daily Usage"),
              SizedBox(height: 20,),
              Text("Frozen",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
             _container("Frozen"),
             SizedBox(height: 20,),
              Text("Sweets",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
             _container("Sweets"),

              SizedBox(height: 20,),
              Text("Others",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              _container("Others")
            ],
          ),
        ),
      ),
    );
  }
   Widget _categoryproducts(String category)
  {
    return  FutureBuilder<List<products>?>(
            
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
                      List<products> pro = [];
                      for(int i=0;i<snapshot.data!.length;i++)
                      {
                        if(snapshot.data![i].category==category)
                        {
                          pro.add(snapshot.data![i]);
                        }
                      }
                        return GridView.builder(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            crossAxisCount: 1,
                            mainAxisExtent: 150
                            ),
                          itemCount: pro.length,
                           itemBuilder: ((context, index) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: (() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => product_Ven(p: pro[index], state: "distributor",)));
                                    }),
                                    child: Container(
                                      height: 110,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                      child: Column(children: [
                                        SizedBox(height: 10,),
                                        Container(height: 70,width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          image: DecorationImage(
                                            image: NetworkImage(productimage+pro[index].pimage),fit: BoxFit.cover
                                            )
                                            ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(pro[index].pname.toString().toUpperCase(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                                      ]),
                                  
                                    ),
                                  ),
                                ),
                              );
                            
                             
                           }
                           ));
                    }
                    
                  }
                
                }
                return CircularProgressIndicator();
            });
  }
  Widget _container(String category)
  {
    return Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 203, 203, 203),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: _categoryproducts(category),

              );
  }
}