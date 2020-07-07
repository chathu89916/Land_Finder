import 'package:flutter/material.dart';

class Lands extends StatefulWidget {
  @override
  _LandsState createState() => _LandsState();
}

// List _data;
// class Data {
//   Map fetched_data = {
//     "data": [
//       {"id": 111, "name": "abc"},
//       {"id": 222, "name": "pqr"},
//       {"id": 333, "name": "abc"}
//     ]
//   };

// //function to fetch the data

//   Data() {
//     _data = fetched_data["data"];
//   }

//   int getId(int index) {
//     return _data[index]["id"];
//   }

//   String getName(int index) {
//     return _data[index]["name"];
//   }

//   int getLength() {
//     return _data.length;
//   }
// }

final TextStyle txtThemeHeading =
    TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 20.0);
final TextStyle txtThemeSub =
    TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 15.0);

class _LandsState extends State<Lands> with SingleTickerProviderStateMixin {
  final List<Tab> mainTabs = <Tab>[
    Tab(
      child: Text(
        'Lands',
        style: txtThemeSub,
      ),
    ),
    Tab(
      child: Text(
        'Houses',
        style: txtThemeSub,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[300],
          title: Text(
            'Your Home',
            style: txtThemeHeading,
          ),
          bottom: TabBar(
            indicatorColor: Colors.blueGrey[100],
            tabs: mainTabs,
          ),
        ),
        body: TabBarView(children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: _newCard,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: _newCard,
                ),
              ),
            ],
          ),
        ]),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: Colors.blueGrey[300],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _newCard(BuildContext context, int index) {
  return InkWell(
    child: Card(
      color: Colors.blueGrey[200],
      margin: EdgeInsets.all(2.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("Hello"),
      ),
    ),
  );
}
