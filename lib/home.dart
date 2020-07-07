import 'package:flutter/material.dart';
import 'package:Land_Finder/screens/lands.dart';
import 'package:Land_Finder/screens/addLands.dart';

class Home extends StatelessWidget {
  Home(){
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Land Finder",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Lands(),
        '/addLands':(context)=> AddLands(),
      },
    );
  }
}
