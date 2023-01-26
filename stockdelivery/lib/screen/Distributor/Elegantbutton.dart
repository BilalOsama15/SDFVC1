import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';

class elegantnumberbutton extends StatefulWidget {
  int saleprice_per_carton=0;
   elegantnumberbutton({ Key? key,required this.saleprice_per_carton }) : super(key: key);

  @override
  State<elegantnumberbutton> createState() => _elegantnumberbuttonState(saleprice_per_carton);
}
int carttottal=0;

class _elegantnumberbuttonState extends State<elegantnumberbutton> {
    num _count=0;
    int saleprice_per_carton;
    _elegantnumberbuttonState(this.saleprice_per_carton);
  @override
  Widget build(BuildContext context) {
    return Container(width: 100,
                        child: ElegantNumberButton(
                          initialValue: _count,
                          minValue: 0,
                          maxValue: 100,
                          color: Color.fromARGB(20, 23, 23, 23),
                          step: 1,
                          decimalPlaces: 1,
                          onChanged: (value) { // get the latest value from here
                            setState(() {
                            carttottal= int.parse(_count.toString())* saleprice_per_carton;
                              _count = value;
                            });
                          },
                        )
                          ,);
  }
}