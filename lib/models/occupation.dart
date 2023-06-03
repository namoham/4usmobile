class Occupation {

  int _id;
  String _typeOccupation;

  Occupation(this._typeOccupation);

  Occupation.withId(
      this._id,
      this._typeOccupation);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _typeOccupation;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._typeOccupation = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _typeOccupation;

    return map;
  }

  Occupation.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._typeOccupation = map['Name'];
  }

  Occupation.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._typeOccupation = json['Name'];
  }
}