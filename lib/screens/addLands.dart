import 'package:flutter/material.dart';
import 'package:Land_Finder/screens/lands.dart';
import 'package:Land_Finder/style/appBarStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLands extends StatefulWidget {
  @override
  _AddLandsState createState() => _AddLandsState();
}

class _AddLandsState extends State<AddLands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppBarStyle.appBarColor,
        title: Text(
          'Add a Land',
          style: AppBarStyle.txtStyle,
        ),
      ),
      body: FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  FormWidget({Key key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  var _txtControllerName = TextEditingController();
  var _txtControllerLocation = TextEditingController();
  var _txtControllerValue = TextEditingController();
  final firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _txtControllerName,
              decoration: const InputDecoration(
                hintText: 'Name of the Property',
              ),
              validator: (value1) {
                if (value1.isEmpty) {
                  return 'Please add the property name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _txtControllerValue,
              decoration: const InputDecoration(
                hintText: 'Per Perch Value',
              ),
              validator: (value1) {
                if (value1.isEmpty) {
                  return 'Add the value';
                }
                return null;
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _txtControllerLocation,
                    decoration: const InputDecoration(
                      hintText: 'Location: Lat, Long',
                    ),
                    validator: (value2) {
                      if (value2.isEmpty) {
                        return 'Please add the property location';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_location),
                  padding: EdgeInsets.all(5.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                    setState(() {});
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: AppBarStyle.appBarColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        addData();
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addData() async {
    await firestoreInstance.collection("lands").add({
      'name': _txtControllerName.text,
      'value': _txtControllerValue.text,
      'location': _txtControllerLocation.text,
    });
    Navigator.of(context).pop();
  }
}
