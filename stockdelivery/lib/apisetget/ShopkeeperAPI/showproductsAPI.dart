import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../methods/apicalling.dart';
import '../../models/products.dart';

class showproductsApi{
  
Future<List<products>?> showAllproducts()
async {
  try{
    String uri = "${ip}shopkeeper/showproducts";
  var response = await http.get(Uri.parse(uri),
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
}