import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/screen/ShopKeeper/ShopkeeperOrder/ShopkeeperOrders.dart';
import 'package:stockdelivery/screen/ShopKeeper/Fragments/Showproducts.dart';
import 'package:stockdelivery/screen/ShopKeeper/Fragments/shopkeeper_Payments.dart';

import 'Fragments/orderUser.dart';


class shopkeeperDashboard extends StatefulWidget {
  const shopkeeperDashboard({Key? key}) : super(key: key);

  @override
  State<shopkeeperDashboard> createState() => _shopkeeperDashboardState();
}

class _shopkeeperDashboardState extends State<shopkeeperDashboard> {
  int _currentIndex = 0;
   List<Widget> widlist= [showproduct(),S_orderUser(),S_payments()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(decoration: const BoxDecoration(borderRadius:const BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))),
        child: BottomNavigationBar(
          selectedItemColor: Colors.blue[700],
          unselectedItemColor: Colors.black,
          backgroundColor:Colors.white,
          selectedFontSize: 12.0,
          showSelectedLabels: true,
          currentIndex: _currentIndex,
          items: [
              const BottomNavigationBarItem(icon: Icon(Icons.add),label: "Order"),
              const BottomNavigationBarItem(icon: const Icon(Icons.star_outline),label: "Order Details"),
              const BottomNavigationBarItem(icon: Icon(Icons.credit_card),label: "Payment Details"),
              
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