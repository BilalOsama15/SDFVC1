import 'dart:convert';
import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/models/userorders.dart';
import 'package:stockdelivery/models/users.dart';
import '../../methods/apicalling.dart';
import 'package:http/http.dart' as http;

class creditapi {
  Future<List<modelsignin>?> getcreditusers(int sellerid,String type) async {
    try {
      print(sellerid);
      String uri = "${ip}credit/Usercredit";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {"seller_id": sellerid.toString(),"type":type.toString()}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.body);
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        print(data);
        return data.map((e) => modelsignin.userWithCredit(e)).toList();
      }
    } catch (Exception) {
      print("Failed");
    }
  }

  Future<List<modelsignin>?> getcreditusersfordistributor(int buyer_id,String type) async {
    try {
      String uri = "${ip}credit/Usercreditfordistributor";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {"buyer_id": buyer_id.toString(),"type":type.toString()}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        print(data);
        return data.map((e) => modelsignin.userWithCredit(e)).toList();
      }
    } catch (Exception) {
      print("Failed");
    }
  }

   Future<List<modelsignin>?> getcreditusersforShopkeeper(int buyer_id,String type) async {
    try {
      String uri = "${ip}credit/UsercreditforShopkeeper";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {"buyer_id": buyer_id.toString(),"type":type.toString()}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        print(data);
        return data.map((e) => modelsignin.userWithCredit(e)).toList();
      }
    } catch (Exception) {
      print("Failed");
    }
  }

  Future<List<userorders>?> getcredituserorders(String buyer_id,int sellerid) async {
    try {
      String uri = "${ip}credit/GetCreditOrderInfoForSeller";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {
                "buyer_id": buyer_id.toString(),
                "seller_id":sellerid.toString()
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        print(data);
        print("ok");
        return data.map((e) => userorders.fromMaps(e)).toList();
      }
    } catch (Exception) {
      print("Failed");
    }
  }

  Future<List<userorders>?> getcredituserordersfordist(String iid,String btype,int userid) async {
    try {
      print(btype);
      String uri = "${ip}credit/GetCreditOrderInfoForDistributor";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {
                "idd": iid.toString(),
                "btype":btype.toString(),
                "userid":userid.toString()
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.statusCode);
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        print(data);
        print("ok");
        return data.map((e) => userorders.fromMaps(e)).toList();
      }
    } catch (Exception) {
      print("Failed");
    }
  }
  Future<List<userorders>?> getcredituserordersforShopkeeper(String iid,int id) async {
    try {
      String uri = "${ip}credit/GetCreditOrderInfoForShopkeeper";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {
                "idd": iid.toString(),
                "userid":id.toString()
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.statusCode);
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        print(data);
        print("ok");
        return data.map((e) => userorders.fromMaps(e)).toList();
      }
    } catch (Exception) {
      print("Failed");
    }
  }
}
