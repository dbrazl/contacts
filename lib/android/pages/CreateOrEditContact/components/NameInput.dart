import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  String label;
  String value = "";
  Function onChange;

  NameInput({this.label, this.onChange, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        onChanged: this.onChange,
        textAlign: TextAlign.center,
        initialValue: this.value,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: this.label,
          hintStyle: TextStyle(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
