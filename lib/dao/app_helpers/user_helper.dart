import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> checkUser(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_ACTOR WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<User> getLogin(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM TB_ACTOR WHERE login = '$user' and password = '$password'");
    if (res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  Future<User> getId(int id) async {
    User user;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM TB_ACTOR WHERE id = '$id'");
    if (res.length > 0) {
      user = new User.fromMap(res.first);
    }
    return user;
  }

  // Fetch Operation: Get all User objects from database
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.query("TB_ACTOR");
    return result;
  }

  // Insert Operation: Insert a User object to database
  Future<int> insertUser(User user) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_ACTOR", user.toMap());
    //await dbClient.execute("commit",null);
    return result;
  }

  // Update Operation: Update a User object and save it to database
  Future<int> updateUser(User user) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_ACTOR", user.toMap(), where: 'login = ?', whereArgs: [user.login]);
    return result;
  }

  Future<int> updateUserwithId(User user) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_ACTOR", user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    return result;
  }

  // Delete Operation: Delete a User object from database
  Future<int> deleteUser(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_ACTOR WHERE id = $id');
    return result;
  }

  // Get number of User objects in database
  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_ACTOR');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList();
    List<User> userList = <User>[];
    for (int i = 0; i < userMapList.length; i++) {
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }

  // Fetch Operation: Get User objects based on gender from database
  Future<List<Map<String, dynamic>>> getUseronGenderMapList(int id) async {
    var dbClient = await con.db;
    var result = await dbClient.query("TB_ACTOR WHERE sexId = '$id'");
    return result;
  }

  Future<List<User>> getUseronGenderList(int id) async {
    var userMapList = await getUseronGenderMapList(id);
    // ignore: deprecated_member_use
    List<User> userList = List<User>();
    for (int i = 0; i < userMapList.length; i++) {
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }

  Future<List<Map<String, dynamic>>> getUseronIdMapList(int id) async {
    var dbClient = await con.db;
    var result = await dbClient.query("TB_ACTOR WHERE id = '$id'");
    return result;
  }

  Future<List<User>> getUseronIdList(int id) async {
    var userMapList = await getUseronIdMapList(id);
    // ignore: deprecated_member_use
    List<User> userList = List<User>();
    for (int i = 0; i < userMapList.length; i++) {
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }

  Future<List<Map<String, dynamic>>> gMapList(int delayLid) async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT TB_ACTOR.* FROM TB_ACTOR INNER JOIN TB_PAIEMENT_STATE ON TB_ACTOR.id = TB_PAIEMENT_STATE.actorId WHERE TB_PAIEMENT_STATE.levelDelayPaymentId = '$delayLid'");
    return result;
  }

  Future<List<User>> gList(int delay) async {
    var userMapList = await gMapList(delay);
    // ignore: deprecated_member_use
    List<User> userList = List<User>();
    for (int i = 0; i < userMapList.length; i++) {
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }

  Future<List<Map<String, dynamic>>> getSyncUserMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT * FROM TB_ACTOR WHERE isSend = '1' AND synch != '1'");
    return result;
  }

  Future<List<User>> getSyncUserList() async {
    var userMapList = await getSyncUserMapList();
    // ignore: deprecated_member_use
    List<User> userList = List<User>();
    for (int i = 0; i < userMapList.length; i++) {
      userList.add(User.fromMap(userMapList[i]));
    }
    return userList;
  }
}
