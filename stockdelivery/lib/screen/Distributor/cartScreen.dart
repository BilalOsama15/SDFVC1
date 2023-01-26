import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockdelivery/methods/apicalling.dart';
import 'package:stockdelivery/models/cart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockdelivery/models/userorders.dart';
import '../../models/Db_helper.dart';
import '../../models/Items.dart';
import '../../models/cart_model.dart';


class CartScreen extends StatefulWidget {
  int seller_id;
   CartScreen({Key? key , required this.seller_id}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState(seller_id);
}

class _CartScreenState extends State<CartScreen> {
  int seller_id;
  _CartScreenState(this.seller_id);
int? newPrice;
int? quantity;
int? threshold;
int? price;
  DBHelper? dbHelper = DBHelper();       
  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<cartprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        actions: [
          Center(
            child: Badge(
              badgeContent: Consumer<cartprovider>(
                builder: (context, value , child){
                  return Text(value.getCounter().toString(),style: const TextStyle(color: Colors.white));
                },

              ),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
              future:cart.getData() ,
                builder: (context , AsyncSnapshot<List<Cart>> snapshot){
                if(snapshot.hasData){

                  if(snapshot.data!.isEmpty){
                    return Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage('assets/images/logo.png'),
                          ),
                          const SizedBox(height: 20,),
                          Text('Your cart is empty 😌' ,style: Theme.of(context).textTheme.headline5),
                          const SizedBox(height: 20,),
                          Text('Explore products and shop your\nfavourite items' , textAlign: TextAlign.center ,style: Theme.of(context).textTheme.subtitle2)

                        ],
                      ),
                    );
                  }else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(image: NetworkImage(productimage+snapshot.data![index].image.toString()),fit: BoxFit.cover)
                                          ),
                                         ),
                                        const SizedBox(width: 10,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot.data![index].productName.toString() ,
                                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                  ),
                                                  InkWell(
                                                      onTap: (){
                                                        dbHelper!.delete(snapshot.data![index].id!);
                                                        cart.removerCounter();
                                                        cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                                      },
                                                      child: const Icon(Icons.delete))
                                                ],
                                              ),

                                              const SizedBox(height: 5,),
                                              Text("Total Product Price"+" "+r"Rs/-"+ snapshot.data![index].productPrice.toString() ,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(height: 5,),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: (){


                                                  },
                                                  child:  Container(
                                                    height: 35,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child:  Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            
                                                              onTap: (){
                                                                threshold = snapshot.data![index].threshold!;
                                                                quantity =  snapshot.data![index].quantity! ;
                                                                price = snapshot.data![index].initialPrice!;
                                                                if(quantity!>threshold!)
                                                                {
                                                                   quantity = quantity! - 1;
                                                                newPrice = price! * quantity! ;
                                                              
                                                                  dbHelper!.updateQuantity(
                                                                      Cart(
                                                                          id: snapshot.data![index].id!,
                                                                          productId: snapshot.data![index].id!.toString(),
                                                                          productName: snapshot.data![index].productName!,
                                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                                          threshold: snapshot.data![index].threshold!,
                                                                          productPrice: newPrice,
                                                                          quantity: quantity,

                                                                          image: snapshot.data![index].image.toString())
                                                                  ).then((value){
                                                                    newPrice = 0 ;
                                                                    quantity = 0;
                                                                    cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                  }).onError((error, stackTrace){
                                                                    print(error.toString());
                                                                  });
                                                              }
                                                             
                                                              },
                                                              child: const Icon(Icons.remove , color: Colors.white,)),
                                                          Text( snapshot.data![index].quantity.toString(), style: const TextStyle(color: Colors.white)),
                                                          InkWell(
                                                              onTap: (){
                                                                int quantity =  snapshot.data![index].quantity! ;
                                                                int price = snapshot.data![index].initialPrice!;
                                                                quantity++;
                                                                int? newPrice = price * quantity ;

                                                                dbHelper!.updateQuantity(
                                                                    Cart(
                                                                        id: snapshot.data![index].id!,
                                                                        productId: snapshot.data![index].id!.toString(),
                                                                        productName: snapshot.data![index].productName!,
                                                                        initialPrice: snapshot.data![index].initialPrice!,
                                                                        threshold: snapshot.data![index].threshold!,
                                                                        productPrice: newPrice,
                                                                        quantity: quantity,
                                                                        image: snapshot.data![index].image.toString())
                                                                ).then((value){
                                                                  newPrice = 0 ;
                                                                  quantity = 0;
                                                                  cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                }).onError((error, stackTrace){
                                                                  print(error.toString());
                                                                });
                                                              },
                                                              child: const Icon(Icons.add , color: Colors.white,)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }

                }
              return const Text('') ;
            }),
            Consumer<cartprovider>(builder: (context, value, child){
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00" ? false : true,
                child: Column(
                  children: [
                    ReusableWidget(title: 'Sub Total', value: value.getTotalPrice().toString()+r' Rs/-',),
                    const ReusableWidget(title: 'Discout 5%', value: '20'+r' Rs/-',),
                    ReusableWidget(title: 'Total', value: value.getTotalPrice().toString()+r' Rs/-',),
                    SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async {
                   List<items> item = [];
                List<Cart> c= await dbHelper!.getCartList();
                  for(int i=0;i<c.length; i++)
                  {
                    items ca =items(int.parse(c[i].productId.toString()), int.parse(c[i].quantity.toString()),c[i].productPrice);
                    item.add(ca);
                    print(item[i].productid);
                    print("21323");
                  }
                 userorders uo = userorders(value.getTotalPrice().toInt(),seller_id, usermodel!.id,item) ;
                 showLoader(context) ;
                 print("1111");
               int statuscode=  await D_O_A.sendorder(uo);
                 hideLoader(context);
                statuscode==200 ? showSnackBar(context, "Order Successfully", Colors.green):statuscode==201?showSnackBar(context, "Clear Your Previous Credit", Colors.blueGrey):
                showSnackBar(context, "Order Not Successfully", Colors.red);
                 cart.setcartdataclear(); 
                 dbHelper!.deleteall();
              }, child: const Text("Pay to Proceed")),
            )
                  ],
                ),
              );
            }),
            
          ],
        ),
      ) ,
    );
    
  }
}



class ReusableWidget extends StatelessWidget {
  final String title , value ;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString() , style: Theme.of(context).textTheme.subtitle2,)
        ],
      ),
    );
  }
}

