import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';

import '../../../methods/apicalling.dart';
import '../../../models/cart_provider.dart';
import '../../../models/products.dart';
import '../../../mywidget/shaderText.dart';
import '../../../mywidget/show_Rating.dart';
import '../../Distributor/Distributor_Vendors/addtocartscreen.dart';
import 'distributor_Details.dart';

class product_Ven extends StatefulWidget {
  final products p;
  final String state;
  const product_Ven({Key? key ,required this.p, required this.state}) : super(key: key);

  @override
  State<product_Ven> createState() => _product_VenState(p.id);
}

class _product_VenState extends State<product_Ven> {
  int? id;
  _product_VenState(this.id);
  String s="";
  @override
  void initState() {
    widget.state=="shopkeeper"?
  userwithproduct=  productGetByVendors(id!,usermodel!.id):
  userwithproduct=  productGetByvendorfromdistributorside(id!,usermodel!.id);
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    s="";
    final cart  = Provider.of<cartprovider>(context);
    return Scaffold(
      body: FutureBuilder<modelsignin?>(
        future: userwithproduct,
        builder: (BuildContext context,
                        AsyncSnapshot<modelsignin?> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Snapshot Error"),
                          );
                        } else if (snapshot.hasData) {
                          s= snapshot.data!.status == null?"":snapshot.data!.status!;
                          return SafeArea(
                            minimum: EdgeInsets.all(13),
                            child: Column(
                              children: [
                                Center(
                                    child: Text(
                                  "Vendor Details",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    shadows: [],
                                  ),
                                )),
                                SizedBox(
                                  height: 30,
                                  width: 200,
                                ),
                                Container(
                                    child: Row(
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 110,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Color.fromARGB(255, 15, 15, 15), width: 3),
                                          image: DecorationImage(
                                              image: NetworkImage(userimage + snapshot.data!.uimage),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.uname.toString().toUpperCase(),
                                           // "Name : " + m.uname.toString(),
                                            style: TextStyle(
                                                fontSize: 18.0, fontWeight: FontWeight.w800),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          
                                          Text(
                                           snapshot.data!.uemail.toString(),
                                            // "Email : " + m.uemail.toString(),
                                            style: TextStyle(
                                                fontSize: 14.0, fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                         
                                          Text(
                                            snapshot.data!.umobileno.toString(),
                                            // "Mobile No : " + m.umobileno.toString(),
                                            style: TextStyle(
                                                fontSize: 14.0, fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          
                                          Text(
                                           snapshot.data!.ucity.toString(),
                                            // "City : " + m.ucity.toString(),
                                            style: TextStyle(
                                                fontSize: 14.0, fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          showRating(rating: snapshot.data!.rating.toDouble())
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: Text(
                                  "Vendor Products",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    shadows: [],
                                  ),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 350,
                                    child:  GridView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          mainAxisExtent: 150,
                                                          crossAxisCount: 2,
                                                          mainAxisSpacing: 6,
                                                          crossAxisSpacing: 6),
                                                  itemCount: snapshot.data!.product!.length,
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color:
                                                                        Color.fromARGB(25, 0, 0, 0),
                                                                    blurRadius: 4,
                                                                    spreadRadius: 2)
                                                              ],
                                                              color: Colors.white),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                width: double.infinity,
                                                                height: 70,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(
                                                                            productimage +
                                                                                snapshot.data!.product![index].pimage
                                                                                    ),
                                                                        fit: BoxFit.cover)),
                                                              ),
                                                              SizedBox(height: 5,),
                                                              Container(
                                                                child: Column(
                                                                  children: [
                                                                    shadertext(
                                                                        text: snapshot.data!.product![index].pname
                                                                            .toString(),
                                                                        colors1: Colors.black,
                                                                        colors2: Colors.red),
                                                                    SizedBox(height: 6),
                                                                    Text(
                                                                        "Available Cartons: " +
                                                                           snapshot.data!.product![index].total_no_of_cartons
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.black)),
                                                                    SizedBox(height: 6),
                                                                    Text(
                                                                        "Price Per Carton: " +
                                                                            snapshot.data!.product![index].saleprice_per_carton
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            fontSize: 12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.black)),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })
                                           
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  
                                    onPressed: () async {
                                     cart.setcartdataclear();
                                      s==""? 
                                     await G_V_P.shopkeeperapplyfordistribution(snapshot.data!.id,usermodel!.id):
                                      s=="active"? 
                                    
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_to_cart(id: snapshot.data!.id,)))
                                      :
                                      showSnackBar(context, "Your Are Not Eligible For Place Order", Colors.red);
                                    },
                                    child: Text(s=="" ?"Apply For Distribution":s=="active"?"Place Order":"Your Status is ${s}" ))
                              ],
                            ),
                          );
                        }
                        }
                        return Center(child: Text("Something Wrong"));
                        }
        
        )
      
      
    );
  }
}