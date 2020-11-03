import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import '../tools/helper.dart';
import 'view.list.dart';

part 'model.g.dart';
part 'model.g.view.dart';

const FRCMChecklist = SqfEntityTable(
    tableName: 'FRCMCheckBoxData',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('userName', DbType.text),
      SqfEntityField('userPassword', DbType.text),
      SqfEntityField('selectedProject', DbType.text),
      SqfEntityField('selectedPhase', DbType.text),
      SqfEntityField('selectedSubPhase', DbType.text),
      SqfEntityField('selectedCheckBoxTitle', DbType.text),
      SqfEntityField('selectedCheckBoxStatus', DbType.text),
      SqfEntityField('selectedCheckBoxComments', DbType.text),

    ]);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(FRCMmodel)
const FRCMmodel = SqfEntityModel(
    modelName: 'EcpsFrcmMmodel',
    databaseName: 'EcpsFrcm',
    password: null,
    databaseTables: [FRCMChecklist],
    formTables: [FRCMChecklist],
    sequences: [seqIdentity],
    dbVersion: 2,
    bundledDatabasePath: null);
