import 'Credit_management.dart';
import 'orders.dart';
import 'products.dart';
import 'rdistributors.dart';
import 'signin.dart';
import 'users.dart';

List<products> product=[
      products("MilkPack","doodh", 200, 6, 30,'Milk',"asd",1004),
      

  ];
  List<modelsignin> sign=[
      modelsignin("osama","Rawalpindi","PIA Colony","0334-2343242","osama","osama123","vendor","unapproved"),
      modelsignin("bilal","Lahore","Data Darbar","0212-1232343","bilal","bilal123","distributor","unapproved"),

  ];
  List<users> Users=[
      users("Osama","osama@gmail.com","0333-5656565","vendor","Rawalpindi","Dairy"),
      users("Bilal","bilal@gmail.com","0312-1212565","distributor","Rawalpindi","Drinks"),
      users("saad","saad@gmail.com","0332-1214541","vendor","GojerKhan","Drinks"),

  ];
   List<rdistributors> rdistributor=[
      rdistributors("Abdullah","abdullah@gmail.com","0333-5656565","approved",250000,"Rawalpindi"),
      rdistributors("Mehraj","mehraj@gmail.com","0312-1212565","unapproved",0,"Rawalpindi"),
      rdistributors("Mateen","mateen@gmail.com","0332-1214541","approved",500000,"GojerKhan"),

  ];
   
   List<orders> ordered=[
      orders("abdullah","osama@gmail.com","0313-5656565",250000,"distributor","Active","Rawalpindi"),
      orders("mehraj","mehraj@gmail.com","0342-5474765",300000,"shopkeeper","Active","tench bata"),
      orders("saad","saad@gmail.com","0322-5656565",600000,"shopkeeper","completed","Rawalpindi"),
      orders("mateen","mateen@gmail.com","0312-5656565",100000,"distributor","completed","gojerkhan"),
      orders("osama","osama@gmail.com","0312-5656565",40000,"vendor","Active","range road"),
      orders("arif","arif@gmail.com","0312-5656565",120000,"vendor","completed","range road")

  ];
   List<credits> creditss=[
      credits("Abdullah","abdullah@gmail.com","0333-5656565",250000,"shopkeeper","Active","Rawalpindi"),
      credits("Mehraj","mehraj@gmail.com","0312-1212565",23500,"distributor","Active","Rawalpindi"),
      credits("Mateen","mateen@gmail.com","0332-1214541",500000,"distributor","completed","GojerKhan"),
      credits("saad","abdullah@gmail.com","0333-5656565",250000,"shopkeeper","completed","Rawalpindi"),
      credits("ali","mehraj@gmail.com","0312-1212565",23500,"vendor","Active","Rawalpindi"),
      credits("umer","mateen@gmail.com","0332-1214541",500000,"vendor","completed","GojerKhan"),
  ];