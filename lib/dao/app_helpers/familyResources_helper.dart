import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/familyResources.dart';
import 'package:sqflite/sqflite.dart';

class FamilyResourcesHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getFamilyMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_FAMILY_RESOURCE');
    return result;
  }

  Future<int> insertFamily(FamilyResources familyResources) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_FAMILY_RESOURCE", familyResources.toMap());
    return result;
  }

  Future<int> updateFamily(FamilyResources familyResources) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_FAMILY_RESOURCE",
        familyResources.toMap(), where: 'id = ?', whereArgs: [familyResources.id]);
    return result;
  }

  Future<int> deleteFamily(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_FAMILY_RESOURCE WHERE id = $id');
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_FAMILY_RESOURCE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<FamilyResources>> getFamilyList() async {

    var fMapList = await getFamilyMapList();
    int count = fMapList.length;

    // ignore: deprecated_member_use
    List<FamilyResources> fList = List<FamilyResources>();

    for (int i = 0; i < count; i++) {
      fList.add(FamilyResources.fromMapObject(fMapList[i]));
    }

    return fList;
  }

  FamilyResources getResources(int value, List<FamilyResources> list) {
    FamilyResources resource;

    switch (value) {
      case 1:
        resource = list[0];
        break;
      case 2:
        resource = list[1];
        break;
      case 3:
        resource = list[2];
        break;
      case 4:
        resource = list[3];
        break;
    }
    return resource;
  }

  Future<int> checkFamilyRes(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_FAMILY_RESOURCE WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
