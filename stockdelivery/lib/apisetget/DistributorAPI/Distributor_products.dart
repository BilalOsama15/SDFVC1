import 'dart:convert';


import 'package:stockdelivery/models/products.dart';

import '../../methods/apicalling.dart';
import 'package:http/http.dart' as http;

class Distributor_products
{
  Future<List<products>?> getDistProd(int v) async
  {
    try{
      String uri="${ip}DistributorProducts/distributorproducts";
      print("2");
    var response=await http.get(Uri.parse(uri).replace(queryParameters: {
      "id":v.toString(),
      
    }),
    headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'}
  ); 
  print(response.statusCode);
  if(response.statusCode==200){
    Iterable data = jsonDecode(response.body);
    print(data);
    return data.map((e) => products.fromMap(e)).toList();
    } 

    }catch(Exception){
      print("failed");
    }
  }
    Future<int> updateDistProduct(int uid,int pid,String saleprice) async
  {
    try{
      String uri="${ip}DistributorProducts/updatedistributorproducts";
    var response=await http.post(Uri.parse(uri).replace(queryParameters: {
      "uid":uid.toString(),
      "pid":pid.toString(),
      "saleprice": saleprice.toString()
    }),
    headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'}
  ); 
  print(response.statusCode);
  if(response.statusCode==200){
    return response.statusCode;
    } 
  return 123;
    }catch(Exception){
      print("failed");
      return 123;
    }
  }
}