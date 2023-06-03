class Nationality {

  int _id;
  String _nationality;

  Nationality(this._nationality);

  Nationality.withId(
      this._id,
      this._nationality);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _nationality;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._nationality = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _nationality;

    return map;
  }

  Nationality.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nationality = map['Name'];
  }

  Nationality.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._nationality = json['Name'];
  }
}
