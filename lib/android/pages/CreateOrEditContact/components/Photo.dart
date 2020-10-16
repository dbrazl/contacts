import 'dart:io';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  String photo;
  Function onPress;

  Photo({this.photo, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: onPress,
        child: ClipRRect(
          child: this.photo != null && this.photo != ""
              ? Image.file(
                  File(this.photo),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/icons/photo.png",
                  width: 120,
                  height: 120,
                ),
          borderRadius: BorderRadius.circular(60),
        ),
      ),
    );
  }
}
