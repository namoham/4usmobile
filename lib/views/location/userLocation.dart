import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile4us_new_version/models/user.dart';

class UserLocation extends StatefulWidget {

  final VoidCallback signOut;

  final int userLoginId;

  bool status4;

  final String appBarTitle;

  final User user;

  UserLocation(this.signOut, this.appBarTitle, this.user, this.userLoginId, this.status4);

  @override
  _UserLocation createState() =>
      _UserLocation(this.signOut, this.user, this.appBarTitle, this.userLoginId, this.status4);
}

class _UserLocation extends State<UserLocation> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  String appBarTitle;
  User user;

  _UserLocation(this.signOut, this.user, this.appBarTitle, this.userLoginId, this.status4);

  GoogleMapController mapController;

  final Map<String, Marker> _markers = {};

  final LatLng _center = const LatLng(32.024523, -7.061688);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {

    List address = user.mapsAddress.split(',');
    var long = double.parse(address[0]);
    var lat = double.parse(address[1]);
    LatLng point = LatLng(long, lat);

    final marker = Marker(
      markerId: MarkerId("curr_loc"),
      position: LatLng(long, lat),
      infoWindow: InfoWindow(title: user.Name),
    );

    _markers["user location"] = marker;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Location'),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: point,
          zoom: 18.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
