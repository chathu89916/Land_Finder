import 'package:flutter/material.dart';
import 'package:Land_Finder/style/appBarStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Land_Finder/style/floatingButtonStyle.dart';

class Lands extends StatefulWidget {
  @override
  _LandsState createState() => _LandsState();
}

// final TextStyle txtThemeHeading =
//     TextStyle(color: Color(0xff212121), fontSize: 20.0);
// final TextStyle txtThemeSub =
//     TextStyle(color: Color(0xff757575), fontSize: 15.0);

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
        // style: TextStyle(
        //   color: Color(0xffFFFFFF),
        //   fontSize: 20.0,
        // ),
      ),
    ),
    Tab(
      child: Text(
        'Houses',
        // style: TextStyle(
        //   color: Color(0xffFFFFFF),
        //   fontSize: 20.0,
        // ),
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
      color: Color(0xffCFD8DC),
      margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
      child: ListTile(
        title: Text(
          snapshot.data[index].data["name"],
          style: TextStyle(color: Color(0xff212121), fontSize: 20.0),
        ),
        subtitle: Text(
          'Price: ${snapshot.data[index].data["value"]}',
          style: TextStyle(color: Color(0xff757575), fontSize: 15.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.pushNamed(context, '/mapAll');
            },
          ),
        ],
        backgroundColor: AppBarStyle.appBarColor,
        title: Text(
          'Your Home',
          style: AppBarStyle.txtStyle,
        ),
        bottom: TabBar(
          indicatorWeight: 3.5,
          indicatorColor: ButtonStyle.actionButtonColor,
          unselectedLabelColor: Color(0xffBDBDBD),
          labelStyle: TextStyle(
            color: Color(0xffFFFFFF),
            fontSize: 20.0,
            //fontWeight: FontWeight.bold,
          ),
          controller: _tabController,
          //indicatorColor: Colors.blueGrey[100],
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
                  : Navigator.pushNamed(context, '/addHouses');
            },
            child: Icon(
              Icons.add,
              color: ButtonStyle.lableColor,
            ),
            backgroundColor: ButtonStyle.actionButtonColor,
          ),
        ],
      ),
    );
  }
}
