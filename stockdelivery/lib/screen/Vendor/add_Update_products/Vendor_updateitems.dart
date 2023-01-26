import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stockdelivery/mywidget/usertypeDropDown.dart';
import '../../../methods/apicalling.dart';
import '../../../models/products.dart';
import '../../../mywidget/Mywidget.dart';
class updateitems extends StatefulWidget {
 final products product;
  const updateitems({Key? key,required this.product}) : super(key: key);

  @override
  State<updateitems> createState() => _updateitemsState(product);
}
File? _imgfile;
var _formkey=GlobalKey<FormState>();
TextEditingController _productName = TextEditingController();
TextEditingController _quantitypercarton = TextEditingController();
TextEditingController _threshold = TextEditingController();
TextEditingController _price_per_carton = TextEditingController();
TextEditingController _company_Name = TextEditingController();
TextEditingController _description = TextEditingController();
  
class _updateitemsState extends State<updateitems> {
    var _data=[
    "Drinks",
    "Dairy",
    "Sweets",
    "Snacks",
    "Frozen",
    "Daily Usage",
    "Others"
  ];
  products pro;
  _updateitemsState(this.pro);
  @override
  void initState() {
    super.initState();
    _productName.text=pro.pname.toString();
    _quantitypercarton.text=pro.quantitypercarton.toString();
    _threshold.text=pro.threshold.toString();
    _price_per_carton.text=pro.saleprice_per_carton.toString();
    _company_Name.text=pro.companyName.toString();
    _description.text=pro.description.toString();
    
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
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
                    loginTextFieldfixed (controller:_company_Name,text: "Enter company Name",icon: Icons.dynamic_form, type: TextInputType.text ), SizedBox(height: 7,),
                    loginTextField(controller:_description,text: "Enter Description",icon: Icons.dynamic_form, type: TextInputType.text ), SizedBox(height: 7,),
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
                                int status;
                              products _pro=products(_productName.text.toString(),_company_Name.text.toString(), int.parse(_quantitypercarton.text), int.parse(_price_per_carton.text),int.parse(_threshold.text), pro.category.toString(), _description.text.toString(),usermodel!.id);
                               showLoader(context);
                               _imgfile==null?
                                status = await proapis.updateProductpro(pro.id.toString(),_pro)
                              :status= await proapis.updateProduct(pro.id.toString(),_pro,_imgfile!);
                              _imgfile=null;
                                hideLoader(context);
                                Navigator.pop(context);
                                Navigator.pop(ctx);
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
                    }, child: Text("Update Product"),style: ElevatedButton.styleFrom(primary: Colors.black,minimumSize: Size.fromHeight(50)),)

                    ],))
                    
      
            ],),
          ),
        ),
      )
    );
  }
}
