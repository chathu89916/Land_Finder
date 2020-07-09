import 'package:flutter/material.dart';
import 'package:Land_Finder/screens/lands.dart';
import 'package:Land_Finder/style/appBarStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapShow extends StatefulWidget {
  @override
  _MapShowState createState() => _MapShowState();
}

class _MapShowState extends State<MapShow> {
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
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(6.9271, 79.8612),
            zoom: 12.0,
          ),
        ),
      ),
    );
  }
}
