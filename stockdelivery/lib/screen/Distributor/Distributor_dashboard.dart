import 'package:flutter/material.dart';
import 'package:stockdelivery/screen/Distributor/Fragments/Distributor_credit.dart';
import 'package:stockdelivery/screen/Distributor/Fragments/Distributor_products.dart';
import 'package:stockdelivery/screen/Distributor/Fragments/My_vendors.dart';
import 'package:stockdelivery/screen/Distributor/Fragments/Show_vendors.dart';
import 'Distributor_Drawer.dart';
import 'Distributor_orders/Distributer_orders.dart';
import 'Fragments/ShowProducts.dart';
import 'Fragments/userOrder.dart';
class Dis_dashboard extends StatefulWidget {
  const Dis_dashboard({Key? key}) : super(key: key);

  @override
  State<Dis_dashboard> createState() => _Dis_dashboardState();
}
int currentIndex = 2;
    List<Widget> widlist=const [S_products(),Distributor_products(),My_vendors(),User_order_dist(),Distributorcredit()];
class _Dis_dashboardState extends State<Dis_dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Dis_drawer(),
      bottomNavigationBar: Container(decoration: BoxDecoration(borderRadius:BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))),
        child: BottomNavigationBar(
          
          selectedItemColor: Colors.blue[700],
          unselectedItemColor: Colors.black,
          backgroundColor:Colors.white,
          selectedFontSize: 12.0,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          
          currentIndex: currentIndex,
          items: [
              BottomNavigationBarItem(icon: Icon(Icons.near_me),label: "Vendors"),
              BottomNavigationBarItem(icon: Icon(Icons.my_library_books),label: "My Products"),
              BottomNavigationBarItem(icon: Icon(Icons.online_prediction_rounded),label: "Order"),
              BottomNavigationBarItem(icon: Icon(Icons.outbox_rounded),label: "Orders Details"),
              BottomNavigationBarItem(icon: Icon(Icons.credit_card),label: "Credit")
              
        ],onTap: (int index) {
          setState(() {
            currentIndex=index;
          });
        },
        ),
      ),
    body: widlist[currentIndex],
      
    );
  }
}
