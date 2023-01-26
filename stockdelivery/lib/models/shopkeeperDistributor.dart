import 'dart:ffi';

import 'package:stockdelivery/apisetget/ShopkeeperAPI/providerList.dart';
import 'package:stockdelivery/models/registeredBuyer.dart';
import 'package:stockdelivery/models/signin.dart';

class distributor_W_products
{
  int? uid=0;
  String? uname="", ucity="", uemail="",uroles="",uimage="",uaccoutstatus="", umobileno="";
  Dis_productor? dp;
  String? status;
  distributor_W_products(this.uaccoutstatus,this.ucity,this.uemail,this.uid,this.uimage,this.umobileno,this.uname,this.uroles,this.dp);
//   Map<String,dynamic> toMap()
// {
//   Map<String,dynamic> m = Map<String,dynamic>();
//   m["umobileno"]=umobileno;
//   m["uname"]=uname;
//   m["ucity"]=ucity;
//   m["uemail"]=uemail;
//   m["uroles"]=uroles;
//   m["uimage"]=uimage;
//   m["uaccoutstatus"]=uaccoutstatus;
//   if(dp!=null)
//   {
//      m["dp"] = dp!.toMap();
//   }

//   return m;
// }

 distributor_W_products.fromMap(dynamic m)
{
  uid=m["uid"];
  uname=m["uname"];
  umobileno=m["umobileno"];
  ucity=m["ucity"];
  uemail=m["uemail"];
  uroles=m["uroles"];
  uimage=m["uimage"];
  uaccoutstatus=m["uaccoutstatus"];
  status=m["status"];
    print("2");
  dp=Dis_productor.fromMap(m["dp"]);
    print("3");

  
  
}

}
class Dis_productor{
  int pid=0,total_no_of_carton=0,saleprice_per_carton=0;
  String pname = "",category="";
  Dis_productor(this.category,this.pid,this.pname,this.saleprice_per_carton,this.total_no_of_carton);
// Map<String,dynamic> toMap()
// {
//   Map<String,dynamic> m = Map<String,dynamic>();
  
//   m["pname"]=pname;
//   m["total_no_of_carton"]=total_no_of_carton;
//   m["saleprice_per_carton"]=saleprice_per_carton;
//   m["category"]=category;

//   return m;
// }
 Dis_productor.fromMap(dynamic m)
{
 // return Dis_productor(m["category"] as String, m["pid"] as int , m["pname"] as String, m["saleprice_per_carton"] as int, m["total_no_of_carton"] as int);
  pid=m["pid"];
  pname=m["pname"];
  total_no_of_carton=m["total_no_of_carton"];
  saleprice_per_carton=m["saleprice_per_carton"];
  category=m["category"];
}
}