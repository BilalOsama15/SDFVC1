import 'package:flutter/material.dart';
import 'package:stockdelivery/models/Vendors_distributor.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/mywidget/shaderText.dart';
import 'package:stockdelivery/mywidget/show_Rating.dart';
import 'package:stockdelivery/screen/Distributor/Distributors_products/Distributor_product_details.dart';
import '../../../apisetget/DistributorAPI/VendorsAPIs.dart';
import '../../../methods/apicalling.dart';
import '../../../models/lists.dart';
import '../../../models/products.dart';
import '../../../models/users.dart';
import '../../../mywidget/Mywidget.dart';

class Dis_Ven_Detail extends StatefulWidget {
  final modelsignin? m;
  const Dis_Ven_Detail({Key? key, required this.m}) : super(key: key);

  @override
  State<Dis_Ven_Detail> createState() => _Dis_Ven_DetailState(m!);
}


class _Dis_Ven_DetailState extends State<Dis_Ven_Detail> {
  double rating = 0.0;
  modelsignin m;
  _Dis_Ven_DetailState(this.m);
  void initState() {
    setState(() {});
    userproducts = getdata(m.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Vendor Details"),
      body: SafeArea(
        minimum: EdgeInsets.all(20.0),
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
                          image: NetworkImage(userimage + m.uimage),
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
                      Text(
                        "Name : " + m.uname.toString(),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      
                      Text(
                        "Email : " + m.uemail.toString(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                     
                      Text(
                        "Mobile No : " + m.umobileno.toString(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      
                      Text(
                        "City : " + m.ucity.toString(),
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      showRating(rating: rating)
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
                                      mainAxisExtent: 160,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 6,
                                      crossAxisSpacing: 6),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Dis_product_detail(
                                                    p: snapshot.data![index],
                                                  )));
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
                                            height: 80,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        productimage +
                                                            snapshot
                                                                .data![index]
                                                                .pimage),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 5),
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
                              });
                        }
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  showLoader(context);
                  await vd.sendApplyfor_distribution("Pending", "0",
                      m.id.toString(), usermodel!.id.toString());
                      hideLoader(context);
                  setState(() {});
                },
                child: Text("Apply For Distribution"))
          ],
        ),
      ),
    );
  }
}
