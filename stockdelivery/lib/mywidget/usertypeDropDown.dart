import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockdelivery/screen/Vendor/add_Update_products/adddailyStock.dart';

class dropdown extends StatefulWidget {
  TextEditingController usertype;
  String text;
  List<String> data;
  dropdown(
      {Key? key,
      required this.usertype,
      required this.data,
      required this.text})
      : super(key: key);

  @override
  State<dropdown> createState() => _dropdownState(usertype, data, text);
}

class _dropdownState extends State<dropdown> {
  List<String> Data;
  String labelText;
  TextEditingController _usertype;
  
  _dropdownState(this._usertype, this.Data, this.labelText);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: Data.map((String category) {
        validator:
        (value) {
          if (value == null || value.isEmpty) {
            return "Field Cannot be empty";
          }
          return null;
        };
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(category),
              ],
            ));
      }).toList(),
      onChanged: (newvalue) {
        setState(() => _usertype.text = newvalue.toString());
      },
      decoration: InputDecoration(
          label: Text(labelText.toString()),
          prefixIcon: Icon(Icons.select_all),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0), gapPadding: 10.0),
          focusColor: Colors.white),
      focusColor: Colors.white,
    );
  }
}
