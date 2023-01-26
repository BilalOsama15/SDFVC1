class Vendor_distributor{
  String? distributorstatus;
  int? securityamount,vendorId,distributorId;
  Vendor_distributor(this.distributorstatus,this.securityamount,this.vendorId,this.distributorId);
  Map<String,dynamic> toMap()
{
  Map<String,dynamic> m = Map<String,dynamic>();
  m["distributor_status "]=distributorstatus;
  m["security_amount "]=securityamount;
  m["vendor_id"]=vendorId;
  m["distributor_id"]=distributorId;
  return m;
}
Vendor_distributor.fromMap(Map<dynamic,dynamic> m)
{
  distributorstatus=m["distributor_status"];
  securityamount=m["security_amount"];
  vendorId=m["vendor_id"];
  distributorId=m["distributor_id"];
}
}
