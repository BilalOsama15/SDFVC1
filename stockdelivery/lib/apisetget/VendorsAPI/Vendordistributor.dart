import 'dart:convert';
import 'package:http/http.dart'as http;
import '../../methods/apicalling.dart';
import '../../models/Vendors_distributor.dart';
import '../../models/signin.dart';
import '../../screen/Distributor/Fragments/My_vendors.dart';

class V_D_api{

  // send apply for distribution from distributor side to vendor..
  Future<void> sendApplyfor_distribution(String status,String securityamt,String vdid,String ddid) async
  {
    try{
      String uri="${ip}Vendor_distributor/applydistributortovendor";
var response=await http.post(Uri.parse(uri).replace(queryParameters: {"status":status,"securityAmt":securityamt,"vid":vdid,"did":ddid}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
  print(response.body);
    
    
    }catch(Exception){
      print("failed");
          }
  }

  // get all distributorthat should be apply..
  Future<List<modelsignin>?> getdistributorforapply(String id,String status,String us) async
  {
    try{
      String uri="${ip}Vendor_distributor/getDistributoforApply";
var response=await http.get(Uri.parse(uri).
  replace(queryParameters: {"id":id.toString(),"status":status,"us":us.toString()}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
  print(response.body);
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
    Future<void> updatedistributorfordistribution(String status,String securityamt,String vdid,String ddid) async
  {
    try{
      String uri="${ip}Vendor_distributor/updatedistributorfordistribution";
      //print("${VD.distributorId} ${VD.distributorstatus}");
var response=await http.post(Uri.parse(uri).replace(queryParameters: {"status":status,"securityAmt":securityamt,"vid":vdid,"did":ddid}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
    print(response.body);
    
    }catch(Exception){
      print("failed");
          }
  }

  // all vendors using status in Myvendors screen..
  Future<List<modelsignin>?> getallvendorstatus(String id,String status) async
  {
    try{
      String uri="${ip}Vendor_distributor/statusVendors";
var response=await http.get(Uri.parse(uri).
  replace(queryParameters: {"did":id.toString(),"status":status.toString()}),
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

  // check distributor one time apply..
  Future<void> checkonetimeapply(String vid,String did) async
  {
    try{
      String uri="${ip}Vendor_distributor/ontimeapply";
var response=await http.get(Uri.parse(uri).
  replace(queryParameters: {"vid":vid.toString(),"did":did.toString()}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
    if(response.statusCode==200)
    {
       return await jsonDecode(response.body);
    }
    
    }catch(Exception){
      print("failed");
          }
  }

}