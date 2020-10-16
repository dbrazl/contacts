import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/Address.dart';

class Location extends StatefulWidget {
  String address;
  String neighborhood;
  double latitude = 0;
  double longitude = 0;
  Set<Marker> markers = {};

  Location({this.address, this.neighborhood, this.latitude, this.longitude});

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons/pin_map.png');
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 16.0,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                child: Address(
                  address: this.widget.address,
                  neighborhood: this.widget.neighborhood,
                  onPress: () {},
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            Flexible(
              flex: 8,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: widget.markers,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);

                  setState(() {
                    widget.markers.add(
                      Marker(
                        markerId: MarkerId("actual"),
                        position: LatLng(widget.latitude, widget.longitude),
                        icon: pinLocationIcon,
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
