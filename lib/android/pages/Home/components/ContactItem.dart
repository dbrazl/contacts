import 'dart:io';
import 'dart:math';
import 'package:contacts/android/models/ContactModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ContactItem extends StatelessWidget {
  ContactModel contact;
  Function onPress;
  Function onDismissed;
  Function confirmDismiss;

  ContactItem(
      {@required this.contact,
      @required this.onPress,
      this.onDismissed,
      this.confirmDismiss});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contact.name),
      child: FlatButton(
        onPressed: this.onPress,
        padding: EdgeInsets.zero,
        child: ListTile(
          title: Text(
            contact.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            contact.phone.length > 0 ? contact.phone : "Sem número",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          leading: ClipRRect(
            child: Hero(
              child: contact.photo != null && contact.photo != ""
                  ? Image.file(
                      File(contact.photo),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      "assets/icons/photo.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
              tag: contact.photo != null
                  ? contact.photo
                  : "${Random().nextInt(100)}",
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          trailing: Icon(
            Feather.more_horizontal,
            size: 25,
            color: Colors.black54,
          ),
        ),
      ),
      onDismissed: (direction) {
        this.onDismissed(contact.name);
      },
      confirmDismiss: this.confirmDismiss,
      background: Container(
        child: SizedBox(),
        color: Colors.white,
      ),
      secondaryBackground: Container(
        child: SizedBox(),
        color: Color(0xffff5555),
      ),
    );
  }
}
