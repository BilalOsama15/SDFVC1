import 'package:flutter/material.dart';
import 'package:stockdelivery/models/products.dart';

import '../Distributors_products/Distributor_product_details.dart';
import '../add_tocart_button.dart';

class Dis_ven_product_detail extends StatefulWidget {
  products p;
   Dis_ven_product_detail({Key? key,required this.p }) : super(key: key);

  @override
  State<Dis_ven_product_detail> createState() => _Dis_ven_product_detailState(p);
}

class _Dis_ven_product_detailState extends State<Dis_ven_product_detail> {
  products pro;
  _Dis_ven_product_detailState(this.pro);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dis_product_detail(p: pro,)

    );
  }
}


