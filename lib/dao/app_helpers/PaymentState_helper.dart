import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/paymentState.dart';
import 'package:sqflite/sqflite.dart';

class PaymentStateHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getPaymentMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT * FROM TB_PAIEMENT_STATE');
    return result;
  }

  Future<Payment> getUserId(int id) async {
    Payment payment;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_PAIEMENT_STATE WHERE actorId = '$id'");
    if (res.length > 0) {
      payment = new Payment.fromMapObject(res.first);
    }
    return payment;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_PAIEMENT_STATE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Payment>> getPaymentList() async {

    var paymentMapList = await getPaymentMapList();
    int count = paymentMapList.length;

    // ignore: deprecated_member_use
    List<Payment> paymentList = List<Payment>();

    for (int i = 0; i < count; i++) {
      paymentList.add(Payment.fromMapObject(paymentMapList[i]));
    }

    return paymentList;
  }

  Future<List<Map<String, dynamic>>> getPaymentronDelayMapList(int num) async {
    var dbClient = await con.db;
    var result = await dbClient.query("TB_PAIEMENT_STATE WHERE numberDayDelay = '$num'");
    return result;
  }

  Future<List<Payment>> getPaymentronDelayList(int number) async {

    var paymentMapList = await getPaymentronDelayMapList(number);
    int count = paymentMapList.length;

    // ignore: deprecated_member_use
    List<Payment> paymentList = List<Payment>();

    for (int i = 0; i < count; i++) {
      paymentList.add(Payment.fromMapObject(paymentMapList[i]));
    }

    return paymentList;
  }

  Future<int> checkPay(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_PAIEMENT_STATE WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //insertion
  Future<int> insertPay(Payment payment) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("TB_PAIEMENT_STATE", payment.toMap());
    return res;
  }

  // update
  Future<int> updatePay(Payment payment) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_PAIEMENT_STATE", payment.toMap(),
        where: 'id = ?', whereArgs: [payment.id]);
    return result;
  }

}
