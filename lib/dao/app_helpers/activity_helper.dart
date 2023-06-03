import 'dart:async';
import 'package:mobile4us_new_version/dao/database_helper.dart';
import 'package:mobile4us_new_version/models/activity.dart';
import 'package:sqflite/sqflite.dart';

class ActivityHelper {
  DatabaseHelper con = new DatabaseHelper();

  // Fetch Operation: Get all User objects from database
  Future<List<Map<String, dynamic>>> getActivityMapList() async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery('SELECT id, Name FROM TB_ACTOR_ACTIVITY');
    return result;
  }

  // Insert Operation: Insert a User object to database
  Future<int> insertActivity(Activity activity) async {
    var dbClient = await con.db;
    var result = await dbClient.insert("TB_ACTOR_ACTIVITY", activity.toMap());
    return result;
  }

  // Update Operation: Update a User object and save it to database
  Future<int> updateActivity(Activity activity) async {
    var dbClient = await con.db;
    var result = await dbClient.update("TB_ACTOR_ACTIVITY", activity.toMap(), where: 'id = ?', whereArgs: [activity.id]);
    return result;
  }

  // Delete Operation: Delete a User object from database
  Future<int> deleteActivity(int id) async {
    var dbClient = await con.db;
    int result = await dbClient.rawDelete('DELETE FROM TB_ACTOR_ACTIVITY WHERE id = $id');
    return result;
  }

  // Get number of User objects in database
  Future<int> getCount() async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery('SELECT COUNT (*) from TB_ACTOR_ACTIVITY');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Activity>> getActivityList() async {

    var activityMapList = await getActivityMapList();
    int count = activityMapList.length;

    // ignore: deprecated_member_use
    List<Activity> activityList = List<Activity>();

    for (int i = 0; i < count; i++) {
      activityList.add(Activity.fromMapObject(activityMapList[i]));
    }

    return activityList;
  }

  Activity getActivity(int value, List<Activity> list) {
    Activity activity;

    switch (value) {
      case 1:
        activity = list[0];
        break;
      case 2:
        activity = list[1];
        break;
      case 3:
        activity = list[2];
        break;
      case 4:
        activity = list[3];
        break;
      case 5:
        activity = list[4];
        break;
      case 6:
        activity = list[5];
        break;
      case 7:
        activity = list[6];
        break;
      case 8:
        activity = list[7];
        break;
      case 9:
        activity = list[8];
        break;
      case 10:
        activity = list[9];
        break;
      case 11:
        activity = list[10];
        break;
      case 12:
        activity = list[11];
        break;
      case 13:
        activity = list[12];
        break;
      case 14:
        activity = list[13];
        break;
      case 15:
        activity = list[14];
        break;
      case 16:
        activity = list[15];
        break;
      case 17:
        activity = list[16];
        break;
      case 18:
        activity = list[17];
        break;
      case 19:
        activity = list[18];
        break;
      case 20:
        activity = list[19];
        break;
      case 21:
        activity = list[20];
        break;
    }
    return activity;
  }

  Future<int> checkActivity(int value) async {
    var dbClient = await con.db;
    List<Map<String, dynamic>> x = await dbClient.rawQuery(
        "SELECT COUNT(*) FROM TB_ACTOR_ACTIVITY WHERE id=$value");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

}
