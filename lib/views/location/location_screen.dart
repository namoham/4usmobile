import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile4us_new_version/dao/app_helpers/delayPayment_helper.dart';
import 'package:mobile4us_new_version/functions/navigate_functions.dart';
import 'package:mobile4us_new_version/localization/appLocalizations.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:mobile4us_new_version/models/user.dart';

class MyLocation extends StatefulWidget {

  final VoidCallback signOut;
  final int userLoginId;
  final bool status4;
  final Parameters parameter;

  const MyLocation(this.signOut, this.userLoginId, this.status4, this.parameter);


  @override
  _MyLocationState createState() => _MyLocationState(this.signOut,
      this.userLoginId, this.status4, this.parameter);
}

class _MyLocationState extends State<MyLocation> {

  VoidCallback signOut;
  int userLoginId;
  bool status4;
  Parameters parameter;

  GoogleMapController mapController;
  Position position;
  DelayPaymentHelper helper = new DelayPaymentHelper();
  final Map<String, Marker> _markers = {};

  _MyLocationState(this.signOut, this.userLoginId, this.status4, this.parameter);

  @override
  void initState() {
    super.initState();
  }


  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    final beneficiaries = await helper.getDelayPaymentList();

    setState(() {
      _markers.clear();

      for (final n in beneficiaries) {
        if (n.mapsAddress != null) {
          List address = n.mapsAddress.split(',');
          var long = double.parse(address[0]);
          var lat = double.parse(address[1]);
          LatLng point = LatLng(long, lat);
          final marker = Marker(
            markerId: MarkerId(n.Name),
            position: point,
            icon: BitmapDescriptor.defaultMarkerWithHue(markerColor(n.nameClass)),
            infoWindow: InfoWindow(title: n.Name),
          );
          _markers[n.Name] = marker;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    String longLat = parameter.value;
    List address= longLat.split(',');
    var long = double.parse(address[0]);
    var lat = double.parse(address[1]);
    final LatLng _center = LatLng(long, lat);

    return WillPopScope(

        onWillPop: () {
          goToHomePage(context, signOut, userLoginId, status4);
          return Future.value(true);
    },

    child: Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).getTranslated('locationOfClients')),
        backgroundColor: Colors.indigo,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                goToBeneficiariesPage(context, signOut,
                    'Add Beneficiary', User(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', '', '', '', '', '',
                        '','','','','','','','', '', '', '', '', '','','','','','','','','', '', '',
                        '','','','','','','','', '', '', '', '', '','','', '','','','','','', '', '',
                        '','','','','','','','', '', '', '', '', '','','','','','','','','', '', '',
                        '', '', '','','','','', '', '', ''), false, null,
                    userLoginId, status4);
              },
              icon: Icon(Icons.format_list_bulleted),
            ),
          ]),
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
        onPressed: _getCurrentLocation,
        tooltip: 'Get Location',
        child: Icon(Icons.my_location),
      ),
    ));
  }

  void _getCurrentLocation() async {
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
  }


  double markerColor(String className)  {

    print(className);

    double color = BitmapDescriptor.hueRed;

    if(className == 'Classe6') {

      color = BitmapDescriptor.hueRed; // 0.0

    } else if (className == 'Classe5'){

      color = 12.0;

    } else if (className == 'Classe4'){

      color = 24.0;

    } else if (className == 'Classe3'){

      color = BitmapDescriptor.hueOrange; // 30.0

    } else if (className == 'Classe2'){

      color = 48.0;

    } else if (className == 'Classe1'){

      color = BitmapDescriptor.hueYellow; // 60.0
    }

    return color;
  }
}
