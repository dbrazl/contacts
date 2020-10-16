import 'dart:convert';
import 'package:contacts/android/models/ContactModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../Home/Home.dart';
import './components/Input.dart';
import './components/NameInput.dart';
import '../../components/Address.dart';

import './components/Photo.dart';

class CreateOrEditContact extends StatefulWidget {
  String name;
  String phone;
  String email;
  String image;
  String street = "Rua";
  String neighborhood = "Bairro";
  double latitude;
  double longitude;
  final picker = ImagePicker();
  Function onSaveContact;

  CreateOrEditContact(
      {this.name,
      this.phone,
      this.email,
      this.image,
      this.street,
      this.neighborhood,
      this.latitude,
      this.longitude,
      this.onSaveContact});

  @override
  _CreateOrEditContactState createState() => _CreateOrEditContactState();
}

class _CreateOrEditContactState extends State<CreateOrEditContact> {
  void openGallery() async {
    final image = await widget.picker.getImage(source: ImageSource.gallery);
    String path = image.path;

    setState(() {
      widget.image = path;
    });
  }

  void pickLocation() async {
    const apiKey = "AIzaSyC8pkAGUaPBMY1rrTKIfOtnCHGq1qsIGIw";

    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    LocationResult result = await showLocationPicker(
      context,
      apiKey,
      initialCenter: LatLng(position.latitude, position.longitude),
      requiredGPS: true,
      myLocationButtonEnabled: true,
      desiredAccuracy: LocationAccuracy.best,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
        result.latLng.latitude, result.latLng.longitude);

    setState(() {
      widget.street = placemarks[0].street;
      widget.neighborhood = placemarks[0].subLocality;
      widget.latitude = result.latLng.latitude;
      widget.longitude = result.latLng.longitude;
    });
  }

  void setName(value) {
    setState(() {
      widget.name = value;
    });
  }

  void setPhone(value) {
    setState(() {
      widget.phone = value;
    });
  }

  void setEmail(value) {
    setState(() {
      widget.email = value;
    });
  }

  void saveContact() async {
    if (widget.name != null) {
      ContactModel contact = ContactModel(
        name: widget.name,
        phone: widget.phone != null ? widget.phone : "",
        mail: widget.email != null ? widget.email : "",
        photo: widget.image != null ? widget.image : "",
        address: widget.street != null ? widget.street : "",
        neighborhood: widget.neighborhood != null ? widget.neighborhood : "",
        latitude: widget.latitude != null ? widget.latitude : 0,
        longitude: widget.longitude != null ? widget.longitude : 0,
      );

      this.widget.onSaveContact(contact);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(width: double.infinity, height: 50),
            Photo(
              photo: widget.image,
              onPress: openGallery,
            ),
            SizedBox(height: 20),
            NameInput(
              label: "Nome",
              onChange: setName,
              value: this.widget.name,
            ),
            SizedBox(height: 20),
            Input(
              label: "Telefone",
              onChange: setPhone,
              value: this.widget.phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Input(
              label: "E-mail",
              onChange: setEmail,
              value: this.widget.email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Address(
              address: widget.street,
              neighborhood: widget.neighborhood,
              onPress: pickLocation,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Feather.save, color: Theme.of(context).accentColor),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: saveContact,
      ),
    );
  }
}
