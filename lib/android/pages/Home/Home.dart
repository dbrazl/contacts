import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import './components/ContactItem.dart';
import '../Contact/Contact.dart';
import '../CreateOrEditContact/CreateOrEditContact.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ContactModel.dart';

class Home extends StatefulWidget {
  List<ContactModel> contacts = [];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);

      List<ContactModel> contacts =
          decoded.map((contact) => ContactModel.fromJson(contact)).toList();

      int order(a, b) => a.name.compareTo(b.name);

      contacts.sort(order);

      setState(() {
        widget.contacts = contacts;
      });
    }
  }

  _HomeState() {
    load();
  }

  void toContact(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Contact(contact: widget.contacts[index], load: load),
      ),
    );
  }

  void save(List<ContactModel> contacts) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(contacts));
  }

  void saveContact(contact) async {
    List<ContactModel> contacts = widget.contacts;

    contacts.add(contact);

    save(contacts);

    setState(() {
      widget.contacts = contacts;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );

    load();
  }

  void goToCreateOrEditContact() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOrEditContact(
          onSaveContact: saveContact,
          neighborhood: "Bairro",
          street: "Rua",
        ),
      ),
    );
  }

  Future<bool> confirmDismiss(direction) {
    if (direction == DismissDirection.endToStart)
      return Future<bool>.value(true);

    return Future<bool>.value(false);
  }

  void onDimissed(String name) {
    setState(() {
      widget.contacts.removeWhere((element) => element.name == name);
      save(widget.contacts);
      load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Contatos",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: this.widget.contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ContactItem(
                      contact: widget.contacts[index],
                      onPress: () => toContact(index),
                      confirmDismiss: confirmDismiss,
                      onDismissed: onDimissed,
                    );
                  },
                ),
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
          Feather.plus,
          size: 25,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
