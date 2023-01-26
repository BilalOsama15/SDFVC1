class payments{
  int? paid_amount, seller_id,buyer_id;
  String? payment_date;

  payments(this.paid_amount, this.payment_date, this.seller_id,this.buyer_id);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = Map<String, dynamic>();
    m["paid_amount"] = paid_amount;
    m["payment_date"] = payment_date;
    m["seller_id"] = seller_id;
    m["buyer_id"] = buyer_id;
    
    return m;
  }

  payments.fromMap(Map<dynamic, dynamic> m) {
    paid_amount = m["paid_amount"];
    payment_date = m["payment_date"];
    seller_id = m["seller_id"];
    buyer_id = m["buyer_id"];
  }
}