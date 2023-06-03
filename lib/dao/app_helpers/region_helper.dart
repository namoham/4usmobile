import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/region.dart';
import 'package:sqflite/sqflite.dart';

class RegionHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getRegionMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_REGION');
    return result;
  }

  Future<int> insertRegion(Region region) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_REGION", region.toMap());
    return result;
  }

  Future<int> updateRegion(Region region) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_REGION", region.toMap(), where: 'id = ?', whereArgs: [region.id]);
    return result;
  }

  Future<int> deleteRegion(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_REGION WHERE id = $id');
    return result;
  }

  Future<int> checkRegion(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_REGION WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_REGION');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Region>> getRegionList() async {

    var regionMapList = await getRegionMapList();
    int count = regionMapList.length;

    // ignore: deprecated_member_use
    List<Region> regionList = List<Region>();

    for (int i = 0; i < count; i++) {
      regionList.add(Region.fromMapObject(regionMapList[i]));
    }

    return regionList;
  }

  Region getReg(int value, List<Region> list) {
    Region reg;

    switch (value) {
      case 1:
        reg = list[0];
        break;
      case 2:
        reg = list[1];
        break;
      case 3:
        reg = list[2];
        break;
      case 4:
        reg = list[3];
        break;
      case 5:
        reg = list[4];
        break;
      case 6:
        reg = list[5];
        break;
      case 7:
        reg = list[6];
        break;
      case 8:
        reg = list[7];
        break;
      case 9:
        reg = list[8];
        break;
      case 10:
        reg = list[9];
        break;
      case 11:
        reg = list[10];
        break;
      case 12:
        reg = list[11];
        break;
      case 13:
        reg = list[12];
        break;
      case 14:
        reg = list[13];
        break;
      case 15:
        reg = list[14];
        break;
      case 16:
        reg = list[15];
        break;
      case 17:
        reg = list[16];
        break;
      case 18:
        reg = list[17];
        break;
      case 19:
        reg = list[18];
        break;
      case 20:
        reg = list[19];
        break;
      case 21:
        reg = list[20];
        break;
      case 22:
        reg = list[21];
        break;
      case 23:
        reg = list[22];
        break;
      case 24:
        reg = list[23];
        break;
    }
    return reg;
  }
}
