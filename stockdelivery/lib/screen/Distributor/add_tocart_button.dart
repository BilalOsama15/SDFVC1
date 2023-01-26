import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockdelivery/apisetget/VendorsAPI/ProductApis.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/Db_helper.dart';
import 'package:stockdelivery/models/cart_model.dart';
import 'package:stockdelivery/models/cart_provider.dart';
import 'package:stockdelivery/models/lists.dart';
import 'package:stockdelivery/models/products.dart';

import '../../models/provider.dart';

class addtocart_button extends StatefulWidget {
  products p;
   addtocart_button({
    Key? key,
    required this.p,
  }) : super(key: key);

  @override
  State<addtocart_button> createState() => _addtocart_buttonState(p);
}
class _addtocart_buttonState extends State<addtocart_button> {
  DBHelper db = DBHelper();
  products? pro;
  _addtocart_buttonState(this.pro);
  @override
  @override
  Widget build(BuildContext context) {
      bool isadded=false;
      final cart  = Provider.of<cartprovider>(context);
   return Container(
                      height: 50,width: 190,
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap:(){
                          if(pro!.total_no_of_cartons >= int.parse(pro!.threshold.toString()))
                          {
                            db.insert(Cart(

                            id: pro!.id,
                            productId: pro!.id.toString(),
                            productName: pro!.pname,
                            initialPrice: pro!.saleprice_per_carton,
                            productPrice: int.parse(pro!.threshold.toString())*int.parse(pro!.saleprice_per_carton.toString()),
                            quantity: pro!.threshold,
                            threshold: pro!.threshold,
                            image: pro!.pimage

                            )
                            
                            ).then((value) {

                              cart.addCounter();
                              cart.addTotalPrice(double.parse(pro!.saleprice_per_carton.toString())*double.parse(pro!.threshold.toString()) );
                              final snackBar = SnackBar(backgroundColor: Colors.green,content: Text('Product is added to cart'), duration: Duration(seconds: 1),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            }).onError((error, stackTrace) {
                              
                              print(error.toString());
                              final snackBar = SnackBar(backgroundColor: Colors.red ,content: Text('Product is already added in cart'), duration: Duration(seconds: 1));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            });
                          }
                          else
                          {
                            final snackBar = SnackBar(backgroundColor: Color.fromARGB(255, 111, 54, 244) ,content: Text('Quantity is low as threashold'), duration: Duration(seconds: 1));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          
                            
                          
                        },
                        child: Container(height: 40,width: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: isadded?Icon(Icons.done,color: Colors.white,size: 18,):Icon(Icons.shopping_cart,color: Colors.white,size: 18,),
                          )
                          
                        ),
                      );
                      

  }
}

