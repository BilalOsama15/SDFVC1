class addstock{

  int id=0;
  String? mfgdate,expdate;
  int? noofcartons,VproductId;
  addstock(this.noofcartons,this.mfgdate,this.expdate,this.VproductId);
Map<String,dynamic> toMap()
{
  Map<String,dynamic> m = Map<String,dynamic>();
  m["no_of_cartons"]=noofcartons;
  m["mfg_date "]=mfgdate;
  m["expiry_date "]=expdate;
  m["vendor_productid "]=VproductId;
  return m;
}
addstock.fromMap(Map<dynamic,dynamic> m)
{
  id=m["id"];
  noofcartons=m["no_of_cartons"];
  mfgdate=m["mfg_date"];
  expdate=m["expiry_date"];
  VproductId=m["vendor_productid"];
}


}