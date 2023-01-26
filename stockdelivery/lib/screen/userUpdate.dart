import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/signin.dart';
import 'package:stockdelivery/mywidget/Mywidget.dart';

import '../mywidget/passwordTextField.dart';

class userupdate extends StatefulWidget {
  const userupdate({Key? key}) : super(key: key);

  @override
  State<userupdate> createState() => _userupdateState();
}
  File? _imgfile;
class _userupdateState extends State<userupdate> {
  TextEditingController _email = TextEditingController();
  TextEditingController _Password = TextEditingController();

  bool _isawait=false;
  var _formkey=GlobalKey<FormState>();
  @override
  void initState() {
    _email.text = usermodel!.uemail.toString();
    _Password.text = usermodel!.upassword.toString();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Update User"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
                key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(height: 70,),
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      CircleAvatar(radius: 100,
                      child: ClipOval(child: _imgfile==null?Image.network(userimage+usermodel!.uimage,height: 200,width: 200,fit: BoxFit.cover,):Image.file(_imgfile!,height: 200,width: 200,fit: BoxFit.cover,))),
                      IconButton(onPressed: () async {
                            _imgfile = await getimage(context);
                            setState(() {  });
                          }, icon: Icon(Icons.edit),padding: EdgeInsets.only(top: 100.0),),
                    ],),
                    SizedBox(height: 100,),
                    loginTextField(
                          controller: _email,text: "Enter Email",
                          icon: Icons.email,
                          type: TextInputType.emailAddress
                          ),SizedBox(height: (height(context)/10)-46,),
            
                          textfieldpassword(password: _Password),
                          SizedBox(height: 50,),
                    ElevatedButton(onPressed: () async {
                        if(_formkey.currentState!.validate())
                            {
                            modelsignin m = modelsignin(usermodel!.uname, usermodel!.ucity, usermodel!.baddress, usermodel!.umobileno, _email.text.toString(), _Password.text.toString(), usermodel!.userType, usermodel!.accountStatus);

                              showLoader(context);
                            int status= await userapi.updateuser(m,_imgfile!,usermodel!.id);
                              hideLoader(context);
                              
                              status==200? showSnackBar(context, "User Update Successfully", Colors.green):
                              showSnackBar(context, "Not Updated", Colors.red);
                          
                            }
                    },child: Text("Update"),

                      style: ElevatedButton.styleFrom(primary: Colors.black,
                       minimumSize: const Size.fromHeight(50), // NEW
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}