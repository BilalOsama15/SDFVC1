import 'package:flutter/material.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/screen/Vendor/OrdersManagement/Vendor_orders.dart';
import 'package:stockdelivery/screen/Vendor/Fragments/Vendor_products.dart';
import 'Fragments/UserOrders.dart';
import 'Fragments/Vendor_credit.dart';
import 'Vendor_drawer.dart';
class Vdashboard extends StatefulWidget {
  const Vdashboard({Key? key}) : super(key: key);

  @override
  State<Vdashboard> createState() => _VdashboardState();
}

class _VdashboardState extends State<Vdashboard> {
  int _currentIndex = 0;
    List<Widget> widlist= [Vendor_products(), userOrders(), Vendorcredit()];
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const drawer(),
      bottomNavigationBar: Container(decoration: const BoxDecoration(borderRadius:const BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))),
        child: BottomNavigationBar(
          selectedItemColor: Colors.blue[700],
          unselectedItemColor: Colors.black,
          backgroundColor:Colors.white,
          selectedFontSize: 12.0,

          showSelectedLabels: true,
          
          currentIndex: _currentIndex,
          items: [
              const BottomNavigationBarItem(icon: Icon(Icons.add),label: "Add Product"),
              const BottomNavigationBarItem(icon: const Icon(Icons.star_outline),label: "Order Status"),
              const BottomNavigationBarItem(icon: Icon(Icons.credit_card),label: "Check Credit"),
              
        ],onTap: (int index) {
          setState(() {
            _currentIndex=index;
          });
        },
        ),
      ),
    body: widlist[_currentIndex],
      
    );
  }
}
