class Identity {

  int _id;
  String _identity;

  Identity(this._identity);

  Identity.withId(
      this._id,
      this._identity);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _identity;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._identity = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _identity;

    return map;
  }

  Identity.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._identity = map['Name'];
  }

  Identity.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._identity = json['Name'];
  }
}