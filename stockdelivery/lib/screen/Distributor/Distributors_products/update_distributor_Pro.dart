import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../methods/apicalling.dart';
import '../../../models/products.dart';
import '../../../mywidget/Mywidget.dart';

class updateDistributorProduct extends StatefulWidget {
  final products pro;
  const updateDistributorProduct({Key? key, required this.pro}) : super(key: key);

  @override
  State<updateDistributorProduct> createState() => _updateDistributorProductState(pro);
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
class _updateDistributorProductState extends State<updateDistributorProduct> {
  void initState() {
    super.initState();
    _productName.text=pro.pname.toString();
    _quantitypercarton.text=pro.quantitypercarton.toString();
    _threshold.text=pro.threshold.toString();
    _price_per_carton.text=pro.saleprice_per_carton.toString();
    _company_Name.text=pro.companyName.toString();
    _category.text=pro.category.toString();
    _description.text=pro.description.toString();
    
  }
  _updateDistributorProductState(this.pro);
  products pro;
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: appbar("Update Distributor Products"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
          child: Center(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CircleAvatar(radius: 50,
                child: ClipOval(child: _imgfile==null?Image.network(productimage+pro.pimage,height: 90,width: 90,fit: BoxFit.cover,):Image.file(_imgfile!,height: 90,width: 150,fit: BoxFit.cover,))),
                
              ],),
              SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Form(
                      key: _formkey,
                      child: Column(children: [
                    loginTextFieldfixed(controller:_productName,text: "Product Name",icon: Icons.dynamic_form, type: TextInputType.name ), SizedBox(height: 7,),
                    loginTextFieldfixed(controller:_quantitypercarton,text: "Quantity Per Carton",icon: Icons.dynamic_form, type: TextInputType.number ), SizedBox(height: 7,),
                    loginTextField(controller:_price_per_carton,text: "Change Price Per Carton",icon: Icons.dynamic_form, type: TextInputType.number ), SizedBox(height:7,),
                    loginTextFieldfixed (controller:_company_Name,text: "Company Name",icon: Icons.dynamic_form, type: TextInputType.text ), SizedBox(height: 7,),
                    loginTextFieldfixed (controller:_category,text: "Category",icon: Icons.dynamic_form, type: TextInputType.text ), SizedBox(height: 7,),
                    loginTextFieldfixed(controller:_description,text: "Enter Description",icon: Icons.dynamic_form, type: TextInputType.text ), SizedBox(height: 7,),
                    ElevatedButton(onPressed: () async {
                      if(_formkey.currentState!.validate())
                      {
                      await  showDialog(context: context, builder:(Builder){
                          return AlertDialog(
                            title: Text("Are You Sure You Want To Update"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("No")),
                              TextButton(onPressed: ()async{
                               showLoader(context);
                              int status= await D_P.updateDistProduct(usermodel!.id,pro.id,_price_per_carton.text);
                                hideLoader(context);
                                Navigator.pop(context);
                                setState(() {
                                  
                                });
                                if(status==200)
                                {
                                  showSnackBar(context, "Product Updated Successfully", Colors.green);
                                }
                                else
                                {
                                  showSnackBar(context, "Product Not Updated", Colors.red);
                                }
                              }, child: Text("Yes")),
                              
                            ],
                          );
                        });
                      }
                    }, child: Text("Update Sale Price"),style: ElevatedButton.styleFrom(primary: Colors.black,minimumSize: Size.fromHeight(50)),)

                    ],))
                    
      
            ],),
          ),
        ),
      ),
    );
  }
}