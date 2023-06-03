class Region {

  int _id;
  String _region;

  Region(this._region);

  Region.withId(
      this._id,
      this._region);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _region;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._region = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _region;

    return map;
  }

  Region.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._region = map['Name'];
  }

  Region.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._region = json['Name'];
  }
}