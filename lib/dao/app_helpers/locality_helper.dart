import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/locality.dart';
import 'package:sqflite/sqflite.dart';

class LocalityHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getLocalityMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name, provinceId FROM TB_LOCALITY');
    return result;
  }

  Future<List<Map<String, dynamic>>> getLocalityBaseOnProvinceMapList(int id) async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name, provinceId FROM TB_LOCALITY WHERE provinceId = $id');
    return result;
  }

  Future<int> insertLocality(Locality locality) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_LOCALITY", locality.toMap());
    return result;
  }

  Future<int> updateLocality(Locality locality) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_LOCALITY",
        locality.toMap(), where: 'id = ?', whereArgs: [locality.id]);
    return result;
  }

  Future<int> deleteLocality(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_LOCALITY WHERE id = $id');
    return result;
  }

  Future<int> checkLocality(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_LOCALITY WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_LOCALITY');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Locality>> getLocalityList() async {

    var localityMapList = await getLocalityMapList();
    int count = localityMapList.length;

    // ignore: deprecated_member_use
    List<Locality> localityList = List<Locality>();

    for (int i = 0; i < count; i++) {
      localityList.add(Locality.fromMapObject(localityMapList[i]));
    }

    return localityList;
  }

  Future<List<Locality>> getLocalityBaseOnRegionList(int id) async {

    var loMapList = await getLocalityBaseOnProvinceMapList(id);
    int count = loMapList.length;

    // ignore: deprecated_member_use
    List<Locality> loList = List<Locality>();

    for (int i = 0; i < count; i++) {
      loList.add(Locality.fromMapObject(loMapList[i]));
    }

    return loList;
  }

  Locality getLocal(int value, List<Locality> list) {
    Locality local;

    switch (value) {
      case 1:
        local = list[0];
        break;
      case 2:
        local = list[1];
        break;
      case 3:
        local = list[2];
        break;
      case 4:
        local = list[3];
        break;
      case 5:
        local = list[4];
        break;
      case 6:
        local = list[5];
        break;
      case 7:
        local = list[6];
        break;
      case 8:
        local = list[7];
        break;
      case 9:
        local = list[8];
        break;
      case 10:
        local = list[9];
        break;
      case 11:
        local = list[10];
        break;
      case 12:
        local = list[11];
        break;
      case 13:
        local = list[12];
        break;
      case 14:
        local = list[13];
        break;
      case 15:
        local = list[14];
        break;
      case 16:
        local = list[15];
        break;
      case 17:
        local = list[16];
        break;
      case 18:
        local = list[17];
        break;
      case 19:
        local = list[18];
        break;
      case 20:
        local = list[19];
        break;
      case 21:
        local = list[20];
        break;
    }
    return local;
  }
}
