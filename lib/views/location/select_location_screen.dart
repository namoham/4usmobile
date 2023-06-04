import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/models/user.dart';

class MyLocationSelect extends StatefulWidget {

  final VoidCallback signOut;

  final int userLoginId;

  bool status4;

  final String appBarTitle;

  final User user;

  MyLocationSelect(this.signOut, this.appBarTitle, this.user, this.userLoginId, this.status4);

  @override
  _MyLocationState createState() =>
      _MyLocationState(this.signOut, this.user, this.appBarTitle, this.userLoginId, this.status4);
}

class _MyLocationState extends State<MyLocationSelect> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;

  String appBarTitle;
  User user;
  static const kGoogleApiKey = "AIzaSyC9w66ToqDe562rhY2pkmzQ-NPCToeUw-s";

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  _MyLocationState(this.signOut, this.user, this.appBarTitle, this.userLoginId, this.status4);

  GoogleMapController mapController;
  Position position;

  String location;

  final Map<String, Marker> _markers = {};

  final LatLng _center = const LatLng(32.024523, -7.061688);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Maps Sample App'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              debugPrint('icon clicked');
//              final center = await _getLocation();
              Prediction p = await PlacesAutocomplete.show(
                  context: context,
                  strictbounds: _center == null ? false : true,
                  apiKey: kGoogleApiKey,
                  mode: Mode.overlay,
                  language: 'en',
                  location: _center == null
                      ? null
                      : Location(_center.latitude, _center.longitude),
                  radius: _center == null ? null : 1000000
              );
              displayPrediction(p);
              //_settingModalBottomSheet(context);
            },
            icon: Icon(Icons.search),
          ),

          IconButton(
            onPressed: () {
              user.mapsAddress = location;
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
          zoom: 7.0,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        tooltip: 'Get Location',
        child: Icon(Icons.my_location, color: Colors.white,),
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
    location = position.latitude.toString() +
        ',' +
        position.longitude.toString();
    print(location);
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }

  void _settingModalBottomSheet(context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            padding: EdgeInsets.only(top: statusBarHeight),
            color: Colors.transparent,
            child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                              hintText: "Para onde vamos?",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  //searchAndNavigate
                                },
                                iconSize: 30.0,
                              )
                          ),
                          onChanged: (val) {
                            setState(() {
                              //searchAddr = val;
                            }
                            );
                          },
                          onSubmitted: (term) {
                          //  searchAndNavigate();
                          },
                        ),
                      ),
                    ),
                  ],
                )
            ),
          );
        }
    );
  }
}
