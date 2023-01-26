import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/userorders.dart';
import 'package:stockdelivery/screen/Vendor/OrdersManagement/Vendor_ordersDetails.dart';
import '../../../mywidget/Mywidget.dart';
import '../Vendor_drawer.dart';
class Vendor_orders extends StatefulWidget {
  final int id;
  const Vendor_orders({Key? key, required this.id}) : super(key: key);

  @override
  State<Vendor_orders> createState() => _Vendor_ordersState(id);
}
class _Vendor_ordersState extends State<Vendor_orders> {
  int? id;
  _Vendor_ordersState(this.id);
  String checkbuttonclick="pending";
    @override
  void initState() {
    userorder = getorders(usermodel!.id, checkbuttonclick,id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      
    });
    return Scaffold(
      appBar: appbar("User Orders"),
          drawer: const drawer(),
          body: 
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height:70,width: MediaQuery. of(context). size. width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            checkbuttonclick="pending";
                            userorder = getorders(usermodel!.id, checkbuttonclick,id!);
                            setState(() {
                              
                            });
                          },
                          child: Container(alignment: Alignment.center,
                            height: 40, width: 85,
                            decoration: BoxDecoration(
                              color:checkbuttonclick=="pending"? const Color.fromARGB(255, 0, 146, 165): Color.fromARGB(121, 0, 187, 212),
                              borderRadius: BorderRadius.circular(8)),
                            child: const Text("Pending",style: TextStyle(fontSize: 15,color: Colors.white), ),
                          ),
                        ),
                      const  SizedBox(width: 7,),
                        GestureDetector(
                          onTap: () {
                            checkbuttonclick="active";
                           userorder = getorders(usermodel!.id, checkbuttonclick,id!);
                            setState(() {
                            });
                          },
                          child: Container(alignment: Alignment.center,
                            height: 40, width: 60,
                            decoration: BoxDecoration(
                              color: checkbuttonclick=="active"?const Color.fromARGB(255, 84, 11, 211): Color.fromARGB(121, 84, 11, 211),
                              borderRadius: BorderRadius.circular(8)),
                            child: const Text("Active",style: TextStyle(color: Colors.white,fontSize: 15), ),
                          ),
                        ),
                      const  SizedBox(width: 7,),
                        
                        GestureDetector(
                          onTap: () {
                            checkbuttonclick="cancelled";
                           userorder = getorders(usermodel!.id, checkbuttonclick,id!);
                            setState(() {
                              
                            });
                          },
                          child: Container(alignment: Alignment.center,
                            height: 40, width: 85,
                            decoration: BoxDecoration(
                              color:checkbuttonclick=="cancelled" ?const Color.fromARGB(255, 219, 39, 26):Color.fromARGB(121, 244, 67, 54),
                              borderRadius: BorderRadius.circular(8)),
                            child: const Text("Cancelled",style: TextStyle(fontSize: 15,color: Colors.white), ),
                          ),
                        ),
                       const SizedBox(width: 7,),
                        GestureDetector(
                          onTap: () {
                            checkbuttonclick="delivered";
                           userorder = getorders(usermodel!.id, checkbuttonclick,id!);
                            setState(() {
                              
                            });
                          },
                          child: Container(alignment: Alignment.center,
                            height: 40, width: 85,
                            decoration: BoxDecoration(
                              color:checkbuttonclick=="delivered"?const Color.fromARGB(255, 37, 132, 40): Color.fromARGB(122, 76, 175, 79),
                              borderRadius: BorderRadius.circular(8)),
                            child:const Text("Delivered",style: TextStyle(fontSize: 15,color: Colors.white), ),
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    height: 540,
                    width: MediaQuery.of(context).size.width,
                    
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight:Radius.circular(25)) ),
                      child: FutureBuilder<List<userorders>?>(
                        future: userorder,
                        builder: (BuildContext context,AsyncSnapshot<List<userorders>?> snapshot){
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
                              if(snapshot.data!.isEmpty)
                              {
                                return Center(child: Text("Nothing To Show"));
                              }
                              else
                              {
                                return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index){
                                  
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  orderdetail(userorder: snapshot.data![index])));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 100, width: MediaQuery.of(context).size.width,
                                      decoration:  BoxDecoration(
                                        color: Color.fromARGB(255, 239, 239, 239),
                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:  [
                                                Container(width: 70, child: Text("Order Id:\n"+snapshot.data![index].id.toString(),textAlign: TextAlign.center,)),
                                                SizedBox(width: 40,),
                                                Container(width: 70, child: Text("Order Type:\n"+snapshot.data![index].order_type.toString(),textAlign: TextAlign.center)),
                                                SizedBox(width: 40,),
                                                Container(width: 100, child: Text("Order Amount:\n"+snapshot.data![index].total_amount.toString(),textAlign: TextAlign.center)),
                                              ],
                                            ),
                                            const SizedBox(height: 20,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                 Container(width: 70, child: Text("Place Date:\n"+snapshot.data![index].order_place_date.toString(),textAlign: TextAlign.center)),
                                                const SizedBox(width: 40,),
                                                Container(width: 100, child: Text("Deliver Date:\n"+snapshot.data![index].order_deliver_date.toString(),textAlign: TextAlign.center)),
                                                const SizedBox(width: 40,),
                                                Container(
                                                  height: 25,width: 70,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:snapshot.data![index].order_status=="pending"?Color.fromARGB(255, 0, 146, 165):
                                                          snapshot.data![index].order_status=="cancelled"? Color.fromARGB(255, 219, 39, 26):
                                                          snapshot.data![index].order_status=="delivered"? Color.fromARGB(255, 37, 132, 40):
                                                          Color.fromARGB(255, 84, 11, 211),
                                                    borderRadius: BorderRadius.circular(25)
                                                  ),
                                                  child:  Text(snapshot.data![index].order_status.toString(),style: TextStyle(color: Colors.white),),
                                                )
                                               
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              );
                              }
                              
                            }
                          }
                          return const Text("Something Not Good");
                        }),
                  )
              ],
            ),
          )
    
    );
  }
}



// TabBarView(  
    //         children: [  
    //           Vendor_active_order(),  
    //           Vendor_Completed_order(),  
    //             Vendor_active_order(),  
    //           Vendor_Completed_order(),
    //         ],  
    // )

  // return Scaffold(
    //   bottomNavigationBar: Container(decoration: BoxDecoration(borderRadius:BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0))),
    //     child: BottomNavigationBar(
    //       selectedItemColor: Colors.blue[700],
    //       unselectedItemColor: Colors.black,
    //       backgroundColor:Colors.white,
    //       selectedFontSize: 12.0,
    //       showUnselectedLabels: false,
    //       showSelectedLabels: true,
          
    //       currentIndex: _currentIndex,
    //       items: [
    //           BottomNavigationBarItem(icon: Icon(Icons.airplanemode_active_outlined),label: "Active"),
    //           BottomNavigationBarItem(icon: Icon(Icons.delivery_dining_rounded),label: "Completed"),
              
    //     ],onTap: (int index) {
    //       setState(() {
    //         _currentIndex=index;
    //       });
    //     },
    //     ),
    //   ),
    // body: widlist[_currentIndex],
      
    // );
  
    