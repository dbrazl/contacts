import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  IconData icon;
  Function onPress;

  MenuIcon({this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: onPress,
        child: Icon(
          this.icon,
          size: 25,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(1, 2),
          ),
        ],
      ),
    );
  }
}
