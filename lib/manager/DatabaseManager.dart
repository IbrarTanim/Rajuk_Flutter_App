import 'package:rajuk_flutter/model/model.dart';

class DatabaseManager {

 /* insertFRCMChecklist(FRCMCheckBoxData frcmCheckBoxData) async {
    final bool isInitialized = await EcpsFrcmMmodel().initializeDB();

    if (isInitialized == true) {

      frcmCheckBoxData.save();

      //final newId = await  frcmCheckBoxData.save();
    }
  }*/



/*  Future<void> insertFRCMChecklist(FRCMCheckBoxData frcmCheckBoxData) async {
    final frcmCheckBoxData = await FRCMCheckBoxData().select().toSingle();
    if (frcmCheckBoxData == null) {
      await Category(name: 'Notebooks', isActive: true).save();
      await Category(name: 'Ultrabooks', isActive: true).save();
    } else {
      print(
          'There is already categories in the database.. addCategories will not run');
    }
  }*/




}
