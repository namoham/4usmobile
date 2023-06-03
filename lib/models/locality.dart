class Locality {

  int _id;
  int _provinceId;
  String _locality;

  Locality(this._locality, this._provinceId);

  Locality.withId(
      this._id,
      this._locality,
      this._provinceId);

  int get id => _id;

  int get provinceId => _provinceId;

  // ignore: non_constant_identifier_names
  String get Name => _locality;

  set provinceId(int newProvinceId) {
    if (newProvinceId >= 1 && newProvinceId <= 24) {
      this._provinceId = newProvinceId;
    }
  }

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._locality = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['provinceId'] = _provinceId;
    map['Name'] = _locality;

    return map;
  }

  Locality.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._locality = map['Name'];
    this._provinceId = map['regionId'];
  }

  Locality.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._provinceId = json['provinceId'];
    this._locality = json['Name'];
  }
}