import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/addstock.dart';
import 'package:stockdelivery/models/products.dart';
import '../../../mywidget/Mywidget.dart';

class dailystock extends StatefulWidget {
  final products product;
   dailystock({Key? key,required this.product }) : super(key: key);

  @override
  State<dailystock> createState() => _dailystockState(product);
}

class _dailystockState extends State<dailystock> {
  String? mfg="Manufacturing Date";
  String? exp="Expiry Date";
  TextEditingController _noofcartons = TextEditingController();
  var _formkey=GlobalKey<FormState>();
  products pro;
  _dailystockState(this.pro);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Container(
                  
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/background.jpg'),fit: BoxFit.cover)
                  ),
                    child: Container(
                      height: 250,
                  width: width(context),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Text("Add Daily Stock",style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              Container(
                height: 110,width: 110,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),border: Border.all(color: Colors.white,width: 3)),
                child: Image.network(productimage+pro.pimage,fit: BoxFit.cover,)),
                  SizedBox(height: 10,),
                  Text(pro.pname.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                        ],
                      )

                ),

                ),
                  SizedBox(height:20),
                  Container(
                    child: 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Form(
                      key: _formkey,
                      child:  loginTextField(controller: _noofcartons,text: "No of Cartons",icon: Icons.dynamic_form, type: TextInputType.number ),),
                        SizedBox(height: 15,),
                        TextButton.icon(onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                );
                if(pickedDate!=null)
                {
                  mfg = DateFormat('yMd').format(pickedDate);
                  setState(() {
                      
                  });
                }
                        }, icon: Icon(Icons.calendar_today,color: Colors.black,), label: Text(mfg.toString(),style: TextStyle(color: Colors.black))),


                SizedBox(height: 20,),
              
                TextButton.icon(onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                );
                if(pickedDate!=null)
                {
                  exp = DateFormat('yMd').format(pickedDate);
                  setState(() {
                      
                  });
                }
                
                        }, icon: Icon(Icons.calendar_today,color: Colors.black,), label: Text(exp.toString(),style: TextStyle(color: Colors.black),)),

                SizedBox(height: 20,),
                SizedBox(
                  width:200,
                  child: ElevatedButton(onPressed: ()async{
                    showLoader(context);
                  int status= await proapis.addStock(_noofcartons.text.toString(),mfg.toString(),exp.toString(),pro.id.toString());
                    hideLoader(context);
                    if(status==200)
                    {
                      showSnackBar(context, "Stock Successfully Added",Colors.green);
                    }
                    else
                    {
                      showSnackBar(context, "Stock Not Added Please try again later",Colors.red);
                    }
                  }, child: Text("Add Stock")))
                      
                  
                      ]),
                    ),
                  )
                  
            ],
          ),
        ),
      ),

    );
  }
}