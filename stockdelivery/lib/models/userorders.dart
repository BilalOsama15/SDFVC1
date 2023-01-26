import 'Items.dart';
import 'cart_model.dart';

class userorders
{
  int id=0;
  int? amount_paid=0,order_state=0;
  String? order_status="",order_type="",order_place_date="",order_deliver_date="";
  int? total_amount,seller_id,buyer_id;
  List<items>? item;
  userorders(this.total_amount,this.seller_id,this.buyer_id,this.item);

  Map<String,dynamic> toMap()
{
  Map<String,dynamic> m = Map<String,dynamic>();
  m["total_amount"]=total_amount;
  m["seller_id"]=seller_id;
  m["buyer_id"]=buyer_id;
  if(item!=null){
    m["cart_items"]=item!.map((e) => e.toMap()).toList();
  }

  return m;
}

userorders.fromMap(Map<dynamic,dynamic> m)
{
  id=m["id"];
  order_status=m["order_status"];
  order_type=m["order_type"];
  order_place_date=m["order_place_date"];
  order_deliver_date=m["order_deliver_date"];
  total_amount=m["total_amount"];   
  seller_id=m["seller_id"];
  buyer_id=m["buyer_id"];
  

}
userorders.fromMaps(Map<dynamic,dynamic> m)
{
  id=m["id"];
  order_status=m["order_status"];
  order_type=m["order_type"];
  order_place_date=m["order_place_date"];
  order_deliver_date=m["order_deliver_date"];
  total_amount=m["total_amount"];   
  order_state = m["order_state"];
  amount_paid=m["amountPaid"];

}
}

