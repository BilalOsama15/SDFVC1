import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stockdelivery/mywidget/usertypeDropDown.dart';
import 'package:stockdelivery/screen/Vendor/Vendor_drawer.dart';
import '../../../methods/apicalling.dart';
import '../../../models/products.dart';
import '../../../mywidget/Mywidget.dart';
class additems extends StatefulWidget {
  const additems({Key? key}) : super(key: key);

  @override
  State<additems> createState() => _additemsState();
}
File? _imgfile;
var _formkey=GlobalKey<FormState>();
TextEditingController _productName = TextEditingController();
TextEditingController _quantitypercarton = TextEditingController();
TextEditingController _threshold = TextEditingController();
TextEditingController _price_per_carton = TextEditingController();
TextEditingController _category = TextEditingController();
TextEditingController _company_Name = TextEditingController();
TextEditingController _description = TextEditingController();
class _additemsState extends State<additems> {
  var _data=[
    "Drinks",
    "Dairy",
    "Frozen",
    "Sweets",
    "Snacks",
    "Daily Usage",
    "Others"
  ];
  @override
  void initState() {
    _company_Name.text = usermodel!.uname.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: appbar("Add Products"),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
          child: Center(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CircleAvatar(radius: 50,
                child: ClipOval(child: _imgfile==null?Image.asset('assets/images/logo.png',height: 90,width: 90,fit: BoxFit.cover,):Image.file(_imgfile!,height: 90,width: 150,fit: BoxFit.cover,))),
                IconButton(onPressed: () async {
                      _imgfile = await getimage(context);
                      setState(() {  });
                    }, icon: Icon(Icons.edit),padding: EdgeInsets.only(top: 50.0),),
              ],),
                  SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Form(
                      key: _formkey,
                      child: Column(children: [
                      loginTextField(controller:_productName,text: "Product Name",icon: Icons.dynamic_form, type: TextInputType.name ), SizedBox(height: 7,),
                    loginTextField(controller:_quantitypercarton,text: "Quantity Per Carton",icon: Icons.dynamic_form, type: TextInputType.number ), SizedBox(height: 7,),
                    loginTextField(controller:_threshold,text: "Threshold",icon: Icons.dynamic_form, type: TextInputType.number ), SizedBox(height: 7,),
                    loginTextField(controller:_price_per_carton,text: "Price Per Carton",icon: Icons.dynamic_form, type: TextInputType.number ), SizedBox(height:7,),
                    dropdown(usertype: _category,data: _data,text: "Select Category",),SizedBox(height:7,),
                    loginTextFieldfixed(controller:_company_Name,text: "Enter company Name",icon: Icons.dynamic_form, type: TextInputType.text ), SizedBox(height: 7,),
                    loginTextField(controller:_description,text: "Enter Description",icon: Icons.dynamic_form, type: TextInputType.text ), SizedBox(height: 7,),
                    ElevatedButton(onPressed: () async {
                      
                      if(_formkey.currentState!.validate())
                      {
                        
                      await  showDialog(context: context, builder:(Builder){
                          return AlertDialog(
                            title: Text("Are You Sure You Want To add"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("No")),
                              TextButton(onPressed: ()async{
                                products pro=products(_productName.text.toString(),_company_Name.text.toString(), int.parse(_quantitypercarton.text), int.parse(_price_per_carton.text) ,int.parse(_threshold.text), _category.text.toString(), _description.text.toString(),usermodel!.id);
                              showLoader(context);
                            int status= await proapis.saveproduct(pro,_imgfile!);
                              hideLoader(context);
                                setState(() {
                                  Navigator.pop(context);
                                  Navigator.pop(ctx);
                                });
                                if(status==200)
                                {
                                  showSnackBar(context, "Product Add Successfully Added",Colors.green);
                                }
                                else
                                {
                                  showSnackBar(context, "Product Not Added! Try Again Later",Colors.red);
                                }

                              }, child: Text("Yes")),
                              
                            ],
                          );
                        });
                      }
                    }, child: Text("Add Product"),style: ElevatedButton.styleFrom(primary: Colors.black,minimumSize: Size.fromHeight(50)),)

                    ],))
                    
      
            ],),
          ),
        ),
      )
        
        
      );
  }
}


