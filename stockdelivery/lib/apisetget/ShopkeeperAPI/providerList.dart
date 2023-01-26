 import 'dart:convert';
import 'package:http/http.dart'as http;
import '../../methods/apicalling.dart';
import '../../models/signin.dart';
class registerShopkeeper{
 Future<List<modelsignin>?> getdistributorforapply(int id,String status) async
  {
    try{
      String uri="${ip}providerList/getshopkeeperforapply";
var response=await http.get(Uri.parse(uri).
  replace(queryParameters: {"id":id.toString(),"status":status}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );
    if(response.statusCode==200)
    {
      Iterable data = jsonDecode(response.body);
      return data.map((e) => modelsignin.fromMap(e)).toList();
    }
    else
    {print(response.body);}
    
    }catch(Exception){
      print("failed");
    }
  }

  //vendor update security amount and status for distributor..
    Future<void> updateShopkeeperstatus(int did,int uid,String status) async
  {
    try{
      String uri="${ip}providerList/updateshopkeeperstatus";
  var response=await http.post(Uri.parse(uri).replace(queryParameters: {"did":did.toString(),"uid":uid.toString(),"status":status}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' 
  }
  );  
    print(response.body);
    
    }catch(Exception){
      print("failed");
          }
  }
}