import 'dart:io';
import 'dart:convert';
import 'package:contacts/android/models/ContactModel.dart';
import 'package:contacts/android/pages/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CreateOrEditContact/CreateOrEditContact.dart';

import './components/Photo.dart';
import './components/MenuIcon.dart';
import '../../components/Address.dart';
import '../Location/Location.dart';

class Contact extends StatefulWidget {
  ContactModel contact;
  Function load;
  String photo;

  Contact({this.contact, this.load});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    void openMail() async {
      final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '${widget.contact.mail}',
      );

      var uri = _emailLaunchUri.toString();

      if (await canLaunch(uri)) {
        launch(uri);
      }
    }

    void openPhone() async {
      String phone =
          '+55' + widget.contact.phone.replaceAll(RegExp(r"[\D]"), "");

      final Uri _phoneLaunchUri = Uri(
        scheme: 'tel',
        path: '$phone',
      );

      var uri = _phoneLaunchUri.toString();

      if (await canLaunch(uri)) {
        launch(uri);
      }
    }

    void save(List<ContactModel> contacts) async {
      var prefs = await SharedPreferences.getInstance();
      await prefs.setString('data', jsonEncode(contacts));
    }

    Future<List<ContactModel>> getContacts() async {
      var prefs = await SharedPreferences.getInstance();
      var data = prefs.getString('data');

      if (data != null) {
        Iterable decoded = jsonDecode(data);

        return decoded
            .map((contact) => ContactModel.fromJson(contact))
            .toList();
      }
    }

    void openGallery() async {
      final image = await picker.getImage(source: ImageSource.gallery);

      List<ContactModel> contacts = await getContacts();

      contacts.removeWhere((element) => element.name == widget.contact.name);

      ContactModel updated = ContactModel(
        name: widget.contact.name,
        mail: widget.contact.mail,
        phone: widget.contact.phone,
        photo: image.path,
        address: widget.contact.address,
        neighborhood: widget.contact.neighborhood,
        latitude: widget.contact.latitude,
        longitude: widget.contact.longitude,
      );

      contacts.add(updated);

      save(contacts);

      setState(() {
        widget.photo = image.path;
      });

      widget.load();
    }

    void goToAddress() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Location(
            address: widget.contact.address,
            neighborhood: widget.contact.neighborhood,
            latitude: widget.contact.latitude,
            longitude: widget.contact.longitude,
          ),
        ),
      );
    }

    void onEditContact(contact) async {
      List<ContactModel> contacts = await getContacts();

      contacts.removeWhere((element) => element.name == widget.contact.name);

      contacts.add(contact);

      save(contacts);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );

      widget.load();
    }

    void goToCreateOrEditContact() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateOrEditContact(
            name: widget.contact.name,
            email: widget.contact.mail,
            phone: widget.contact.phone,
            street: widget.contact.address,
            neighborhood: widget.contact.neighborhood,
            image: widget.photo != null ? widget.photo : widget.contact.photo,
            latitude: widget.contact.latitude,
            longitude: widget.contact.latitude,
            onSaveContact: onEditContact,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Photo(
                  photo: widget.photo != null
                      ? widget.photo
                      : widget.contact.photo),
              SizedBox(height: 30),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.contact.phone,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.contact.mail,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuIcon(icon: Feather.smartphone, onPress: openPhone),
                  MenuIcon(icon: Feather.mail, onPress: openMail),
                  MenuIcon(icon: Feather.image, onPress: openGallery),
                ],
              ),
              SizedBox(height: 50),
              Address(
                address: widget.contact.address,
                neighborhood: widget.contact.neighborhood,
                onPress: goToAddress,
                showIcon: true,
              ),
            ],
          ),
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToCreateOrEditContact,
        child: Icon(
          Feather.edit_2,
          color: Colors.white,
          size: 25,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
