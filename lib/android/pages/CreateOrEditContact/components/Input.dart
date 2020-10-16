import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  String label;
  Function onChange;
  String value = "";
  TextInputType keyboardType;

  Input({this.label, this.onChange, this.value, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
        onChanged: this.onChange,
        initialValue: this.value,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: this.label,
          hintStyle: TextStyle(
            fontSize: 18,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
