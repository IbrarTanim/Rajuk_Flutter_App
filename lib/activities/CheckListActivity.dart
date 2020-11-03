import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rajuk_flutter/activities/TabBaseActivity.dart';
import 'package:rajuk_flutter/color/CustomColors.dart';
import 'package:rajuk_flutter/model/model.dart';
import 'package:rajuk_flutter/utilities/StaticAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckListActivity extends StatefulWidget {
  @override
  _CheckListActivityState createState() => _CheckListActivityState();
}

class _CheckListActivityState extends State<CheckListActivity> {
  List checkboxTitleList;
  SharedPreferences sharedPreferences;
  String sharedSubPhaseTitle;
  String sharedPhaseTitle;
  String appbarTitle;

  bool YesValue = false;
  bool NoValue = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
        appBar: AppBar(
            title: Text('Selected title: $appbarTitle'),
            ),
        body: ListView.builder(
          itemCount: checkboxTitleList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(right: 5, left: 5),
              child: Card(
                child: ListTile(
                  /*leading: CircleAvatar(maxRadius: 15, child: Text(checkboxTitleList[index]['id'], style: TextStyle(fontSize: 15),),),*/
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          checkboxTitleList[index]['Checkbox Title'],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        flex: 6,
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'YES',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Checkbox(
                              value: YesValue,
                              onChanged: (value) {
                                Route route = MaterialPageRoute(
                                    builder: (context) => TabBaseActivity());

                                Navigator.push(context, route);
                                setState(() {
                                  YesValue = value;
                                  sharedPreferences.setString(StaticAccess.TAG_SHARED_CHECKBOX_TITLE, checkboxTitleList[index]['Checkbox Title']);
                                  sharedPreferences.setString(StaticAccess.TAG_STATUS, StaticAccess.TAG_YES);
                                });
                              },
                            ),
                            Text(
                              'NO',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Checkbox(
                              value: NoValue,
                              onChanged: (value) async {
                                Route route = MaterialPageRoute(
                                    builder: (context) => TabBaseActivity());

                                Navigator.push(context, route);

                                setState(() {
                                  NoValue = value;
                                  sharedPreferences.setString(StaticAccess.TAG_SHARED_CHECKBOX_TITLE, checkboxTitleList[index]['Checkbox Title']);
                                  sharedPreferences.setString(StaticAccess.TAG_STATUS, StaticAccess.TAG_NO);
                                });
                              },
                            ),
                          ],
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: RaisedButton(
                            elevation: 5,
                            focusElevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.all(0),
                            color: RajukColor,
                            textColor: Colors.white,
                            child: Text("SAVE".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                            onPressed: () {},
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),

                  /*onTap: () {
                      Route route = MaterialPageRoute(builder: (context) => PhaseActivity(phaseList[index]));
                      sharedPreferences.setStringList(StaticAccess.TAG_SHARED_CHECKBOX_TITLE, checkboxTitleList);

                      Navigator.push(context, route);
                    },*/
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
    sharedSubPhaseTitle = sharedPreferences.getString(StaticAccess.TAG_SHARED_SUBPHASE_TITLE) ?? '';
    sharedPhaseTitle = sharedPreferences.getString(StaticAccess.TAG_SHARED_PHASE_TITLE) ?? '';

    final fRCMCheckBoxData = await FRCMCheckBoxData().getById(1);
    

    var jsonText;

    if (sharedPhaseTitle == StaticAccess.TAG_PHASE_1) {
      appbarTitle = sharedPhaseTitle;
      jsonText = await rootBundle.loadString('assets/jsons/phaseOne.json');
      setState(() {
        checkboxTitleList = json.decode(jsonText);
      });
    } else {
      appbarTitle = sharedSubPhaseTitle;
      if (sharedSubPhaseTitle == StaticAccess.TAG_SHALLOW_SPREAD) {
        jsonText = await rootBundle
            .loadString('assets/jsons/shallowSpreadContinuousFootings.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle == StaticAccess.TAG_MAT_FOUNDATION) {
        jsonText =
            await rootBundle.loadString('assets/jsons/matFoundation.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle == StaticAccess.TAG_PILE_FOUNDATION) {
        jsonText =
            await rootBundle.loadString('assets/jsons/pileFoundation.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle == StaticAccess.TAG_BASEMENT_WALLS) {
        jsonText =
            await rootBundle.loadString('assets/jsons/basementWalls.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle ==
          StaticAccess.TAG_GENERAL_BUILDING_SITE_CONFIGURATION) {
        jsonText = await rootBundle
            .loadString('assets/jsons/generalBuildingSiteConfiguration.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle ==
          StaticAccess.TAG_BUILDING_WITHOUT_BASEMENT_WALLS) {
        jsonText = await rootBundle
            .loadString('assets/jsons/buildingWithoutBasementWalls.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle ==
          StaticAccess.TAG_BUILDING_WITH_BASEMENT_WALLS) {
        jsonText = await rootBundle
            .loadString('assets/jsons/buildingWithBasementWalls.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle ==
          StaticAccess.TAG_GENERAL_BUILDING_CONFIGURATION) {
        jsonText = await rootBundle
            .loadString('assets/jsons/generalBuildingConfiguration.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle ==
          StaticAccess.TAG_CONCRETE_SLABS_BEAMS_COLUMNS) {
        jsonText = await rootBundle
            .loadString('assets/jsons/concretSlabsBeamsColumns.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      } else if (sharedSubPhaseTitle == StaticAccess.TAG_CONCRETE_SHEAR_WALLS) {
        jsonText =
            await rootBundle.loadString('assets/jsons/concreteShearWalls.json');
        setState(() {
          checkboxTitleList = json.decode(jsonText);
        });
      }
    }
  }
}
