import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rajuk_flutter/activities/CheckListActivity.dart';
import 'package:rajuk_flutter/utilities/StaticAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubPhaseActivity extends StatefulWidget {
  @override
  _SubPhaseActivityState createState() => _SubPhaseActivityState();
}

class _SubPhaseActivityState extends State<SubPhaseActivity> {
  List subPhaseList;
  List checkboxTitleListPhaseOne;
  SharedPreferences sharedPreferences;
  String sharedPhaseTitle;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: Text('Phase title: $sharedPhaseTitle'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(left: 80, right: 80, bottom: 10, top: 10),
          itemCount: subPhaseList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/phase.png'),
                      SizedBox(width: 20),
                      Text(subPhaseList[index]['SubPhase title'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => CheckListActivity());
                    Navigator.push(context, route);
                    setState(() {
                      sharedPreferences.setString(StaticAccess.TAG_SHARED_SUBPHASE_TITLE, subPhaseList[index]['SubPhase title']);
                    });
                  },
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
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPhaseTitle =
        sharedPreferences.getString(StaticAccess.TAG_SHARED_PHASE_TITLE) ?? '';

    var jsonText;
    if (sharedPhaseTitle == StaticAccess.TAG_PHASE_2) {
      jsonText = await rootBundle
          .loadString('assets/jsons/subPhaseDataSecondPhase.json');
      setState(() {
        subPhaseList = json.decode(jsonText);
      });
    } else if (sharedPhaseTitle == StaticAccess.TAG_PHASE_3) {
      jsonText = await rootBundle
          .loadString('assets/jsons/subPhaseDataThirdPhase.json');
      setState(() {
        subPhaseList = json.decode(jsonText);
      });
    } else if (sharedPhaseTitle == StaticAccess.TAG_PHASE_4) {
      jsonText = await rootBundle
          .loadString('assets/jsons/subPhaseDataFourthPhase.json');
      setState(() {
        subPhaseList = json.decode(jsonText);
      });
    }
  }
}
