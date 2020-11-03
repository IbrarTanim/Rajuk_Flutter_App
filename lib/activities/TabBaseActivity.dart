import 'dart:collection';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rajuk_flutter/color/CustomColors.dart';
import 'package:rajuk_flutter/manager/DatabaseManager.dart';
import 'package:rajuk_flutter/model/model.dart';
import 'package:rajuk_flutter/utilities/StaticAccess.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:sqfentity/sqfentity.dart';

class TabBaseActivity extends StatefulWidget {
  @override
  _TabBaseActivityState createState() => _TabBaseActivityState();
}

class _TabBaseActivityState extends State<TabBaseActivity>
    with TickerProviderStateMixin {
  var commentControler = TextEditingController();
  TabController _controller;

  File ecpectedImage;
  File expectedVideo;
  VideoPlayerController videoPlayerController;

  SharedPreferences sharedPreferences;

  String userName;
  String password;
  String selectedProject;
  String selectedPhase;
  String selectedSubPhase;
  String selectedCheckBoxTitle;
  String selectedCheckBoxStatus;
  bool isInitialized;

  DatabaseManager databaseManager;
  FRCMCheckBoxData frcmCheckBoxData;

  final db = FirebaseFirestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String writingComments;

  Future getGalleryImage() async {
    final galleryPic = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      ecpectedImage = galleryPic;
    });
  }

  Future getCapturedImage() async {
    final capturedPic = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    setState(() {
      ecpectedImage = capturedPic;
    });
  }

  Future getGalleryVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    expectedVideo = video;
    videoPlayerController = VideoPlayerController.file(expectedVideo)
      ..initialize().then((_) {
        setState(() {});
        videoPlayerController.play();
      });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 4);
    commentControler = TextEditingController();
    initializeValue();
  }

  initializeValue() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userName = sharedPreferences.getString(StaticAccess.TAG_USER_NAME) ?? '';
    password = sharedPreferences.getString(StaticAccess.TAG_PASSWORD) ?? '';
    selectedProject = sharedPreferences.getString(StaticAccess.TAG_SHARED_PROJECT_TITLE) ?? '';
    selectedPhase = sharedPreferences.getString(StaticAccess.TAG_SHARED_PHASE_TITLE) ?? '';
    selectedSubPhase = sharedPreferences.getString(StaticAccess.TAG_SHARED_SUBPHASE_TITLE) ?? '';
    selectedCheckBoxTitle = sharedPreferences.getString(StaticAccess.TAG_SHARED_CHECKBOX_TITLE) ?? '';
    selectedCheckBoxStatus = sharedPreferences.getString(StaticAccess.TAG_STATUS) ?? '';

    isInitialized = await EcpsFrcmMmodel().initializeDB();
    if(isInitialized == true){
      print('Dina');
    }else{
      print('Mina');
    }

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBaseActivity'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(12),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: Colors.white,
              textColor: RajukColor,
              child: Text("Prepared to Upload".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                  )),

              onPressed: () async {
                //product.name = '';
                /*CollectionReference dbData =    db.collection('FRCM');
                dbData.add({'userName': userName});
                dbData.add({'password': password});
                dbData.add({'selectedProject': selectedProject});
                dbData.add({'selectedPhase': selectedPhase});
                dbData.add({'selectedSubPhase': selectedSubPhase});
                dbData.add({'selectedCheckBoxTitle': selectedCheckBoxTitle});
                dbData.add({'selectedCheckBoxStatus': selectedCheckBoxStatus});
                dbData.add({'comment': writingComments});
                Map<String, Object> data =  HashMap<>();
                dbData.doc('checkList').set(data);*/


                /*frcmCheckBoxData = FRCMCheckBoxData();
                frcmCheckBoxData.userName = userName;
                frcmCheckBoxData.userPassword = password;
                frcmCheckBoxData.selectedProject = selectedProject;
                frcmCheckBoxData.selectedPhase = selectedPhase;
                frcmCheckBoxData.selectedSubPhase = selectedSubPhase;
                frcmCheckBoxData.selectedCheckBoxTitle = selectedCheckBoxTitle;
                frcmCheckBoxData.selectedCheckBoxStatus = selectedCheckBoxStatus;
                frcmCheckBoxData.selectedCheckBoxComments = writingComments;
                frcmCheckBoxData.save();
                databaseManager.insertFRCMChecklist(frcmCheckBoxData);
                */



                //final frcmCheckBoxData = await FRCMCheckBoxData().select().toSingle();

                if (isInitialized == true) {
                  await FRCMCheckBoxData(
                      userName: userName,
                    userPassword: password,
                    selectedProject: selectedProject,
                    selectedPhase: selectedPhase,
                    selectedSubPhase: selectedSubPhase,
                    selectedCheckBoxTitle: selectedCheckBoxTitle,
                    selectedCheckBoxStatus: selectedCheckBoxStatus,
                    selectedCheckBoxComments: writingComments

                  ).save();
                  print('FRCMCheckBoxData inserted successfully');
                } else {
                  print(
                      'There is already FRCMCheckBoxData in the database.. addFRCMCheckBoxData will not run');
                }




                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              key: formkey,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Write a comment',
                filled: true,
                fillColor: Colors.white,
              ),
              controller: commentControler,
              validator: (value) {
                if (value.length == 0) return "Comment field can't be empty";
                //rokan
              },
              onChanged: (value) {
                writingComments = value;
              },
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              decoration: new BoxDecoration(color: RajukTabColor),
              child: TabBar(
                controller: _controller,
                indicatorColor: Colors.pinkAccent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.red,
                tabs: <Widget>[
                  Tab(
                    text: 'Image',
                  ),
                  Tab(
                    text: 'Video',
                  ),
                  Tab(
                    text: 'Audio',
                  ),
                  Tab(
                    text: 'Measurement',
                  )
                ],
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: FlatButton(
                                        child: Image.asset(
                                            'assets/images/camera.png'),
                                        color: Colors.transparent,
                                        onPressed: () {
                                          getCapturedImage();
                                        },
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: FlatButton(
                                        child: Image.asset(
                                            'assets/images/folder.png'),
                                        color: Colors.transparent,
                                        onPressed: () {
                                          getGalleryImage();
                                        },
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                                flex: 3,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: ecpectedImage == null
                                            ? ExactAssetImage(
                                                'assets/images/avater_pic.jpg')
                                            : FileImage(ecpectedImage),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                flex: 7,
                              )
                            ],
                          ),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        flex: 6,
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: FlatButton(
                                        color: Colors.transparent,
                                        child: Image.asset(
                                          'assets/images/ic_video_player.png',
                                        ),
                                        onPressed: () {
                                          getGalleryVideo();
                                        },
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                                flex: 3,
                              ),
                              /*Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5),



                                  ),


                                ),
                                flex: 7,
                              ),*/

                              if (expectedVideo != null)
                                videoPlayerController.value.initialized
                                    ? AspectRatio(
                                        aspectRatio: videoPlayerController
                                            .value.aspectRatio,
                                        child:
                                            VideoPlayer(videoPlayerController),
                                      )
                                    : Container()
                            ],
                          ),
                        ),
                        flex: 4,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        flex: 6,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          'assets/images/ic_audio_player.png',
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(50, 0, 50, 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        flex: 8,
                      )
                    ],
                  ),
                  Text('Body design for Measurement Tab'),
                ],
              ),
            ),
            flex: 7,
          )
        ],
      ),
    );
  }
}
