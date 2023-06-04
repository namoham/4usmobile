import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/delayLevel.dart';
import 'package:sqflite/sqflite.dart';

class DelayLevelHelper {
  DatabaseHelper con = new DatabaseHelper();

  // Fetch Operation: Get all User objects from database
  Future<List<Map<String, dynamic>>> getDelayMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, name, colorCode FROM TB_DELAY_PAYMENT_LEVEL');
    return result;
  }

  Future<DelayLevel> getId(int id) async {
    DelayLevel delayLevel;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_DELAY_PAYMENT_LEVEL WHERE id = '$id'");

    if (res.length > 0) {
      delayLevel = new DelayLevel.fromMapObject(res.first);
    }
    return delayLevel;
  }


  Future<DelayLevel> getDelay(int id) async {
    DelayLevel delayLevel;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT TB_DELAY_PAYMENT_LEVEL.* FROM TB_DELAY_PAYMENT_LEVEL INNER JOIN TB_PAIEMENT_STATE ON TB_DELAY_PAYMENT_LEVEL.id = TB_PAIEMENT_STATE.levelDelayPaymentId WHERE TB_PAIEMENT_STATE.actorId = '$id'");
    if (res.length > 0) {
      delayLevel = new DelayLevel.fromMapObject(res.first);
    }
    return delayLevel;
  }


//all inner join
  Future<DelayLevel> getDelayPayment(int id) async {
    DelayLevel delayLevel;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT TB_DELAY_PAYMENT_LEVEL.* FROM TB_DELAY_PAYMENT_LEVEL INNER JOIN TB_PAIEMENT_STATE ON TB_DELAY_PAYMENT_LEVEL.id = TB_PAIEMENT_STATE.levelDelayPaymentId INNER JOIN TB_ACTOR ON TB_PAIEMENT_STATE.actorId = TB_ACTOR.id");

    if (res.length > 0) {
      delayLevel = new DelayLevel.fromMapObject(res.first);
    }
    return delayLevel;
  }

  // Get number of User objects in database
  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_ACTOR_ACTIVITY');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<DelayLevel>> getDelayList() async {

    var delayMapList = await getDelayMapList();
    int count = delayMapList.length;

    // ignore: deprecated_member_use
    List<DelayLevel> delayList = List<DelayLevel>();

    for (int i = 0; i < count; i++) {
      delayList.add(DelayLevel.fromMapObject(delayMapList[i]));
    }

    return delayList;
  }


  Future<List<Map<String, dynamic>>> gMapList(int actorId) async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT TB_DELAY_PAYMENT_LEVEL.* FROM TB_DELAY_PAYMENT_LEVEL INNER JOIN TB_PAIEMENT_STATE ON TB_DELAY_PAYMENT_LEVEL.id = TB_PAIEMENT_STATE.levelDelayPaymentId WHERE TB_PAIEMENT_STATE.actorId = '$actorId'");
    return result;
  }

  Future<List<DelayLevel>> delayList(int actor) async {

    var userMapList = await gMapList(actor);
    int count = userMapList.length;

    // ignore: deprecated_member_use
    List<DelayLevel> userList = List<DelayLevel>();

    for (int i = 0; i < count; i++) {
      userList.add(DelayLevel.fromMapObject(userMapList[i]));
    }

    return userList;
  }

  Future<int> checkDelayLevel(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_DELAY_PAYMENT_LEVEL WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> insertDelayLevel(DelayLevel delayLevel) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_DELAY_PAYMENT_LEVEL",
        delayLevel.toMap());
    return result;
  }

  Future<int> updateDelayLevel(DelayLevel delayLevel) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_DELAY_PAYMENT_LEVEL",
        delayLevel.toMap(), where: 'id = ?', whereArgs: [delayLevel.id]);
    return result;
  }

}

