import 'dart:convert';

import 'package:stockdelivery/models/Paymentss.dart';

import '../methods/apicalling.dart';

class Payment {
  int remaining_amount=0,total_paid=0;
  List<payments>? pay;
  // Map<String, dynamic> toMap() {
  //   Map<String, dynamic> m = Map<String, dynamic>();
  //   m["remaining_amount"] = remaining_amount;
  //   m["total_paid"] = total_paid;
  //   if(m["list"]!=null)
  //   {
  //     var data = m["list"] as List;
  //       pay = data.map((e) => payments.fromMap(e)).toList();
  //   }
  //   return m;
  // }

  Payment.fromMap(Map<dynamic, dynamic> m) {
    remaining_amount = m["remaining_credit"];
    total_paid = m["total_paid"];
    if(m["list"]!=null)
    {
      var data = m["list"] as List;
        pay = data.map((e) => payments.fromMap(e)).toList();
    }
  }
}

