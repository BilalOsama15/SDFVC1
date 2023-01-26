import 'package:flutter/material.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/mywidget/passwordTextField.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_dashboard.dart';
import 'package:stockdelivery/screen/ShopKeeper/Fragments/Showproducts.dart';
import 'package:stockdelivery/screen/Vendor/Vendor_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apisetget/VendorsAPI/UserApis.dart';
import '../methods/apicalling.dart';
import '../mywidget/Mywidget.dart';
import 'ShopKeeper/Shopkeeper_dashboard.dart';
import 'Signin.dart';
import 'Vendor/Vendor_dashbooard.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
  
} 
    
String? email,pass;
TextEditingController _email = TextEditingController();
TextEditingController _Password = TextEditingController();
class _LoginState extends State<Login> {
  String btntext="Login";
  bool _isawait=false;
  var _formkey=GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    getlogindata();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Login"),
     
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Container(
              height: (height(context)/2)-29,
               child:Image.asset('assets/images/logo.png',height: (height(context)/7)-8,)
            ),
            Container(
              child: Form(
                key: _formkey,
                child: Column(children: [

                  loginTextField(
                    controller: _email,text: "Enter Email",
                    icon: Icons.email,
                    type: TextInputType.emailAddress
                    ),SizedBox(height: (height(context)/10)-46,),

                    textfieldpassword(password: _Password),
                  SizedBox(height: (height(context)/10)-56,),
                   
                    
                    ElevatedButton(onPressed: () async {
                      
                        if(_formkey.currentState!.validate())
                            {
                             
                              showLoader(context);
                              usermodel =  await userapi.getData(_email.text.toString(),_Password.text.toString());
                              hideLoader(context);
                              
                              print(res);
                              if(res==200)
                              {    
                                if(_email.text!=email||_Password.text!=pass)
                                { 
                                   savelogindata(_email.text.toString(), _Password.text.toString());
                                }
                                if( _email.text==usermodel!.uemail && _Password.text==usermodel!.upassword && usermodel!.userType=="vendor")
                                {
                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>  Vdashboard()));
                                }
                                else if( _email.text==usermodel!.uemail && _Password.text==usermodel!.upassword && usermodel!.userType=="distributor")
                                {
                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const Dis_dashboard()));
                                }
                                else if( _email.text==usermodel!.uemail && _Password.text==usermodel!.upassword && usermodel!.userType=="shopkeeper")
                                {
                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const shopkeeperDashboard()));
                                }

                              }
                              else
                              {
                               // showSnackBar();
                                btntext="Something Wrong! Try Again Later";
                                setState(() {
                                  
                                });
                                await Future.delayed(Duration(seconds: 2));
                                btntext="Login";
                                setState(() {
                                  
                                });
                              }
                              
                            }
                    },child: Text("Login"),

                      style: ElevatedButton.styleFrom(primary: Colors.black,
                       minimumSize: const Size.fromHeight(50), // NEW
                    )),

                    SizedBox(height: 10,),
                          
                  Text("If You have no Account"),
                  
                  TextButton(onPressed: (){
                             Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const signin()));
                          }, child: Text("Sign Up")) 
                ],),
              ),
            ),
          
          ],),
        ),
      ),
    );
  }
  Future<void> savelogindata(String email,String password)
async {
     SharedPreferences  prefs = await SharedPreferences.getInstance(); 
                            if(prefs!=null){
                            prefs.setString('email', _email.text.toString());
                            prefs.setString('password', _Password.text.toString());
                           
                          
                            }
}
Future<void> getlogindata()
async {
     SharedPreferences prefs = await SharedPreferences.getInstance(); 
     email=prefs.getString('email')!;
     pass=prefs.getString('password')!;
    _email.text = email!;
    _Password.text = pass!;

}
}




                            