import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stockdelivery/models/PaymentNotification.dart';
import 'package:stockdelivery/models/payments.dart';

import '../../methods/apicalling.dart';


class paymentapi {
//   Future<List<Payment>?> getpaymentsdetails(String orderid,String type) async {
//     try {
//       String uri = "${ip}credit/checkPayments";
//       var response = await http.get(
//           Uri.parse(uri)
//               .replace(queryParameters: {"oid": orderid.toString(),"type":type.toString()}),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8'
//           });
//       if (response.statusCode == 200) {
//         Iterable data = jsonDecode(response.body);
//         print(data);
//         return data.map((e) => Payment.fromMap(e)).toList();
//       }
//     } catch (Exception) {
//       print("Failed");
//     }
//   }

// Future<int> addPayments(Payment p) async {
//     try {
//       String uri = "${ip}credit/addPayments";
//       var response = await http.post(
//           Uri.parse(uri),
//               headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8'
//           },body: jsonEncode(p.toMap()));
//       if (response.statusCode == 200) {
//         return response.statusCode;
//       }
//       return 123;
//     } catch (Exception) {
//        print("Failed");
//       return 123;
//     }
//   }

///...........
Future<int> AddNotification(String sellerid , String buyerid, String amount) async {
    try {
      String uri = "${ip}Payment/AddNotification";
      var response = await http.post(
          Uri.parse(uri)
              .replace(queryParameters: {
                "seller_id": sellerid.toString(),
                "buyer_id":buyerid.toString(),
                "amount":amount.toString()
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return response.statusCode;
    } catch (Exception) {
      print("Failed");
      return 213;
    }
  }
  Future<int> UpdateStatusNotification(String nid, String status) async {
    try {
      String uri = "${ip}Payment/UpdateStatusNotification";
      var response = await http.post(
          Uri.parse(uri)
              .replace(queryParameters: {
                "nid":nid.toString(),
                "status":status.toString()
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return response.statusCode;
    } catch (Exception) {
      print("Failed");
      return 213;
    }
  }
  Future<int> clearNotification(String nid) async {
    try {
      String uri = "${ip}Payment/clearNotification";
      var response = await http.post(
          Uri.parse(uri)
              .replace(queryParameters: {
                "nid": nid.toString(),
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return response.statusCode;
    } catch (Exception) {
      print("Failed");
      return 213;
    }
  }

Future<int?> NotificationLength(String id,String type) async {
    try {
      String uri = "${ip}Payment/getNotificationLength";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {
                "id": id.toString(),
                "type": type.toString()
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.body);
      return jsonDecode(response.body);
    } catch (Exception) {
      print("Failed");
      return 213;
    }
  }


Future<List<PaymentNotification>?> GetNotification(String sellerid,String status)async {
    try {
      String uri = "${ip}Payment/getNotificationForSeller";
      var response = await http.get(
          Uri.parse(uri).replace(queryParameters: {
            "seller_id":sellerid.toString(),
            "status": status.toString()
          }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.body);
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        print(data);
        return data.map((e) => PaymentNotification.fromMap(e)).toList();
      }
    } catch (Exception) {
       print("Failed");
    }
  }
  
Future<List<PaymentNotification>?> GetNotificationforBuyer(String sellerid,String status)async {
    try {
      String uri = "${ip}Payment/getNotificationForBuyer";
      var response = await http.get(
          Uri.parse(uri).replace(queryParameters: {
            "buyer_id":sellerid.toString(),
            "status": status.toString()
          }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      print(response.body);
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        return data.map((e) => PaymentNotification.fromMap(e)).toList();
      }
    } catch (Exception) {
       print("Failed");
    }
  }
  Future<List<PaymentNotification>?> GetNotificationfordistributor(String sellerid,String status)async {
    try {
      String uri = "${ip}Payment/getNotificationForDistributor";
      var response = await http.get(
          Uri.parse(uri).replace(queryParameters: {
            "id":sellerid.toString(),
            "status": status.toString()
          }),
              headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body);
        return data.map((e) => PaymentNotification.fromMap(e)).toList();
      }
    } catch (Exception) {
       print("Failed");
    }
  }
  
  

  Future<int> addPayment(String sellerid , String buyerid, String amount,String paymentDate) async {
    try {
      String uri = "${ip}Payment/AddPayment";
      var response = await http.post(
          Uri.parse(uri)
              .replace(queryParameters: {
                "seller_id": sellerid.toString(),
                "buyer_id":buyerid.toString(),
                "amount":amount.toString(),
                "Payment_date":paymentDate.toString()
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return response.statusCode;
    } catch (Exception) {
      print("Failed");
      return 123;
    }
  }

  Future<Payment?> getPayment(String sellerid , String buyerid) async {
    try {
      String uri = "${ip}Payment/getPayment";
      var response = await http.get(
          Uri.parse(uri)
              .replace(queryParameters: {
                "seller_id": sellerid.toString(),
                "buyer_id":buyerid.toString(),
                }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        if(data!=null)
        {
          return Payment.fromMap(data);
        }
        else
        {
          Payment? p ;
          return p;
        }
      }
    } catch (Exception) {
      print("Failed");
    }
  }

}
