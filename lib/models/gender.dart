class Gender {

  int _id;
  String _gender;

  Gender(this._gender);

  Gender.withId(
      this._id,
      this._gender);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _gender;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._gender = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _gender;

    return map;
  }

  Gender.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._gender = map['Name'];
  }

  Gender.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._gender = json['Name'];
  }
}
