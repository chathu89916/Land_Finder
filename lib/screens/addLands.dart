import 'package:flutter/material.dart';
import 'package:Land_Finder/screens/lands.dart';
import 'package:Land_Finder/style/appBarStyle.dart';

class AddLands extends StatefulWidget {
  @override
  _AddLandsState createState() => _AddLandsState();
}

class _AddLandsState extends State<AddLands> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Name of the Property',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please add a Name';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      print('Saved');
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
