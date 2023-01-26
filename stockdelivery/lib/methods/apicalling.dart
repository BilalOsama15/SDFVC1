import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:stockdelivery/apisetget/DistributorAPI/VendorsAPIs.dart';
import 'package:stockdelivery/apisetget/DistributorAPI/ordersApi.dart';
import 'package:stockdelivery/apisetget/ShopkeeperAPI/showproductsAPI.dart';
import 'package:stockdelivery/apisetget/VendorsAPI/Vendordistributor.dart';
import 'package:stockdelivery/apisetget/VendorsAPI/creditAPI.dart';
import 'package:stockdelivery/apisetget/ratingAPI.dart';
import 'package:stockdelivery/models/PaymentNotification.dart';
import 'package:stockdelivery/models/cart_model.dart';
import 'package:stockdelivery/models/shopkeeperDistributor.dart';
import 'package:stockdelivery/models/userorders.dart';

import '../apisetget/DistributorAPI/Distributor_products.dart';
import '../apisetget/ShopkeeperAPI/product_get_distributor.dart';
import '../apisetget/ShopkeeperAPI/product_getvendor.dart';
import '../apisetget/ShopkeeperAPI/providerList.dart';
import '../apisetget/VendorsAPI/ProductApis.dart';
import '../apisetget/VendorsAPI/UserApis.dart';
import '../apisetget/VendorsAPI/paymentAPI.dart';
import '../models/Items.dart';
import '../models/payments.dart';
import '../models/products.dart';
import '../models/signin.dart';
import '../models/userorders.dart';

// String ip="http://192.168.1.105/Credit_SDFVC/api/";                           
// int? res;
// String userimage="http://192.168.1.105/Credit_SDFVC/Images/userImages/";
// String productimage="http://192.168.1.105/Credit_SDFVC/Images/productImages/";

String ip="http://192.168.56.106/Credit_SDFVC/api/";                           
int? res;
String userimage="http://192.168.56.106/Credit_SDFVC/Images/userImages/";
String productimage="http://192.168.56.106/Credit_SDFVC/Images/productImages/";


// create refrences for Calling..
 productapis proapis = productapis();
vendorsAPI vendorapis=vendorsAPI();
userApi userapi = userApi();
V_D_api vd = V_D_api();
Distributor_order_APi D_O_A = Distributor_order_APi();
ratingapi Rateapi = ratingapi();
creditapi crapi = creditapi();
paymentapi pay = paymentapi();
showproductsApi S_products_api = showproductsApi();
getVendorProduct G_V_P = getVendorProduct();
getDistributorProduct G_D_P = getDistributorProduct();
Distributor_products D_P = Distributor_products();
registerShopkeeper R_S = registerShopkeeper(); 
paymentapi P_api = paymentapi();
// login user model...
modelsignin? usermodel;

// for order User Detail...
modelsignin? orderUser ;
//...


// create List of Future by getting data frfom api..
Future<List<products>?> userproducts=[] as Future<List<products>>;
Future<List<modelsignin>?> vendors=[] as Future<List<modelsignin>>;
Future<List<modelsignin>?> distributor=[] as Future<List<modelsignin>>;
Future<List<modelsignin>?> vendorsfororder=[] as Future<List<modelsignin>>;
Future<List<userorders>?> userorder=[] as Future<List<userorders>>;
Future<List<userorders>?> userorderfromdistributorside=[] as Future<List<userorders>>;
Future<List<items>?> orderdetails=[] as Future<List<items>>;
Future<List<products>?> distributorproducts=[] as Future<List<products>>;
Future<List<modelsignin>?> credituser=[] as Future<List<modelsignin>>;
Future<List<userorders>?> credituserorder=[] as Future<List<userorders>>;
Future<Payment?> paymen=Payment as Future<Payment?>;
Future<List<distributor_W_products>?> distributor_W_product=[] as Future<List<distributor_W_products>>;
Future<modelsignin?> userwithproduct = modelsignin as Future<modelsignin?>;
Future<List<PaymentNotification>?> paymentNotification =[] as Future<List<PaymentNotification>>;
Future<int?> NotificationLen = int as Future<int?>;


// Methods of calling api..

          // getting all products of single user..

        Future<List<products>?> getdata(int v)
            async {
          var data= await proapis.getproduct(v);
              return data;
            }
          Future<List<products>?> getdatafordistributor(int v)
            async {
          var data= await proapis.getdistributorProductforOrder(v);
              return data;
            }
            Future<products?> getsingleproductdata(int v)
            async {
          return await proapis.getsingleproduct(v);
              
            }

             Future<List<products>?> getDistributorProducts(int v)
            async {
              var data= await D_P.getDistProd(v);
              return data;
            }

              Future<List<PaymentNotification>?> getnotifications(String sellerid,String status)
            async {
              var data= await P_api.GetNotification(sellerid,status);
              return data;
            }
            Future<List<PaymentNotification>?> getnotificationsforbuyer(String sellerid,String status)
            async {
              var data= await P_api.GetNotificationforBuyer(sellerid,status);
              return data;
            }
            Future<List<PaymentNotification>?> getnotificationsfordistributor(String sellerid,String status)
            async {
              var data= await P_api.GetNotificationfordistributor(sellerid,status);
              return data;
            }
///////
            Future<modelsignin?> productGetByVendors(int v,int s)
            async {
               var data= await G_V_P.vendorbyProducts(v,s);
              return data;
            }
             Future<modelsignin?> productGetByvendorfromdistributorside(int v,int s)
            async {
               var data= await G_V_P.vendorbyProductsFdistributorSide(v,s);
              return data;
            }

            Future<List<modelsignin>?>registershopkeeper(int v,String s)
            async {
               var data= await R_S.getdistributorforapply(v,s);
              return data;
            }
            

             Future<List<distributor_W_products>?> productGetByDistributor(int v,int sid)
            async {
               var data= await G_D_P.distributorbyProducts(v,sid);
              return data;
            }

             Future<List<products>?> distributorsProduct(int uid)
            async {
                  print("3");
               var data= await G_D_P.distributorProducts(uid);
                   print("4");
              return data;
            }
            
             Future<List<products>?> getallproducts()
            async {
              var data= await S_products_api.showAllproducts();
              return data;
            }

          // getting all vendors to show in distributor dashboard..

        Future<List<modelsignin>?> getvendors(String id)async{
        var data= await vendorapis.getData(id);
        return data;
        }

         Future<List<modelsignin>?> getcredituser(int id,String type)async{
        var data= await crapi.getcreditusers(id,type);
        return data;
        }

         Future<List<modelsignin>?> getcredituserfordistributor(int id,String type)async{
        var data= await crapi.getcreditusersfordistributor(id,type);
        return data;
        }

        Future<List<modelsignin>?> getcredituserforshopkeeper(int id,String type)async{
        var data= await crapi.getcreditusersforShopkeeper(id,type);
        return data;
        }

        // show vendors in distributor side by category wise..

        Future<List<modelsignin>?> getcategory(String did,String category)async{
        var data= await vendorapis.getcategoryvendors(did,category);
        return data;
        }

         Future<List<modelsignin>?> getcategorymyvendors(String id, String status,String category)async{
        var data= await vendorapis.getcategorymyvendors(id,status,category);
        return data;
        }

        // getting all distributor that should be apply of this vendor..

        Future<List<modelsignin>?> getdistributorsforapply(int id,String status,String us)async{
        var data = await vd.getdistributorforapply(id.toString(),status,us);
        return data;
        }
        // getting Notification Length...
        Future<int?> getNotificationLength(int id,String type)async{
        var data = await P_api.NotificationLength(id.toString(),type);
        return data;
        }
        


          // getting all vendors using status in My Vendors screen...

        Future<List<modelsignin>?> statusvendors(String id,String status)async{
        var data= await vd.getallvendorstatus(id,status);
        return data;
        }

            Future<List<userorders>?> getorders(int sellerid,String status,int id)
            async {
               var data= await D_O_A.getallorders(sellerid,status,id);
              return data;
            }

            Future<List<userorders>?> getallordersfromdistributorsides(int buyerid,String status,String buyer_type,String id)
            async {
               var data= await D_O_A.getallordersfromdistributorside(buyerid,status,buyer_type,id);
              return data;
            }
            Future<List<userorders>?> getallordersfromShopkeepersides(int buyerid,String status,String type)
            async {
               var data= await D_O_A.getallordersfromShopkeeperside(buyerid,status,type);
              return data;
            }

            Future<List<userorders>?> creditusersorders(String buyerid,int sellerid)
            async {
               var data= await crapi.getcredituserorders(buyerid,sellerid);
              return data;
            }
              Future<List<userorders>?> creditusersordersfordistributor(String buyerid,String btype,int userid)
            async {
               var data= await crapi.getcredituserordersfordist(buyerid,btype,userid);
              return data;
            }
               Future<List<userorders>?> creditusersordersforShopkeeper(String buyerid,int id)
            async {
               var data= await crapi.getcredituserordersforShopkeeper(buyerid,id);
              return data;
            }
// ...
              Future<modelsignin?> getorderproducts(int oid)
            async {
               var data= await D_O_A.getordersdetails(oid);
              return data;
            }

              Future<List<modelsignin>?> getOrderUsers(int id,String type,String btype)async{
                var data= await D_O_A.getorderUser(id, type, btype);
                return data;
                }

                Future<List<modelsignin>?> getOrderUsersdistributor(int id,String type)async{
                var data= await D_O_A.getorderUserdistributor(id, type);
                return data;
                }
          

            Future<modelsignin?> getorderproductsfromdistributorside(int oid,String type)
            async {
               var data= await D_O_A.getordersdetailsfromdistributorside(oid,type);
              return data;
            }

            Future<modelsignin?> getorderproductsfromShopkeeperside(int oid,String type)
            async {
               var data= await D_O_A.getordersdetailsfromShopkeeperside(oid,type);
              return data;
            }

              Future<void> getordersdetails(int oid)
            async {
               await D_O_A.getordersdetails(oid);
            }

          Future<Payment?> getpayments(String seller_id,String buyer_id)
            async {
               var data= await P_api.getPayment(seller_id,buyer_id);
              return data;
            }




// Get Date
Future<String> getdatepicker(context)
async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), //get today's date
    firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2101)
    );
    String date = DateFormat('yMd').format(pickedDate!);
    return date;
}
String nowdate()
{
    var now = new DateTime.now();
    var formatter = new DateFormat('yMd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    return formattedDate;
}

// Sizing Of Screen

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

 height(BuildContext context) {
  return displaySize(context).height;
}

 width(BuildContext context) {
  return displaySize(context).width;
}

void showSnackBar(BuildContext context,text,color)
{
  final snackBar = SnackBar(backgroundColor: color,content: Text(text), duration: Duration(seconds: 1),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
  void showLoader(BuildContext context) {
    showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pink),
                  ),
                ),
              )
            ],
          ));
        });
  }

  void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }

