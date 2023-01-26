import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stockdelivery/screen/Distributor/Distributor_dashboard.dart';

class showRating extends StatelessWidget {
  final double rating;
  const showRating({Key? key,required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
            itemSize: 20,
            unratedColor: Color.fromARGB(121, 172, 172, 172),
            rating: rating,
            itemBuilder: (context,_)=>
            Icon(Icons.star,color: Color.fromARGB(255, 255, 230, 4),)
          );
  }
}