import 'package:flutter/material.dart';
import 'package:Land_Finder/style/appBarStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lands extends StatefulWidget {
  @override
  _LandsState createState() => _LandsState();
}

final TextStyle txtThemeHeading =
    TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 20.0);
final TextStyle txtThemeSub =
    TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 15.0);

class _LandsState extends State<Lands> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

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

  Future getData() async {
    var firestoreInstance = Firestore.instance;
    QuerySnapshot qn;
    _tabController.index == 0
        ? qn = await firestoreInstance.collection("lands").getDocuments()
        : qn = await firestoreInstance.collection("houses").getDocuments();

    return qn.documents;
  }

  Widget _newCard(BuildContext context, int index, AsyncSnapshot snapshot) {
    return Card(
      color: Colors.blueGrey[200],
      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
      child: ListTile(
        title: Text(
          snapshot.data[index].data["name"],
          style: txtThemeHeading,
        ),
        subtitle: Text(
          'Price: ${snapshot.data[index].data["value"]}',
          style: txtThemeSub,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
        ],
        backgroundColor: AppBarStyle.appBarColor,
        title: Text(
          'Your Home',
          style: AppBarStyle.txtStyle,
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blueGrey[100],
          tabs: mainTabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text('Loading...'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return _newCard(_, index, snapshot);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: getData(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text('Loading...'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return _newCard(_, index, snapshot);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _tabController.index == 0
                  ? Navigator.pushNamed(context, '/addLands')
                  : print('this is tab 2');
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueGrey[300],
          ),
        ],
      ),
    );
  }
}
