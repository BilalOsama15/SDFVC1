import 'dart:convert';
import 'dart:io';
import 'package:stockdelivery/models/products.dart';
import 'package:http/http.dart' as http;
import '../../methods/apicalling.dart';
import '../../models/addstock.dart';

class productapis{

// Add Product..

Future<int> saveproduct(products p,File image)
async {
  try
  {
    String uri = "${ip}Vendor_product/InsertProduct";
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(uri),
    );
    request.headers.addAll({'Content-type': 'multipart/form-data'});
    request.files.add(await http.MultipartFile.fromPath("",image.path));
    request.fields.addAll({
    "name": p.pname.toString(),
    "company_name":p.companyName.toString(),
    "qty_in_carton" : p.quantitypercarton.toString(),
    "saleprice_per_carton" : p.saleprice_per_carton.toString(),
    "threshold": p.threshold.toString(),
    "category":p.category.toString(),
    "description":p.description.toString(),
    "vendor_id": p.userid.toString()
    });
    var response = await request.send();
    print(response.statusCode);
    return response.statusCode;
  }catch(Exception){
    print("Failed");
    return 123;
  }
}

// Get All Product Of This id..

Future<List<products>?> getproduct(int id)
async {
  try{
    String uri = "${ip}Vendor_product/getproducts";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"vid":id.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  print(data);
  return data.map((e) => products.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}

Future<List<products>?> getdistributorProductforOrder(int id)
async {
  try{
    print("11111111111111111111111111");
    String uri = "${ip}Vendor_product/getdistributorproducts";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"vid":id.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  if(response.statusCode==200)
  {
  Iterable data = jsonDecode(response.body);
  print("222222222222222222222222222");
  print(data);
  return data.map((e) => products.fromMap(e)).toList();
  }
  }catch(Exception){
    print("Failed");
  }

}

Future<products?> getsingleproduct(int id)
async {
  try{
    String uri = "${ip}Vendor_product/getproduct";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"pid":id.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
  
  if(response.statusCode==200)
  {
    print(response.body);
      return products.fromMap(jsonDecode(response.body));
  }
  }catch(Exception){
    print("Failed");
  }

}

// For Produt Update..

Future<int> updateProduct(String id, products p,File image)
async {
  try
  {
    print(image.path);
    String uri = "${ip}Vendor_product/updateproduct";
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(uri),
    );
    request.headers.addAll({'Content-type': 'multipart/form-data'});
    request.files.add(await http.MultipartFile.fromPath("",image.path));
    request.fields.addAll({
      "vid":id.toString(),
    "name": p.pname.toString(),
    "company_name":p.companyName.toString(),
    "qty_in_carton" : p.quantitypercarton.toString(),
    "saleprice_per_carton" : p.saleprice_per_carton.toString(),
    "threshold": p.threshold.toString(),
    "category":p.category.toString(),
    "description":p.description.toString(),
    "vendor_id": p.userid.toString()
    });
    var response = await request.send();

        print(response.statusCode);
        return response.statusCode;
  }catch(Exception){
    print("Failed");
    return 123;
  }
}

Future<int> updateProductpro(String id, products p)
async {
  try
  {
    String uri = "${ip}Vendor_product/updateproductpro";
     var response = await http.post(Uri.parse(uri).replace(queryParameters: {"pid":id.toString()}),
     body: jsonEncode(p.toMap()),
    headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'},
    );
    return response.statusCode;
  }catch(Exception){
    print("Failed");
    return 123;
  }
}

// insert Daily Stock
Future<int> addStock(String noofcartons,String mfg,String exp,String pid)
async {
  try
  {
    print("creating..");
    String uri = "${ip}Vendor_product/insertStock";
  var response = await http.post(Uri.parse(uri).
    replace(queryParameters: {"noofcartons":noofcartons,"mfg":mfg,"exp":exp,"pid":pid}),
    headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'},
    );
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
        
  }catch(Exception){
    print("Failed");
    return 414;
  }
}

Future<List<products>?> getdistributorproduct(int id)
async {
  try{
    String uri = "${ip}Vendor_product/getproducts";
  var response = await http.get(Uri.parse(uri).replace(queryParameters: {"vid":id.toString()}),
  headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8'});
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