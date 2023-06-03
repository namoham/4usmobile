class Profession {

  int _id;
  String _profession;

  Profession(this._profession);

  Profession.withId(
      this._id,
      this._profession);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _profession;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._profession = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _profession;

    return map;
  }

  Profession.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._profession = map['Name'];
  }

  Profession.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._profession = json['Name'];
  }
}