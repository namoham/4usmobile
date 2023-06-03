import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/studyLevel.dart';
import 'package:sqflite/sqflite.dart';

class StudyHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getStudyMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_STUDY_LEVEL');
    return result;
  }

  Future<int> insertStudy(StudyLevel studyLevel) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_STUDY_LEVEL", studyLevel.toMap());
    return result;
  }

  Future<int> updateStudy(StudyLevel studyLevel) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_STUDY_LEVEL", studyLevel.toMap(), where: 'id = ?', whereArgs: [studyLevel.id]);
    return result;
  }

  Future<int> deleteStudy(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_STUDY_LEVEL WHERE id = $id');
    return result;
  }

  Future<int> checkStudy(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_STUDY_LEVEL WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_STUDY_LEVEL');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<StudyLevel>> getStudyList() async {

    var studyMapList = await getStudyMapList();
    int count = studyMapList.length;

    // ignore: deprecated_member_use
    List<StudyLevel> studyList = List<StudyLevel>();

    for (int i = 0; i < count; i++) {
      studyList.add(StudyLevel.fromMapObject(studyMapList[i]));
    }

    return studyList;
  }

  StudyLevel getStudy(int value, List<StudyLevel> list) {
    StudyLevel study;

    switch (value) {
      case 1:
        study = list[0];
        break;
      case 2:
        study = list[1];
        break;
      case 3:
        study = list[2];
        break;
      case 4:
        study = list[3];
        break;
    }
    return study;
  }
}
