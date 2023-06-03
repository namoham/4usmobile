class PovertyDegree {

  int _id;
  String _povertyDegree;

  PovertyDegree(this._povertyDegree);

  PovertyDegree.withId(
      this._id,
      this._povertyDegree);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _povertyDegree;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._povertyDegree = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _povertyDegree;

    return map;
  }

  PovertyDegree.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._povertyDegree = map['Name'];
  }

  PovertyDegree.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._povertyDegree = json['Name'];
  }
}