class registeredbuyer{
  int id=0,seller_id=0,buyer_id=0,security_amount=0;
  String status = "";
registeredbuyer.fromMap(Map<dynamic,dynamic> m)
{
  id=m["id"];
  seller_id=m["seller_id"];
  buyer_id=m["buyer_id"];
  status=m["status"];
  security_amount=m["security_amount"];
  
}

}