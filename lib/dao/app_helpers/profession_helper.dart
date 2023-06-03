import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/profession.dart';
import 'package:sqflite/sqflite.dart';

class ProfessionHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getProfessionMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_PROFESSION');
    return result;
  }

  Future<int> insertProfession(Profession profession) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_PROFESSION", profession.toMap());
    return result;
  }

  Future<int> updateProfession(Profession profession) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_PROFESSION", profession.toMap(), where: 'id = ?', whereArgs: [profession.id]);
    return result;
  }

  Future<int> deleteProfession(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_PROFESSION WHERE id = $id');
    return result;
  }

  Future<int> checkProfession(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_PROFESSION WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_PROFESSION');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Profession>> getProfessionList() async {

    var professionMapList = await getProfessionMapList();
    int count = professionMapList.length;

    // ignore: deprecated_member_use
    List<Profession> professionList = List<Profession>();

    for (int i = 0; i < count; i++) {
      professionList.add(Profession.fromMapObject(professionMapList[i]));
    }

    return professionList;
  }

  Profession getProfession(int value, List<Profession> list) {
    Profession profes;

    switch (value) {
      case 1:
        profes = list[0];
        break;
      case 2:
        profes = list[1];
        break;
      case 3:
        profes = list[2];
        break;
      case 4:
        profes = list[3];
        break;
    }
    return profes;
  }
}
