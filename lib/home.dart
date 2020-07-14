import 'package:flutter/material.dart';
import 'package:Land_Finder/screens/lands.dart';
import 'package:Land_Finder/screens/addLands.dart';
import 'package:Land_Finder/screens/map.dart';
import 'package:Land_Finder/screens/mapAll.dart';
import 'package:Land_Finder/screens/addHouses.dart';

class Home extends StatelessWidget {
  Home();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Land Finder",
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => new Lands(),
        '/addLands': (context) => new AddLands(),
        '/addHouses': (context) => new AddHouses(),
        '/map': (context) => new MapShow(),
        '/mapAll': (context) => new MapAll(),
      },
    );
  }
}
