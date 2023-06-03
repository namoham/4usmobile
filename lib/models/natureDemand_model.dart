class NatureDemand {
  int _id;
  String _name;

  NatureDemand(this._name);
  NatureDemand.withId(this._id, this._name);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _name;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }

    map["Name"] = _name;
    return map;
  }

  NatureDemand.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['Name'];
  }

  NatureDemand.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._name = json['Name'];
  }
}
