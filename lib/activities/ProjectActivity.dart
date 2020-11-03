import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rajuk_flutter/activities/PhaseActivity.dart';
import 'package:rajuk_flutter/utilities/StaticAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectActivity extends StatefulWidget {
  @override
  _ProjectActivityState createState() => _ProjectActivityState();
}

class _ProjectActivityState extends State<ProjectActivity> {
  List data;
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text('ProjectActivity'),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    maxRadius: 15,
                    child: Text(
                      data[index]['id'],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(
                        data[index]['Construction Project'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Text(
                        data[index]['C.S/R.S Plot No'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 20),
                      Text(
                        data[index]['Applicant'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  onTap: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => PhaseActivity(data[index]),
                    );
                    Navigator.push(context, route);
                    setState(() {
                      sharedPreferences.setString(
                          StaticAccess.TAG_SHARED_PROJECT_TITLE, data[index]['Construction Project']);
                    });
                  },

                  // Text(data[index]['Applicant'])
                )
              ]),
            );
          },
        ));
  }

  @override
  void initState() {
    loadJsonData();
  }

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/jsons/projectData.json');
    setState(() {
      data = json.decode(jsonText);
    });
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
