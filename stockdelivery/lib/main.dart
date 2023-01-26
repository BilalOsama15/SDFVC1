import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockdelivery/models/cart_provider.dart';
import 'package:stockdelivery/screen/Login.dart';
import 'package:stockdelivery/screen/ShopKeeper/Fragments/Showproducts.dart';
import 'package:stockdelivery/screen/Vendor/add_Update_products/Vendor_additems.dart';

void main() async{
  
  runApp(
    ChangeNotifierProvider(create: (_)=>cartprovider(),
    child: Builder(builder: (BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Login());
    },),)
    );
}

