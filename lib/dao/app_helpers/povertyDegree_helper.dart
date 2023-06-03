import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/povertyDegree.dart';
import 'package:sqflite/sqflite.dart';

class PovertyHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getPovertyMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_POVERTY_DEGREE');
    return result;
  }

  Future<int> insertPoverty(PovertyDegree povertyDegree) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_POVERTY_DEGREE", povertyDegree.toMap());
    return result;
  }

  Future<int> updatePoverty(PovertyDegree povertyDegree) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_POVERTY_DEGREE", povertyDegree.toMap(), where: 'id = ?', whereArgs: [povertyDegree.id]);
    return result;
  }

  Future<int> deletePoverty(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_POVERTY_DEGREE WHERE id = $id');
    return result;
  }

  Future<int> checkPoverty(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_POVERTY_DEGREE WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_POVERTY_DEGREE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<PovertyDegree>> getPovertyList() async {

    var povertyMapList = await getPovertyMapList();
    int count = povertyMapList.length;

    // ignore: deprecated_member_use
    List<PovertyDegree> povertyList = List<PovertyDegree>();

    for (int i = 0; i < count; i++) {
      povertyList.add(PovertyDegree.fromMapObject(povertyMapList[i]));
    }

    return povertyList;
  }

  PovertyDegree getPoverty(int value, List<PovertyDegree> list) {
    PovertyDegree poverty;

    switch (value) {
      case 1:
        poverty = list[0];
        break;
      case 2:
        poverty = list[1];
        break;
      case 3:
        poverty = list[2];
        break;
    }
    return poverty;
  }

}
