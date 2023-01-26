import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/models/signin.dart';

import '../../methods/apicalling.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class getVendorProduct{
    
Future<modelsignin?> vendorbyProducts(int v,int s)
async {
  try{
    String uri = "${ip}shopkeeper/getproductVendor";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"pid":v.toString(),"sid":s.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print(response.statusCode);
  print(response.body);
  if(response.statusCode==200)
  {
  var data = jsonDecode(response.body);
  print(data);

  return modelsignin.fromMaps(data);
  }
  }catch(Exception){
    print("Failed");
  }

}

Future<modelsignin?> vendorbyProductsFdistributorSide(int v,int s)
async {
  try{
    String uri = "${ip}shopkeeper/getproductVendorfromDistSide";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"pid":v.toString(),"sid":s.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print(response.statusCode);
  print(response.body);
  if(response.statusCode==200)
  {
  var data = jsonDecode(response.body);
  print(data);

  return modelsignin.fromMaps(data);
  }
  }catch(Exception){
    print("Failed");
  }

}

Future<int?> shopkeeperapplyfordistribution(int v,int s)
async {
  try{
    String uri = "${ip}shopkeeper/applyfordistribution";
  var response = await http.post(Uri.parse(uri).replace(queryParameters: {"vid":v.toString(),"sid":s.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  print(response.statusCode);
  if(response.statusCode==200)
  {
  return response.statusCode;
  
  }
  return 123;
  }catch(Exception){
    print("Failed");
    return 123;
  }

}


}