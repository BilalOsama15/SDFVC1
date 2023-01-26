import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/mywidget/passwordTextField.dart';
import 'package:stockdelivery/mywidget/usertypeDropDown.dart';
import 'package:stockdelivery/screen/Login.dart';
import '../apisetget/VendorsAPI/UserApis.dart';
import '../models/signin.dart';
import '../mywidget/Mywidget.dart';
import 'Vendor/Vendor_dashbooard.dart';
import 'Vendor/Vendor_drawer.dart';
class signin extends StatefulWidget {

  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  File? _imgfile;
  TextEditingController _name = TextEditingController();
    TextEditingController _Password = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _mobileno = TextEditingController();
    TextEditingController _usertype = TextEditingController();
    TextEditingController _city = TextEditingController();
    TextEditingController _address = TextEditingController();
    String btntext="Sign up";
    bool _isawait=false;

      var _types = [
    "vendor",
    "distributor",
    "shopkeeper"
  ];
      var _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isVisisble=false;
    return Scaffold(
       appBar: appbar("Signin"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            image: _imgfile==null?DecorationImage(
                              image: AssetImage('assets/images/logo.png'),fit: BoxFit.cover
                              ):DecorationImage(image: FileImage(_imgfile!),fit: BoxFit.cover)
                              )
                              ),
                         SizedBox(width: width(context)/18,), 
                         ElevatedButton(onPressed: () async {
                        _imgfile =await getimage(context);
                            setState(() {
                              
                            });
                          }, 
                          child: Text('Load Pic',style: TextStyle(fontSize: 20,),)
                          )
                      ],),
                    ),
                    SizedBox(height: height(context)/37,),                    
                        loginTextField(controller: _name,text: "Enter Name",icon: Icons.people,type: TextInputType.name),SizedBox(height: (height(context)/50)-5.16,),
                        loginemailTextField(controller: _email,text: "Enter Email",icon: Icons.email,type: TextInputType.emailAddress),SizedBox(height: (height(context)/50)-5.16,),
                        textfieldpassword(password: _Password),SizedBox(height: (height(context)/50)-5.16,),
                        loginTextField(controller: _mobileno,text: "Enter Mobile No",icon: Icons.mobile_friendly_outlined,type: TextInputType.phone),SizedBox(height: (height(context)/50)-5.16,),
                        dropdown(usertype: _usertype,data: _types,text: "Select User Type",), SizedBox(height: (height(context)/50)-5.16,),
                        loginTextField(controller: _city,text: "Enter City",icon: Icons.location_city,type: TextInputType.streetAddress),SizedBox(height: (height(context)/50)-5.16,),
                        loginTextField(controller: _address,text: "Enter Address",icon: Icons.location_on_outlined,type: TextInputType.streetAddress),SizedBox(height: (height(context)/50)-5.16,),
                        ElevatedButton(onPressed: ()async{
                          if(_formkey.currentState!.validate())
                          {
                            if(_imgfile!=null)
                            {
                                modelsignin s=modelsignin(_name.text.toString(),_city.text.toString(),_address.text.toString(),_mobileno.text.toString(),_email.text.toString(),_Password.text.toString(),_usertype.text.toString(),"unapproved");
                               setState(() {
                                 _isawait=true;
                                 btntext="Please Wait...";
                               });
                                await userapi.postdata(s,_imgfile!);
                                setState((){
                                  _isawait=false;
                                });
                                print(res);
                                if(res==200)
                                {
                                  Navigator.push(context,
                                 MaterialPageRoute(builder: (context) => const Login()));
                                }
                                else 
                                {
                                    btntext="Something Wrong! Try Again Later";
                                  await Future.delayed(Duration(seconds: 3));
                                    setState(() {
                                      btntext="Sign up Again";
                                    });
                                }
                              }
                              else
                              {
                                btntext="Please Select Image ?";
                                setState(() {
                                  
                                });
                                await Future.delayed(Duration(seconds: 2));
                                    setState(() {
                                      btntext="Sign up";
                                    });
                              }
                            }
                       }, child: _isawait?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),SizedBox(width: 20,),
                          Text(btntext)
                        ],
                       ):Text(btntext) ,
                       style: ElevatedButton.styleFrom(primary: Colors.black,
                       minimumSize: const Size.fromHeight(50), // NEW
                    ),)
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
