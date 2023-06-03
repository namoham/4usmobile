class FamilySituation {

  int _id;
  String _familySituation;

  FamilySituation(this._familySituation);

  FamilySituation.withId(
      this._id,
      this._familySituation);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _familySituation;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._familySituation = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _familySituation;

    return map;
  }

  FamilySituation.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._familySituation = map['Name'];
  }

  FamilySituation.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._familySituation = json['Name'];
  }
}