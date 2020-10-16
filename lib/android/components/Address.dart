import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Address extends StatelessWidget {
  String address = "Rua";
  String neighborhood = "Bairro";
  Function onPress = () {};
  bool showIcon = false;

  Address({this.address, this.neighborhood, this.onPress, this.showIcon});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: ListTile(
        title: Text(
          "Endereço",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.address,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              this.neighborhood,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: this.showIcon == true
            ? FlatButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  Feather.map,
                  size: 25,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: onPress,
              )
            : null,
        isThreeLine: true,
      ),
    );
  }
}
