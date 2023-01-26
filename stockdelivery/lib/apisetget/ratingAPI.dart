import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stockdelivery/methods/apicalling.dart';

class ratingapi {


  Future<int> rateuser(String oid , String rc, String rv, String noofstars) async {
    try {
      String uri = "${ip}rating/rateuserbyorder";
      print(noofstars);
      var response = await http.post(
          Uri.parse(uri).replace(queryParameters: {
            "reviewerid" : rv.toString(),
            "receiverid" : rc.toString(),
            "noofstars" : noofstars.toString(),
             "oid": oid.toString()

          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.body);
      if (response.statusCode == 200) {
        print("rating...");
        print(jsonDecode(response.body));
        return 200;
      }
      return 123;
    } catch (Exception) {
      print("Failed");
      return 123;
    }
  }

  Future<int> checkalreadyrated(String oid , String rc, String rv) async {
    try {
      String uri = "${ip}rating/checkalreadyrated";
      var response = await http.get(
          Uri.parse(uri).replace(queryParameters: {
            "reviewerid" : rv.toString(),
            "receiverid" : rc.toString(),
             "oid": oid.toString()
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.body);
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 230;
    } catch (Exception) {
      print("Failed");
      return 123;
    }
  }

}
