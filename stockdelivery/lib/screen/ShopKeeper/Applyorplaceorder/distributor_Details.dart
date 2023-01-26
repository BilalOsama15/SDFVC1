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
import '../addtocartdistributor.dart';

class distributorDetail extends StatefulWidget {
 final modelsignin m;
 final int id;
 final String status;
  const distributorDetail({Key? key,required this.m, required this.id, required this.status}) : super(key: key);

  @override
  State<distributorDetail> createState() => _distributorDetailState();
}

class _distributorDetailState extends State<distributorDetail> {
  @override
  
       
  @override
  Widget build(BuildContext context) {
      userproducts= distributorsProduct(widget.id);
        final cart  = Provider.of<cartprovider>(context);
    return Scaffold(
    appBar: appbar("Distributor Details"),
    body: SafeArea(
        minimum: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
                child: Text(
              "Distributor Details",
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
                          image: NetworkImage(userimage + widget.m.uimage),
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
                      Text(widget.m.uname.toString().toUpperCase(),
                       // "Name : " + m.uname.toString(),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      
                      Text(
                       widget.m.uemail.toString(),
                        // "Email : " + m.uemail.toString(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                     
                      Text(
                        widget.m.umobileno.toString(),
                        // "Mobile No : " + m.umobileno.toString(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      
                      Text(
                       widget.m.ucity.toString(),
                        // "City : " + m.ucity.toString(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      showRating(rating: widget.m.rating.toDouble())
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
              "Distributor Products",
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
                child: FutureBuilder<List<products>?>(
                    future: userproducts,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<products>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Snapshot Error"),
                          );
                        } else if (snapshot.hasData) {
                          Center(child: CircularProgressIndicator());
                          return GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 150,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 6,
                                      crossAxisSpacing: 6),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             Dis_product_detail(
                                      //               p: snapshot.data![index],
                                      //             )));
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
                                                            snapshot
                                                                .data![index]
                                                                .pimage),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            child: Column(
                                              children: [
                                                shadertext(
                                                    text: snapshot
                                                        .data![index].pname
                                                        .toString(),
                                                    colors1: Colors.black,
                                                    colors2: Colors.red),
                                                SizedBox(height: 6),
                                                Text(
                                                    "Available Cartons: " +
                                                        snapshot.data![index]
                                                            .total_no_of_cartons
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black)),
                                                SizedBox(height: 6),
                                                Text(
                                                    "Price Per Carton: " +
                                                        snapshot.data![index]
                                                            .saleprice_per_carton
                                                            .toString(),
                                                    style: const TextStyle(
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
                              });
                        }
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  cart.setcartdataclear();
                  widget.status=="block"? 
                   showSnackBar(context, "Your Are Not Eligible For Place Order", Colors.red):
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>addtocartDistributor(id: widget.id ,)));
                },
                child: Text(widget.status=="block"?"Your Status is${widget.status}" :"Place Order"))
          ],
        ),
      ),
    );
  }
}