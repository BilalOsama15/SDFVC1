
import 'dart:convert';

import 'package:stockdelivery/models/Items.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/models/userorders.dart';

import '../../methods/apicalling.dart';
import 'package:http/http.dart' as http;

class Distributor_order_APi
{
  Future<int> sendorder(userorders uo) async
  {
    try{
      print(uo.item?.map((e) => e.toMap()).toList());
      String uri="${ip}userorders/UserO";
      print("2");
    var response=await http.post(Uri.parse(uri).replace(queryParameters: {
      "total_amount":uo.total_amount.toString(),
      "seller_id" : uo.seller_id.toString(),
      "buyer_id" : uo.buyer_id.toString(),
    }),body: jsonEncode(uo.item!.map((e) => e.toMap()).toList()),
    headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'}
    
  );  
  print(response.statusCode);
  if(jsonDecode(response.body).toString()=="201")
  {
    return 201;
  }
    return response.statusCode;
    }catch(Exception){
      print("failed");
  return 123;
    }
  }

  Future<List<userorders>?> getallorders(int seller_id,String status,int id)
async {
  try{
    String uri = "${ip}userorders/getorders";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "seller_id":seller_id.toString(),
    "status" : status.toString(),
    "buyer_id":id.toString()
  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  print(response.body);
  print(data.map((e) => userorders.fromMap(e)).toList());
  return data.map((e) => userorders.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}

  Future<List<userorders>?> getallordersfromdistributorside(int buyer_id,String status,String buyer_type,String id)
async {
  try{
    String uri = "${ip}userorders/getordersfromdistributorside";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "buyer_id":buyer_id.toString(),
    "status" : status.toString(),
    "buyer_type" : buyer_type.toString(),
    "id":id.toString()
  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  return data.map((e) => userorders.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}

 Future<List<userorders>?> getallordersfromShopkeeperside(int buyer_id,String status,String type)
async {
  try{
    String uri = "${ip}userorders/getordersfromShopkeeperside";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "buyer_id":buyer_id.toString(),
    "status" : status.toString(),
    "type" : type.toString()
  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  print(data);
  return data.map((e) => userorders.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}

Future<int> updateorderstatus(int oid,String status)
async {
  try{
    String uri = "${ip}userorders/updateOrderStatus";
  var response = await http.post(Uri.parse(uri).replace(queryParameters: {
    "oid":oid.toString(),
    "Order_Status" : status.toString(),
  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
    print(jsonDecode(response.body));
    return 200;
  }
  return 123;
  }catch(Exception){
    
    print("Failed");
    return 123;
  }

}

// Future<int> updateordertype(int oid)
// async {
//   try{
//     String uri = "${ip}userorders/UpdateOrderType";
//   var response = await http.post(Uri.parse(uri).replace(queryParameters: {
//     "oid":oid.toString(),
//   }),
//   headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
//   if(response.statusCode==200)
//   {
//      print(jsonDecode(response.body));
//     return 200;
   
//   }
//   return 123;
//   }catch(Exception){
//     print("Failed");
//     return 123;
    
//   }

// }

  Future<modelsignin?> getordersdetails(int oid)
async {
  try{
    String uri = "${ip}userorders/getOrderDetails";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "oid":oid.toString(),

  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print("jajajsjs");
  if(response.statusCode==200)
  {
     
  var data = jsonDecode(response.body);
  return modelsignin.orderDetails(data);
  // print(data.map((e) => userorders.fromMap(e)).toList());
  }
  }catch(Exception){
    print("Failed");
  }

}

Future<modelsignin?> getordersdetailsfromdistributorside(int oid,String type)
async {
  try{
    String uri = "${ip}userorders/getOrderDetailsfromdistributorside";
   var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "oid":oid.toString(),
    "type":type.toString()

  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print("jajajsjs");
  if(response.statusCode==200)
  {
     
  var data = jsonDecode(response.body);
  print(data);
  return modelsignin.orderDetails(data);
  // print(data.map((e) => userorders.fromMap(e)).toList());
  }
  }catch(Exception){
    print("Failed");
  }

}
Future<modelsignin?> getordersdetailsfromShopkeeperside(int oid,String type)
async {
  try{
    String uri = "${ip}userorders/getOrderDetailsfromShopKeeperside";
   var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "oid":oid.toString(),
    "type":type.toString()

  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print("jajajsjs");
  if(response.statusCode==200)
  {
     
  var data = jsonDecode(response.body);
  print(data);
  return modelsignin.orderDetails(data);
  // print(data.map((e) => userorders.fromMap(e)).toList());
  }
  }catch(Exception){
    print("Failed");
  }

}

Future<List<modelsignin>?> getorderUser(int oid,String type,String btype)
async {
  try{
    String uri = "${ip}userorders/UserOrderForSellerOrbuyer";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "id":oid.toString(),
    "type":type.toString(),
    "btype": btype.toString()
  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  print(data);
  return data.map((e) => modelsignin.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}


Future<List<modelsignin>?> getorderUserdistributor(int oid,String type)
async {
  try{
    String uri = "${ip}userorders/UserOrderFordistributor";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {
    "id":oid.toString(),
    "type":type.toString(),
  }),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  print(data);
  return data.map((e) => modelsignin.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}



}