import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';
import 'package:http/http.dart' as http;
import 'package:stockdelivery/screen/ShopKeeper/Applyorplaceorder/productDistributor.dart';
import 'package:stockdelivery/screen/ShopKeeper/Applyorplaceorder/productvendor.dart';

import '../../../methods/apicalling.dart';

class Product_Users extends StatefulWidget {
  final products p;
  const Product_Users({Key? key, required this.p}) : super(key: key);

  @override
  State<Product_Users> createState() => _Product_UsersState();
}

class _Product_UsersState extends State<Product_Users> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Product Seller"),
        bottom: TabBar(
        tabs: [
          Tab(text: "Vendor",),
          Tab(text: "Distributors",),
        ],
      ),
        ),
        body: TabBarView(
          children: [
            product_Ven(p: widget.p,state: "shopkeeper",),
            product_Dis(p: widget.p,),
        ],)
      ),
    );
  }
}