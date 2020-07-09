import 'package:flutter/material.dart';
import 'package:Land_Finder/screens/lands.dart';
import 'package:Land_Finder/style/appBarStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapShow extends StatefulWidget {
  @override
  _MapShowState createState() => _MapShowState();
}

class _MapShowState extends State<MapShow> {
  bool mapToggle = false;
  var currentLocation;

  GoogleMapController _mapController;

  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose the Location',
          style: AppBarStyle.txtStyle,
        ),
        backgroundColor: AppBarStyle.appBarColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: mapToggle
            ? GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 12.0,
                ),
              )
            : Center(
                child: Text('Loading...'),
              ),
      ),
    );
  }

  void _onMapCreated(controller) {
    setState(() {
      _mapController = controller;
    });
  }
}
