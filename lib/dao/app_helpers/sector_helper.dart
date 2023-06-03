import 'dart:async';

import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/secctor_model.dart';
import 'package:sqflite/sqflite.dart';

class SectorHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> checkSector(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_REQUEST_SECTOR WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> insertSector(Sector sector) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_REQUEST_SECTOR",
        sector.toMap());
    return result;
  }

  Future<int> updateSector(Sector sector) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_REQUEST_SECTOR",
        sector.toMap(), where: 'id = ?', whereArgs: [sector.id]);
    return result;
  }

  Future<Sector> getId(int id) async {
    Sector demand;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_REQUEST_SECTOR WHERE id = '$id'");
    print(id);

    if (res.length > 0) {
      demand = new Sector.fromMap(res.first);
      //return user;
    }
    return demand;
//    return null;
  }

  Future<List<Map<String, dynamic>>> getSectorMapList() async {
    var dbClient = await con.db;
    var result =
        await dbClient.rawQuery("SELECT id, Name FROM TB_REQUEST_SECTOR");
    return result;
  }

  Future<List<Sector>> getSectorList() async {
    var sectorMapList =
        await getSectorMapList(); // Get 'Map List' from database
    int count =
        sectorMapList.length; // Count the number of map entries in db table

    // ignore: deprecated_member_use
    List<Sector> sectorList = List<Sector>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      sectorList.add(Sector.fromMap(sectorMapList[i]));
    }

    return sectorList;
  }

  Sector getSector(int value, List<Sector> list) {
    Sector sec;

    switch (value) {
      case 1:
        sec = list[0];
        break;
      case 2:
        sec = list[1];
        break;
      case 3:
        sec = list[2];
        break;
      case 4:
        sec = list[3];
        break;
      case 5:
        sec = list[4];
        break;
      case 6:
        sec = list[5];
        break;
      case 7:
        sec = list[6];
        break;
      case 8:
        sec = list[7];
        break;
    }
    return sec;
  }
}
