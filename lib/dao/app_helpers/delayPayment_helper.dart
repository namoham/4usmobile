import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/delayPayment.dart';
import 'package:sqflite/sqflite.dart';

class DelayPaymentHelper {
  DatabaseHelper con = new DatabaseHelper();

//all inner join
  Future<DelayPayment> getDelayPayment(int id) async {
    DelayPayment delayPayment;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT TB_ACTOR.id as idBeneficiary, TB_DELAY_PAYMENT_LEVEL.id as idClass, TB_ACTOR.Name, TB_DELAY_PAYMENT_LEVEL.name as nameClass, TB_DELAY_PAYMENT_LEVEL.colorCode, TB_ACTOR.mapsAddress, TB_ACTOR.telephone, TB_ACTOR.identity_, TB_ACTOR.photo, TB_ACTOR.synch, TB_ACTOR.isSend FROM TB_ACTOR left outer join  TB_PAIEMENT_STATE ON TB_PAIEMENT_STATE.actorId = TB_ACTOR.id left outer join  TB_DELAY_PAYMENT_LEVEL ON TB_DELAY_PAYMENT_LEVEL.id = TB_PAIEMENT_STATE.levelDelayPaymentId WHERE idBeneficiary = '$id'");
    if (res.length > 0) {
      delayPayment = new DelayPayment.fromMapObject(res.first);
    }
    print(delayPayment);
    return delayPayment;
  }

  Future<List<Map<String, dynamic>>> getDelayPaymentMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT TB_ACTOR.id as idBeneficiary, TB_DELAY_PAYMENT_LEVEL.id as idClass, TB_ACTOR.Name, TB_DELAY_PAYMENT_LEVEL.name as nameClass, TB_DELAY_PAYMENT_LEVEL.colorCode, TB_ACTOR.mapsAddress, TB_ACTOR.telephone, TB_ACTOR.identity_, TB_ACTOR.photo, TB_ACTOR.synch, TB_ACTOR.isSend FROM TB_ACTOR left outer join  TB_PAIEMENT_STATE ON TB_PAIEMENT_STATE.actorId = TB_ACTOR.id left outer join  TB_DELAY_PAYMENT_LEVEL ON  TB_DELAY_PAYMENT_LEVEL.id = TB_PAIEMENT_STATE.levelDelayPaymentId");
    return result;
  }

  Future<List<DelayPayment>> getDelayPaymentList() async {

    var userMapList = await getDelayPaymentMapList();
    int count = userMapList.length;

    // ignore: deprecated_member_use
    List<DelayPayment> userList = List<DelayPayment>();

    for (int i = 0; i < count; i++) {
      userList.add(DelayPayment.fromMapObject(userMapList[i]));
    }

    return userList;
  }


  Future<List<Map<String, dynamic>>> getuserbyIdentityMapList(String identity) async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT TB_ACTOR.id as idBeneficiary, TB_DELAY_PAYMENT_LEVEL.id as idClass, TB_ACTOR.Name, TB_DELAY_PAYMENT_LEVEL.name as nameClass, TB_DELAY_PAYMENT_LEVEL.colorCode, TB_ACTOR.mapsAddress, TB_ACTOR.telephone, TB_ACTOR.identity_, TB_ACTOR.photo, TB_ACTOR.synch, TB_ACTOR.isSend FROM TB_ACTOR left outer join  TB_PAIEMENT_STATE ON TB_PAIEMENT_STATE.actorId = TB_ACTOR.id left outer join  TB_DELAY_PAYMENT_LEVEL ON  TB_DELAY_PAYMENT_LEVEL.id = TB_PAIEMENT_STATE.levelDelayPaymentId WHERE (TB_ACTOR.identity_ Like '%$identity%' OR TB_ACTOR.Name like '%$identity%')");
    return result;
  }

  Future<List<DelayPayment>> getuserbyIdentityList(String identity) async {

    var userMapList = await getuserbyIdentityMapList(identity);
    int count = userMapList.length;

    // ignore: deprecated_member_use
    List<DelayPayment> userList = List<DelayPayment>();

    for (int i = 0; i < count; i++) {
      userList.add(DelayPayment.fromMapObject(userMapList[i]));
    }

    return userList;
  }

  Future<List<Map<String, dynamic>>> gMapList(int delayLid) async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT TB_ACTOR.id as idBeneficiary, TB_DELAY_PAYMENT_LEVEL.id, TB_ACTOR.Name, TB_DELAY_PAYMENT_LEVEL.name as nameClass, TB_DELAY_PAYMENT_LEVEL.colorCode, TB_ACTOR.mapsAddress, TB_ACTOR.telephone, TB_ACTOR.identity_, TB_ACTOR.photo, TB_ACTOR.synch, TB_ACTOR.isSend FROM TB_DELAY_PAYMENT_LEVEL INNER JOIN TB_PAIEMENT_STATE ON  TB_DELAY_PAYMENT_LEVEL.id = TB_PAIEMENT_STATE.levelDelayPaymentId INNER JOIN TB_ACTOR ON TB_PAIEMENT_STATE.actorId = TB_ACTOR.id WHERE TB_PAIEMENT_STATE.levelDelayPaymentId = '$delayLid'");
    return result;
  }

  Future<List<DelayPayment>> gList(int delay) async {

    var userMapList = await gMapList(delay);
    int count = userMapList.length;

    // ignore: deprecated_member_use
    List<DelayPayment> userList = List<DelayPayment>();

    for (int i = 0; i < count; i++) {
      userList.add(DelayPayment.fromMapObject(userMapList[i]));
    }

    return userList;
  }

  // Get number of User objects in database
  Future<int> getCount(int level) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT(*) FROM TB_PAIEMENT_STATE WHERE TB_PAIEMENT_STATE.levelDelayPaymentId = $level');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}