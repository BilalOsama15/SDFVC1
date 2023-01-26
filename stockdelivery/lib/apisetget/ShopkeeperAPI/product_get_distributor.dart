import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/models/shopkeeperDistributor.dart';
import 'package:stockdelivery/models/signin.dart';

import '../../methods/apicalling.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class getDistributorProduct{

Future<List<distributor_W_products>?> distributorbyProducts(int v,int sid)
async {
  try{
    String uri = "${ip}shopkeeper/getproductDistributors";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"pid":v.toString(),"sid":sid.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print(response.statusCode);
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  print(data);
  return data.map((e) => distributor_W_products.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}
Future<List<products>?> distributorProducts(int uid)
async {
  try{
        print("5");
    String uri = "${ip}shopkeeper/distributorProducts";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"uid":uid.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print(response.statusCode);
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);  
  return data.map((e) => products.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}

}