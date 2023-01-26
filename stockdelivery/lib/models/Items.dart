class items{
  String pname="", pimage="";
  int? productid;
  int? productquantity;
  int? productPrice;


  items(this.productid,this.productquantity,this.productPrice);

    Map<String,dynamic> toMap()
{
  Map<String,dynamic> m = Map<String,dynamic>();
  m["product_id"]=productid;
  m["qty_ordred"]=productquantity;
  m["product_price"]=productPrice;
  
  return m;
}

items.fromMap(Map<dynamic,dynamic> m)
{

  productid=m["pid"];
  productquantity=m["qty_ordred"];
  productPrice = m["product_price"];
  pimage = m["pimage"];
  pname = m["pname"];
}

}