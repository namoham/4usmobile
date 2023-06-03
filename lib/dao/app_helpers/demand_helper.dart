import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/demand_model.dart';
import 'package:sqflite/sqflite.dart';

class DemandHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> checkDemand(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_FINANCING_REQUEST WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<Demand> getId(int id) async {
    Demand dem;
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM TB_FINANCING_REQUEST WHERE id = '$id'");

    if (res.length > 0) {
      dem = new Demand.fromMapObject(res.first);
      //return user;
    } else {
      dem = null;
    }
    return dem;
//    return null;
  }

//insertion
  Future<int> insertDemand(Demand demand) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("TB_FINANCING_REQUEST", demand.toMap());
    return res;
  }

  //deletion
  Future<int> delete(Demand demand) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("TB_FINANCING_REQUEST");
    return res;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getDemandMapList() async {
    var dbClient = await con.db;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await dbClient.query("TB_FINANCING_REQUEST");
    return result;
  }


  Future<List<Map<String, dynamic>>> search(String text) async {
    var dbClient = await con.db;

    var result = await dbClient.rawQuery(
        "SELECT * FROM TB_FINANCING_REQUEST WHERE designation LIKE '%$text%' OR  description LIKE '%$text%'");
    return result;
  }


  // Update Operation: Update a Note object and save it to database
  Future<int> updateDemand(Demand demand) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_FINANCING_REQUEST", demand.toMap(),
        where: 'id = ?', whereArgs: [demand.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteDemand(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_FINANCING_REQUEST WHERE id = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_FINANCING_REQUEST');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Demand>> getList() async {

    var demandMapList = await getDemandMapList(); // Get 'Map List' from database
    int count = demandMapList.length;         // Count the number of map entries in db table

    // ignore: deprecated_member_use
    List<Demand> demandList = List<Demand>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      demandList.add(Demand.fromMapObject(demandMapList[i]));
    }

    return demandList;
  }

  Future<List<Map<String, dynamic>>> getSyncDemandMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery("SELECT * FROM TB_FINANCING_REQUEST WHERE isSend = '1' AND synch != '1'");
    return result;
  }

  Future<List<Demand>> getSyncDemandList() async {

    var demandMapList = await getSyncDemandMapList();
    int count = demandMapList.length;

    // ignore: deprecated_member_use
    List<Demand> demandList = List<Demand>();

    for (int i = 0; i < count; i++) {
      demandList.add(Demand.fromMapObject(demandMapList[i]));
    }

    return demandList;
  }

}
