import 'package:stockdelivery/models/products.dart';
import 'package:stockdelivery/models/registeredBuyer.dart';
import 'package:stockdelivery/models/userorders.dart';

import 'Items.dart';
import 'Items.dart';
import 'Items.dart';

class modelsignin{
int id=0;
String uimage="";
String? status;
int rating =0, remaining_credit=0;
List<items>? item;
List<products>? product;
String? uname,upassword,uemail,umobileno,userType,ucity,baddress,accountStatus;
modelsignin(this.uname,this.ucity,this.baddress,this.umobileno,this.uemail,this.upassword,this.userType,this.accountStatus);

Map<String,dynamic> toMap()
{
  Map<String,dynamic> m = Map<String,dynamic>();
  m["name"]=uname;
  m["city"]=ucity;
  m["address"]=baddress;
  m["mobile_no"]=umobileno;
  m["email"]=uemail;
  m["password"]=upassword;
  m["roles"]=userType;
  m["account_status"]=accountStatus;
  return m;
}
modelsignin.fromMap(Map<dynamic,dynamic> m)
{
  id=m["id"];
  uname=m["name"];
  ucity=m["city"];
  baddress=m["address"];
  umobileno=m["mobile_no"];
  uemail=m["email"];
  upassword=m["password"];
  uimage=m["image"];
  userType=m["roles"];
  accountStatus=m["account_status"];
  rating = m["rating"];
}
modelsignin.userWithCredit(Map<dynamic,dynamic> m)
{
  id=m["id"];
  uname=m["name"];
  ucity=m["city"];
  uimage=m["image"];
  userType=m["roles"];
  accountStatus=m["account_status"];
  rating = m["rating"];
  remaining_credit = m["remaining_credit"];
}
modelsignin.fromMaps(Map<dynamic,dynamic> m)
{
  id=m["id"];
  uname=m["name"];
  ucity=m["city"];
  baddress=m["address"];
  umobileno=m["mobile_no"];
  uemail=m["email"];
  uimage=m["image"];
  userType=m["roles"];
  accountStatus=m["account_status"];
  rating = m["rating"];
  status = m["status"];
  
  if(m["products"]!=null)
  {
    var data = m["products"] as List;
    product = data.map((e) => products.fromMap(e)).toList();
  }
    
}
modelsignin.orderDetails(Map<dynamic,dynamic> m)
{
  id=m["id"];
  uname=m["name"];
  ucity=m["city"];
  umobileno=m["mobile_no"];
  uemail=m["email"];
  uimage=m["image"];
  userType=m["roles"];
  accountStatus=m["account_status"];
  rating = m["rating"];
  if(m["products"]!=null)
  {
    var data = m["products"] as List;
    item = data.map((e) => items.fromMap(e)).toList();
  }
    
}

}
