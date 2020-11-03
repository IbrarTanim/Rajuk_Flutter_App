import 'dart:convert';

import 'package:rajuk_flutter/activities/CheckListActivity.dart';
import 'package:rajuk_flutter/utilities/StaticAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rajuk_flutter/activities/SubPhaseActivity.dart';

class PhaseActivity extends StatefulWidget {
  var projectData;

  PhaseActivity(this.projectData);

  @override
  _PhaseActivityState createState() => _PhaseActivityState(this.projectData);
}

class _PhaseActivityState extends State<PhaseActivity> {
  var projectData;
  List phaseList;
  SharedPreferences sharedPreferences;
  String sharedProjectTitle;

  _PhaseActivityState(this.projectData);

  @override
  Widget build(BuildContext context) {
    sharedProjectTitle = sharedPreferences.getString(StaticAccess.TAG_SHARED_PROJECT_TITLE) ?? '';

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text('Project Title: $sharedProjectTitle'),
        ),
        body: GridView.builder(
          //padding: EdgeInsets.all(80),
          padding: EdgeInsets.only(left: 80, right: 80, bottom: 80),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: phaseList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //margin: EdgeInsets.only(right: 100, left: 100),
              child: Card(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/phase.png',
                      ),
                      SizedBox(width: 20),
                      Text(phaseList[index]['Phase title'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(width: 20),
                      Text(
                        phaseList[index]['Phase name'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),

                  onTap: () {
                    if (phaseList[index]['Phase title'] ==
                        StaticAccess.TAG_PHASE_1) {
                      Route route = MaterialPageRoute(
                          builder: (context) => CheckListActivity());
                      Navigator.push(context, route);
                    } else {
                      Route route = MaterialPageRoute(
                          builder: (context) => SubPhaseActivity());
                      Navigator.push(context, route);
                    }
                    setState(() {
                      sharedPreferences.setString(
                          StaticAccess.TAG_SHARED_PHASE_TITLE,
                          phaseList[index]['Phase title']);
                    });

                    //print(phaseList[index]);
                  },

                  // Text(projectData[index]['Applicant'])
                ),
              ),
            );
          },
        ));
  }

  @override
  void initState() {
    loadJsonData();
  }

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/jsons/phaseData.json');
    setState(() {
      phaseList = json.decode(jsonText);
    });

    sharedPreferences = await SharedPreferences.getInstance();
  }
}
