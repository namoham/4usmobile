import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/occupation.dart';
import 'package:sqflite/sqflite.dart';

class OccupationHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getOccupationMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_TYPE_OCCUPATION');
    return result;
  }

  Future<int> insertOccupation(Occupation occupation) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_TYPE_OCCUPATION", occupation.toMap());
    return result;
  }

  Future<int> updateOccupation(Occupation occupation) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_TYPE_OCCUPATION", occupation.toMap(), where: 'id = ?', whereArgs: [occupation.id]);
    return result;
  }

  Future<int> deleteOccupation(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_TYPE_OCCUPATION WHERE id = $id');
    return result;
  }

  Future<int> checkOccupation(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_TYPE_OCCUPATION WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_TYPE_OCCUPATION');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Occupation>> getOccupationList() async {

    var occupationMapList = await getOccupationMapList();
    int count = occupationMapList.length;

    // ignore: deprecated_member_use
    List<Occupation> occupationList = List<Occupation>();

    for (int i = 0; i < count; i++) {
      occupationList.add(Occupation.fromMapObject(occupationMapList[i]));
    }

    return occupationList;
  }

  Occupation getOccup(int value, List<Occupation> list) {
    Occupation occup;

    switch (value) {
      case 1:
        occup = list[0];
        break;
      case 2:
        occup = list[1];
        break;
    }
    return occup;
  }
}
