class products{
  int id=0,total_no_of_cartons=0;
  String pimage="";
  String? pname,category,description,companyName; 
  int? quantitypercarton,threshold,saleprice_per_carton,userid;

products(this.pname,this.companyName,this.quantitypercarton,this.saleprice_per_carton,this.threshold,this.category,this.description,this.userid);

Map<String,dynamic> toMap()
{
  Map<String,dynamic> m = Map<String,dynamic>();
  
  m["name"]=pname;
  m["company_name"]=companyName;
  m["qty_in_carton"]=quantitypercarton;
  m["saleprice_per_carton"]=saleprice_per_carton;
  m["threshold"]=threshold;
  m["category"]=category;
  m["description"]=description;
  m["vendor_id"]=userid;

  return m;
}
products.fromMap(Map<dynamic,dynamic> m)
{
  id=m["id"];
  pname=m["name"];
  companyName=m["company_name"];
  quantitypercarton=m["qty_in_carton"];
  saleprice_per_carton=m["saleprice_per_carton"];
  total_no_of_cartons=m["total_no_of_cartons"];
  threshold=m["threshold"];
  category=m["category"];
  description= m["description"];
  pimage=m["image"]; 
  userid=m["vendor_id"];
}


}