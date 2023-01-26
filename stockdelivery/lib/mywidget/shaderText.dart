import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class shadertext extends StatelessWidget {
  String text;
  Color colors1;
  Color colors2;
  
   shadertext({Key? key, required this.text, required this.colors1, required this.colors2 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
                        shaderCallback: (bounds) => 
                        LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [colors1,colors2],
                          tileMode: TileMode.mirror
                          ).createShader(bounds),
                        child: Text(text,style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold,color: Colors.white)));
  }
}