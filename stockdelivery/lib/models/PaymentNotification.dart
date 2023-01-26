class PaymentNotification {
  int id = 0,nid=0;
  int? payAmount;
  String? buyerName, buyerType,payDate,status;

  PaymentNotification(this.buyerName,this.buyerType,this.payAmount,this.payDate);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> m = Map<String, dynamic>();
    m["buyerName"] = buyerName;
    m["buyerType"] = buyerType;
    m["payDate"] = payDate;
    m["payAmount"] = payAmount;    
    return m;
  }

  PaymentNotification.fromMap(Map<dynamic, dynamic> m) {
    id = m["id"];
    nid = m["nid"];
    buyerName = m["buyerName"];
    buyerType = m["buyerType"];
    status = m["status"];
    payDate = m["payDate"];
    payAmount = m["payAmount"];
  }
}
