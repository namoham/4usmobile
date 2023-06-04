

import 'package:mobile4us_new_version/dao/database_helper.dart';

class ChartData {

  int _id;
  String _key;
  int _value;
  String _percentage;
  String _color;

  ChartData(this._key, this._value, this._percentage, this._color);

  ChartData.withId(
      this._id,
      this._key,
      this._value,
      this._percentage,
      this._color);

  int get id => _id;

  String get key => _key;

  int get value => _value;

  String get percentage => _percentage;

  String get color => _color;

  set key(String newKey) {
      this._key = newKey;
  }

  set value(int newValue) {
      this._value = newValue;
  }

  set percentage(String newPercentage) {
    this._percentage = newPercentage;
  }

  set color(String newColor) {
    this._color = newColor;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['key'] = _key;
    map['value'] = _value;
    map['percentage'] = _percentage;
    map['color'] = _color;
    return map;
  }

  ChartData.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._key = map['key'];
    this._value = map['value'];
    this._percentage = map['percentage'];
    this._color = map['color'];
  }
}


class ChartDataHelper {
  DatabaseHelper con = new DatabaseHelper();

  Future<List<Map<String, dynamic>>> getMapList(String chartQuery) async {
    var dbClient = await con.db;
    var result = await dbClient.rawQuery(chartQuery);
    return result;
  }

  Future<List<ChartData>> getList(String chartQuery) async {

    var userMapList = await getMapList(chartQuery);
    int count = userMapList.length;

    List<ChartData> userList = <ChartData>[];

    for (int i = 0; i < count; i++) {
      userList.add(ChartData.fromMapObject(userMapList[i]));
    }
    return userList;
  }
}
