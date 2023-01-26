import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:stockdelivery/models/signin.dart';

import '../../methods/apicalling.dart';
class userApi{

  // store user info for login..
Future<void> postdata(modelsignin user,File image)async{
  try{
          String uri="${ip}user/insertUser";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(uri),
    );
    request.headers.addAll({'Content-type': 'multipart/form-data'});
    request.files.add(await http.MultipartFile.fromPath("",image.path));
    request.fields.addAll({
    "name": user.uname.toString(),
    "city":user.ucity.toString(),
    "address" : user.baddress.toString(),
    "mobile_no" : user.umobileno.toString(),
    "email": user.uemail.toString(),
    "password":user.upassword.toString(),
    "roles":user.userType.toString(),
    "account_status": user.accountStatus.toString()
    });
    var response = await request.send();
      res=response.statusCode;
    print(response.statusCode);
  }catch(Exception){
    print("Failed");
  }  
}

Future<int> updateuser(modelsignin user,File image,int id)async{
  try{
          String uri="${ip}user/updateUser";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(uri),
    );
    request.headers.addAll({'Content-type': 'multipart/form-data'});
    request.files.add(await http.MultipartFile.fromPath("",image.path));
    request.fields.addAll({
    "id":id.toString(),
    "name": user.uname.toString(),
    "city":user.ucity.toString(),
    "address" : user.baddress.toString(),
    "mobile_no" : user.umobileno.toString(),
    "email": user.uemail.toString(),
    "password":user.upassword.toString(),
    "roles":user.userType.toString(),
    "account_status": user.accountStatus.toString()
    });
    var response = await request.send();
    print(response.statusCode);
    return response.statusCode;
  }catch(Exception){
    print("Failed");
    return 123;
  }

 
   
}


// get object of user for login check..
Future<modelsignin?> getData(String email,String pass) async
  {
    try{
      String uri="${ip}user/getlogin";
var response=await http.get(Uri.parse(uri).
  replace(queryParameters: {"uemail":email.toString(),"upassword":pass.toString()}),
  headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8' }
  );  
  res = response.statusCode;
    if(response.statusCode==200)
    {

      return modelsignin.fromMap(jsonDecode(response.body));      
    }
    else
    {print(response.body);}
    
    }catch(Exception){
      
      print("failed");
          }
  }
  


}