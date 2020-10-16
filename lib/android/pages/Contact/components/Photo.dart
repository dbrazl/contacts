import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  String photo;

  Photo({this.photo});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: this.photo != null ? this.photo : "${Random().nextInt(100)}",
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(1, 2),
              blurRadius: 5,
              spreadRadius: 3,
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(60),
          image: this.photo != null && this.photo != ""
              ? DecorationImage(
                  image: FileImage(File(photo)),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: AssetImage("assets/icons/photo.png"),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
