//import 'dart:html';
import 'package:Land_Finder/style/appBarStyle.dart';
import 'package:flutter/material.dart';
//import 'package:Land_Finder/screens/lands.dart';
//import 'package:Land_Finder/style/appBarStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapAll extends StatefulWidget {
  @override
  _MapAllState createState() => _MapAllState();
}

class _MapAllState extends State<MapAll> {
  final Firestore _database = Firestore.instance;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool mapToggle = false;
  var currentLocation;
  GoogleMapController _mapController;

  void getMarkers() async {
    await _database.collection('lands').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; i++) {
          initMarker(
            docs.documents[i].data['name'],
            docs.documents[i].data['location'],
            docs.documents[i].documentID,
          );
          //print(docs.documents[i].data);
        }
      }
    });
  }

  void initMarker(n, m, mId) {
    var markerIdVal = mId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(m.latitude, m.longitude),
      infoWindow: InfoWindow(title: n.toString()),
      draggable: false,
    );
    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    getMarkers();
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
        backgroundColor: AppBarStyle.appBarColor,
        title: Text(
          'All Properties',
          style: AppBarStyle.txtStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
                    currentLocation.latitude,
                    currentLocation.longitude,
                  ),
                  zoom: 10.0,
                ),
                markers: Set<Marker>.of(markers.values),
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
