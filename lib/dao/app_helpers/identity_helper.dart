import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/identity.dart';
import 'package:sqflite/sqflite.dart';

class IdentityHelper {
  DatabaseHelper con = new DatabaseHelper();

  // Fetch Operation: Get all User objects from database
  Future<List<Map<String, dynamic>>> getIdentityMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_TYPE_IDENTITY');
    return result;
  }

  // Insert Operation: Insert a User object to database
  Future<int> insertIdentity(Identity identity) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_TYPE_IDENTITY", identity.toMap());
    return result;
  }

  // Update Operation: Update a User object and save it to database
  Future<int> updateIdentity(Identity identity) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_TYPE_IDENTITY", identity.toMap(), where: 'id = ?', whereArgs: [identity.id]);
    return result;
  }

  // Delete Operation: Delete a User object from database
  Future<int> deleteIdentity(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_TYPE_IDENTITY WHERE id = $id');
    return result;
  }

  Future<int> checkIdentity(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_TYPE_IDENTITY WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get number of User objects in database
  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_TYPE_IDENTITY');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Identity>> getIdentityList() async {

    var identityMapList = await getIdentityMapList();
    int count = identityMapList.length;

    // ignore: deprecated_member_use
    List<Identity> identityList = List<Identity>();

    for (int i = 0; i < count; i++) {
      identityList.add(Identity.fromMapObject(identityMapList[i]));
    }

    return identityList;
  }

  Identity getIdentity(int value, List<Identity> list) {
    Identity identity;

    switch (value) {
      case 1:
        identity = list[0];
        break;
      case 2:
        identity = list[1];
        break;
      case 3:
        identity = list[2];
        break;
      case 4:
        identity = list[3];
        break;
      case 5:
        identity = list[4];
        break;
    }
    return identity;
  }

}
