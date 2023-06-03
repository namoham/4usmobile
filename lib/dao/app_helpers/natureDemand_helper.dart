import 'dart:async';

import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/natureDemand_model.dart';
import 'package:sqflite/sqflite.dart';

class NatureDemandHelper {
  DatabaseHelper con = new DatabaseHelper();


  Future<int> checkNatureDemand(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_REQUEST_NATURE WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> insertNatureDemand(NatureDemand natureDemand) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_REQUEST_NATURE",
        natureDemand.toMap());
    return result;
  }

  Future<int> updateNatureDemand(NatureDemand natureDemand) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_REQUEST_NATURE",
        natureDemand.toMap(), where: 'id = ?', whereArgs: [natureDemand.id]);
    return result;
  }

  Future<NatureDemand> getId(int id) async {
    NatureDemand demand;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_REQUEST_NATURE WHERE id = '$id'");

    if (res.length > 0) {
      demand = new NatureDemand.fromMap(res.first);
      //return user;
    }
    return demand;
//    return null;
  }

  Future<List<Map<String, dynamic>>> getNatureDemandMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT id, Name FROM TB_REQUEST_NATURE");
    return result;
  }

  Future<List<NatureDemand>> getNatureDemandList() async {

    var natureDemandMapList = await getNatureDemandMapList(); // Get 'Map List' from database
    int count = natureDemandMapList.length;         // Count the number of map entries in db table

    // ignore: deprecated_member_use
    List<NatureDemand> natureDemandList = List<NatureDemand>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      natureDemandList.add(NatureDemand.fromMap(natureDemandMapList[i]));
    }

    return natureDemandList;
  }

  NatureDemand getNatureDemand(int value, List<NatureDemand> list) {
    NatureDemand natureDe;

    switch (value) {
      case 1:
        natureDe = list[0];
        break;
      case 2:
        natureDe = list[1];
        break;
    }
    return natureDe;
  }
}
