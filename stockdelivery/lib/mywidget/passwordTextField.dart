import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class textfieldpassword extends StatefulWidget {
  TextEditingController password;
   textfieldpassword({Key? key , required this.password }) : super(key: key);

  @override
  State<textfieldpassword> createState() => _textfieldpasswordState(password);
}

class _textfieldpasswordState extends State<textfieldpassword> {
  TextEditingController Password;
  _textfieldpasswordState(this.Password);
  bool isVisible=false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: Password,
                     validator: (value){
                     if(value==null || value.isEmpty) {
                       return "Field Cannot be empty";
                      }
                      // else if(value.length<=7)
                      // {
                      // return "Password Must be at 8 Character Long";
                      // }
                      return null;
                      },
                      keyboardType:TextInputType.text ,
                      obscureText: !isVisible,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(label: Text("Enter Password"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),gapPadding: 10.0),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: isVisible?Icon(Icons.visibility):
                        Icon(Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            isVisible = !isVisible;
                          });
                         },)
                  ));
  }
}