import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:stockdelivery/models/signin.dart';
import '../../methods/apicalling.dart';
class vendorsAPI{

Future<List<modelsignin>?> getData(String id) async
  {
    try{
      String uri="${ip}user/getAllVendors";
var response=await http.get(Uri.parse(uri).replace(queryParameters: {"id":id}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
  print(response.body);
    if(response.statusCode==200)
    {
     Iterable data= jsonDecode(response.body);
    return data.map((e) => modelsignin.fromMap(e)).toList();
    }
    else
    {print(response.body);}
    
    }catch(Exception){
      print("failed");
          }
  }

Future<List<modelsignin>?> getcategoryvendors(String did,String Category) async
  {
    try{
      String uri="${ip}user/getusersbyproductcategory";
var response=await http.get(Uri.parse(uri).replace(queryParameters: {
  "Did":did,
  "category":Category
  }),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
    if(response.statusCode==200)
    {
     Iterable data= jsonDecode(response.body);
    return data.map((e) => modelsignin.fromMap(e)).toList();
    }
    else
    {print(response.body);}
    
    }catch(Exception){
      print("failed");
          }
  }

  Future<List<modelsignin>?> getcategorymyvendors(String id, String status,String Category) async
  {
    try{
      String uri="${ip}user/getuserbyproductcategory";
var response=await http.get(Uri.parse(uri).replace(queryParameters: {
  "category":Category,
  "did":id,
  "status":status
  }),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
    if(response.statusCode==200)
    {
     Iterable data= jsonDecode(response.body);
    return data.map((e) => modelsignin.fromMap(e)).toList();
    }
    else
    {print(response.body);}
    
    }catch(Exception){
      print("failed");
          }
  }





}