import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/parameters.dart';
import 'package:sqflite/sqflite.dart';

class ParameterHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getParametersMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT * FROM TB_PARAMETERS');
    return result;
  }

  Future<List<Parameters>> getParameterList() async {

    var parameterMapList = await getParametersMapList();
    int count = parameterMapList.length;

    // ignore: deprecated_member_use
    List<Parameters> parameterList = List<Parameters>();

    for (int i = 0; i < count; i++) {
      parameterList.add(Parameters.fromMapObject(parameterMapList[i]));
    }

    return parameterList;
  }

  Future<Parameters> getParameterById(int id) async {
    Parameters parameters;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_PARAMETERS WHERE id = '$id'");

    if (res.length > 0) {
      parameters = new Parameters.fromMapObject(res.first);
    }
    return parameters;
  }

  Future<Parameters> getParameterByKey(String key) async {
    Parameters parameters;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_PARAMETERS WHERE key = '$key'");

    if (res.length > 0) {
      parameters = new Parameters.fromMapObject(res.first);
    }
    return parameters;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_PARAMETERS');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> updateParameter(Parameters parameters) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_PARAMETERS",
        parameters.toMap(), where: 'key = ?', whereArgs: [parameters.key]);
    return result;
  }

  Future<int> checkParameter(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_DELAY_PAYMENT_LEVEL WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> insertParameter(Parameters parameters) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_PARAMETERS",
        parameters.toMap());
    return result;
  }
}
