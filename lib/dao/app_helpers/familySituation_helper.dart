import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/familySituation.dart';
import 'package:sqflite/sqflite.dart';

class FamilySituationHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getFamilyMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_FAMILY_SITUATION');
    return result;
  }

  Future<int> insertFamily(FamilySituation familySituation) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_FAMILY_SITUATION", familySituation.toMap());
    return result;
  }

  Future<int> updateFamily(FamilySituation familySituation) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_FAMILY_SITUATION", familySituation.toMap(), where: 'id = ?', whereArgs: [familySituation.id]);
    return result;
  }

  Future<int> deleteFamily(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_FAMILY_SITUATION WHERE id = $id');
    return result;
  }

  Future<int> checkFamilySit(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_FAMILY_SITUATION WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_FAMILY_SITUATION');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<FamilySituation>> getFamilyList() async {

    var fMapList = await getFamilyMapList();
    int count = fMapList.length;

    // ignore: deprecated_member_use
    List<FamilySituation> fList = List<FamilySituation>();

    for (int i = 0; i < count; i++) {
      fList.add(FamilySituation.fromMapObject(fMapList[i]));
    }

    return fList;
  }

  FamilySituation getSituation(int value, List<FamilySituation> list) {
    FamilySituation situation;

    switch (value) {
      case 1:
        situation = list[0];
        break;
      case 2:
        situation = list[1];
        break;
      case 3:
        situation = list[2];
        break;
      case 4:
        situation = list[3];
        break;
    }
    return situation;
  }

}
