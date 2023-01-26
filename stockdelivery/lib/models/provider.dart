import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
class addtocart extends ChangeNotifier
{
  int add_tocart_counter=0;
  int get _add_tocart_counter=>add_tocart_counter;
  addtocart()
  {
    add_tocart_counter++;
    notifyListeners();
  }

}