import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';
import 'package:stockdelivery/mywidget/shaderText.dart';

class Disorderproduct_detail extends StatefulWidget {
  final int pid;
  const Disorderproduct_detail({Key? key ,required this.pid }) : super(key: key);

  @override
  State<Disorderproduct_detail> createState() => _Disorderproduct_detailState(pid);
}

class _Disorderproduct_detailState extends State<Disorderproduct_detail> {
    int pid=0;
  _Disorderproduct_detailState(this.pid);
  bool instock =false;
  Future<products?>? p ;

  @override
  void initState() {
    super.initState();
      p =  getsingleproductdata(pid);

  }
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: appbar("Product Detail"),
      body: FutureBuilder<products?>(
                        future: p,
                        builder: (BuildContext context,AsyncSnapshot<products?> snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting)
                          {
                            return const Center(child: CircularProgressIndicator());
                          }
                          else if(snapshot.connectionState==ConnectionState.done)
                          {
                            if(snapshot.hasError)
                            {
                              return const Center(child: Text("Snapshot Error"),);
                            }
                            else if(snapshot.hasData)
                            {
                                   if(snapshot.data!.total_no_of_cartons>=20)
                                    {
                                      instock=true;
                                    }
                              return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(productimage+snapshot.data!.pimage),fit: BoxFit.cover
            )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 380),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30,left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 160,
                            alignment: Alignment.centerLeft,
                         child: Row(children: [
                          Icon(Icons.circle,size: 10,color: instock?Colors.green:Color.fromARGB(255, 215, 215, 215),),SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        shadertext(text: snapshot.data!.pname.toString(), colors1: Colors.black, colors2: Color.fromARGB(255, 231, 143, 0)),
                          Text(snapshot.data!.category.toString(),style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 109, 109, 109)),)
                          ],),
                         ],),   
                          ),
                          
                          Container(
                            alignment: Alignment.centerRight,
                            width: 160,
                            child: Text(snapshot.data!.saleprice_per_carton.toString()+" P.C",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        ],
                      ),
                  Divider(),
                  SizedBox(height: 15,),
                  Row(children: [
                    shadertext(text: "Available Cartons: ", colors1: Colors.red, colors2: Colors.black),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 195,
                          child: Text(snapshot.data!.total_no_of_cartons.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                  ],),
                  Divider(),
                   SizedBox(height: 15,),
                  Row(children: [
                    shadertext(text: "Quantity per Carton: ", colors1: Colors.black, colors2: Colors.red),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 180,
                          child: Text(snapshot.data!.quantitypercarton.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                  ],),
                  Divider(),
                  SizedBox(height: 15,),
                  shadertext(text: "Description ", colors1: Colors.red, colors2: Colors.black),
                  SizedBox(height: 10,),
                  Container(
                    height: 50,width: double.infinity,
                    child: Text(snapshot.data!.description.toString(),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w700),),
                  )
                    ],
                  ),
                )

              ),
            ),
            );
                              
                              
                            }
                          }
                          return Center(child: CircularProgressIndicator());
                        }
      )
    );
  }
}
