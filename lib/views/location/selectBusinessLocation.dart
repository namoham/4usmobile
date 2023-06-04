import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/models/user.dart';

class BusinessLocationSelect extends StatefulWidget {

  final VoidCallback signOut;

  final int userLoginId;

  bool status4;

  final String appBarTitle;

  final User user;

  BusinessLocationSelect(this.signOut, this.appBarTitle, this.user, this.userLoginId, this.status4);

  @override
  _BusinessLocationState createState() =>
      _BusinessLocationState(this.signOut, this.user, this.appBarTitle, this.userLoginId, this.status4);
}

class _BusinessLocationState extends State<BusinessLocationSelect> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  String appBarTitle;
  User user;

  _BusinessLocationState(this.signOut, this.user, this.appBarTitle, this.userLoginId, this.status4);

  GoogleMapController mapController;
  Position position;

  String businessLocation;

  final Map<String, Marker> _markers = {};

  final LatLng _center = const LatLng(32.024523, -7.061688);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
        actions: <Widget>[
          IconButton(
            onPressed: () {
              debugPrint('icon clicked');
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {              user.mapsCordsBusinessAddress = businessLocation;
              goToAddBeneficiaryPage(context, signOut,
                  'Add Beneficiary', user, userLoginId, status4);
            },
            icon: Icon(Icons.verified_user),
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 5.0,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        tooltip: 'Get Location',
        child: Icon(Icons.my_location),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 18.0),
      ),
    );
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });

    //location = LatLng(position.latitude, position.longitude).toString();
    businessLocation = position.latitude.toString() +
        '' +
        ',' +
        '' +
        position.longitude.toString();
    print(businessLocation);
  }
}