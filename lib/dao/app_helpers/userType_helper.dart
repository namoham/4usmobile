import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/userType.dart';
import 'package:sqflite/sqflite.dart';

class UserTypeHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getTypeMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_TYPE_ACTOR');
    return result;
  }

  Future<int> insert(UserType userType) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_TYPE_ACTOR", userType.toMap());
    return result;
  }

  Future<int> update(UserType userType) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_TYPE_ACTOR", userType.toMap(), where: 'id = ?', whereArgs: [userType.id]);
    return result;
  }

  Future<int> delete(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_TYPE_ACTOR WHERE id = $id');
    return result;
  }

  Future<int> check(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_TYPE_ACTOR WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_TYPE_ACTOR');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<UserType>> getTypeList() async {

    var tMapList = await getTypeMapList();
    int count = tMapList.length;

    // ignore: deprecated_member_use
    List<UserType> tList = List<UserType>();

    for (int i = 0; i < count; i++) {
      tList.add(UserType.fromMapObject(tMapList[i]));
    }

    return tList;
  }

  UserType getType(int value, List<UserType> list) {
    UserType type;

    switch (value) {
      case 1:
        type = list[0];
        break;
      case 2:
        type = list[1];
        break;
      case 3:
        type = list[2];
        break;
      case 4:
        type = list[3];
        break;
      case 5:
        type = list[4];
        break;
    }
    return type;
  }
}
