import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/screen/Vendor/add_Update_products/Vendor_updateitems.dart';
import 'package:stockdelivery/screen/Vendor/add_Update_products/adddailyStock.dart';

class maintainproduct extends StatefulWidget {
 final products product;
   maintainproduct({Key? key,required this.product }) : super(key: key);

  @override
  State<maintainproduct> createState() => _maintainproductState(product);
}

class _maintainproductState extends State<maintainproduct> {
    products pro;
  _maintainproductState(this.pro);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(title: Text("Product Updation"),centerTitle: true,
        bottom: TabBar(  
              tabs: [  
                Tab(icon: Icon(Icons.airplanemode_active_outlined), text: "Update Product"),  
                Tab(icon: Icon(Icons.delivery_dining_rounded), text: "Add Daily Stock")  
              ],  ),

    ),
          body: 
    TabBarView(  
            children: [  
              updateitems(product: pro),
              dailystock(product: pro)
            ],  
    )
    ));
  }
}