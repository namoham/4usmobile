import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/province.dart';
import 'package:sqflite/sqflite.dart';

class ProvinceHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getProvinceMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name, regionId FROM TB_PROVINCE');
    return result;
  }

  Future<List<Map<String, dynamic>>> getProvinceBaseOnRegionMapList(int id) async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name, regionId FROM TB_PROVINCE WHERE regionId = $id');
    return result;
  }

  Future<int> insertProvince(Province province) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_PROVINCE", province.toMap());
    return result;
  }

  Future<int> updateProvince(Province province) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_PROVINCE", province.toMap(), where: 'id = ?', whereArgs: [province.id]);
    return result;
  }

  Future<int> deleteProvince(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_PROVINCE WHERE id = $id');
    return result;
  }

  Future<int> checkProvince(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_PROVINCE WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_PROVINCE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Province>> getProvinceList() async {

    var provinceMapList = await getProvinceMapList();
    int count = provinceMapList.length;

    // ignore: deprecated_member_use
    List<Province> provinceList = List<Province>();

    for (int i = 0; i < count; i++) {
      provinceList.add(Province.fromMapObject(provinceMapList[i]));
    }

    return provinceList;
  }

  Future<List<Province>> getProvinceBaseOnRegionList(int id) async {

    var pMapList = await getProvinceBaseOnRegionMapList(id);
    int count = pMapList.length;

    // ignore: deprecated_member_use
    List<Province> pList = List<Province>();

    for (int i = 0; i < count; i++) {
      pList.add(Province.fromMapObject(pMapList[i]));
    }

    return pList;
  }

  Province getProv(int value, List<Province> list) {
    Province prov;

    switch (value) {
      case 1:
        prov = list[0];
        break;
      case 2:
        prov = list[1];
        break;
      case 3:
        prov = list[2];
        break;
      case 4:
        prov = list[3];
        break;
      case 5:
        prov = list[4];
        break;
      case 6:
        prov = list[5];
        break;
      case 7:
        prov = list[6];
        break;
      case 8:
        prov = list[7];
        break;
      case 9:
        prov = list[8];
        break;
      case 10:
        prov = list[9];
        break;
      case 11:
        prov = list[10];
        break;
      case 12:
        prov = list[11];
        break;
      case 13:
        prov = list[12];
        break;
      case 14:
        prov = list[13];
        break;
      case 15:
        prov = list[14];
        break;
      case 16:
        prov = list[15];
        break;
      case 17:
        prov = list[16];
        break;
      case 18:
        prov = list[17];
        break;
      case 19:
        prov = list[18];
        break;
      case 20:
        prov = list[19];
        break;
      case 21:
        prov = list[20];
        break;
    }
    return prov;
  }
}
