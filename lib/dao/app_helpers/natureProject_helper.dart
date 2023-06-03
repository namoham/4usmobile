import 'dart:async';

import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/natureProject_model.dart';
import 'package:sqflite/sqflite.dart';

class NatureProjectHelper {

  DatabaseHelper con = new DatabaseHelper();

  Future<int> checkNatureProject(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_PROJECT_NATURE WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> insertNatureProject(NatureProject natureProject) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_PROJECT_NATURE",
        natureProject.toMap());
    return result;
  }

  Future<int> updateNatureProject(NatureProject natureProject) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_PROJECT_NATURE",
        natureProject.toMap(), where: 'id = ?', whereArgs: [natureProject.id]);
    return result;
  }

  Future<NatureProject> getId(int id) async {
    NatureProject demand;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_PROJECT_NATURE WHERE id = '$id'");

    if (res.length > 0) {
      demand = new NatureProject.fromMap(res.first);
      //return user;
    }
    return demand;
//    return null;
  }

  Future<List<Map<String, dynamic>>> getNatureProjectMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT id, Name FROM TB_PROJECT_NATURE");
    return result;
  }

  Future<List<NatureProject>> getNatureProjectList() async {

    var natureProjectMapList = await getNatureProjectMapList();
    int count = natureProjectMapList.length;

    // ignore: deprecated_member_use
    List<NatureProject> natureProjectList = List<NatureProject>();
    for (int i = 0; i < count; i++) {
      natureProjectList.add(NatureProject.fromMap(natureProjectMapList[i]));
    }
    return natureProjectList;
  }

  NatureProject getNatureProject(int value, List<NatureProject> list) {
    NatureProject natureProj;

    switch (value) {
      case 1:
        natureProj = list[0];
        break;
      case 2:
        natureProj = list[1];
        break;
    }
    return natureProj;
  }
}
