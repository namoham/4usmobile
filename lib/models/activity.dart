class Activity {

  int _id;
  String _activity;

  Activity(this._activity);

  Activity.withId(
      this._id,
      this._activity);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _activity;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._activity = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _activity;

    return map;
  }

  Activity.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._activity = map['Name'];
  }

  Activity.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._activity = json['Name'];
  }
}