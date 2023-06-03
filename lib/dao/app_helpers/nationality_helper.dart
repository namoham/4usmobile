import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/nationality.dart';
import 'package:sqflite/sqflite.dart';

class NationalityHelper {
  DatabaseHelper con = new DatabaseHelper();

  // Fetch Operation: Get all User objects from database
  Future<List<Map<String, dynamic>>> getNationalityMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_NATIONALITY');
    return result;
  }

  // Insert Operation: Insert a User object to database
  Future<int> insertNationality(Nationality nationality) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_NATIONALITY", nationality.toMap());
    return result;
  }

  // Update Operation: Update a User object and save it to database
  Future<int> updateNationality(Nationality nationality) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_NATIONALITY", nationality.toMap(), where: 'id = ?', whereArgs: [nationality.id]);
    return result;
  }

  // Delete Operation: Delete a User object from database
  Future<int> deleteNationality(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_NATIONALITY WHERE id = $id');
    return result;
  }

  Future<int> checkNationality(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_NATIONALITY WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get number of User objects in database
  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_NATIONALITY');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Nationality>> getNationalityList() async {

    var nationalityMapList = await getNationalityMapList();
    int count = nationalityMapList.length;

    // ignore: deprecated_member_use
    List<Nationality> nationalityList = List<Nationality>();

    for (int i = 0; i < count; i++) {
      nationalityList.add(Nationality.fromMapObject(nationalityMapList[i]));
    }

    return nationalityList;
  }

  Nationality getNation(int value, List<Nationality> list) {
    Nationality nation;
    switch (value) {
      case 1:
        nation = list[0];
        break;
      case 2:
        nation = list[1];
        break;
      case 3:
        nation = list[2];
        break;
      case 4:
        nation = list[3];
        break;
      case 5:
        nation = list[4];
        break;
      case 6:
        nation = list[5];
        break;
      case 7:
        nation = list[6];
        break;
      case 8:
        nation = list[7];
        break;
    }
    return nation;
  }
}
