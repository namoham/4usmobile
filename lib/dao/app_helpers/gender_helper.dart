import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/gender.dart';
import 'package:sqflite/sqflite.dart';

class GenderHelper {
  DatabaseHelper con = new DatabaseHelper();

  // Fetch Operation: Get all User objects from database
  Future<List<Map<String, dynamic>>> getGenderMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_SEX');
    return result;
  }

  Future<Gender> getId(int id) async {
    Gender gender;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_SEX WHERE id = '$id'");

    if (res.length > 0) {
      gender = new Gender.fromMapObject(res.first);
    }
    return gender;
  }

  // Insert Operation: Insert a User object to database
  Future<int> insertGender(Gender gender) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_SEX", gender.toMap());
    return result;
  }

  // Update Operation: Update a User object and save it to database
  Future<int> updateGender(Gender gender) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_SEX", gender.toMap(), where: 'id = ?', whereArgs: [gender.id]);
    return result;
  }

  // Delete Operation: Delete a User object from database
  Future<int> deleteGender(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_SEX WHERE id = $id');
    return result;
  }

  Future<int> checkGender(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_SEX WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get number of User objects in database
  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_SEX');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Gender>> getGenderList() async {

    var genderMapList = await getGenderMapList();
    int count = genderMapList.length;

    // ignore: deprecated_member_use
    List<Gender> genderList = List<Gender>();

    for (int i = 0; i < count; i++) {
      genderList.add(Gender.fromMapObject(genderMapList[i]));
    }

    return genderList;
  }

  Gender getgender(int value, List<Gender> list) {
    Gender gen;
    switch (value) {
      case 1:
        gen = list[0];  // 'Male'
        break;
      case 2:
        gen = list[1];  // 'Female'
        break;
    }
    return gen;
  }
}
