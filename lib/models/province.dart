class Province {

  int _id;
  int _regionId;
  String _province;

  Province(this._province, this._regionId);

  Province.withId(
      this._id,
      this._province,
      this._regionId);

  int get id => _id;

  int get regionId => _regionId;

  // ignore: non_constant_identifier_names
  String get Name => _province;

  set regionId(int newRegionId) {
    if (newRegionId >= 1 && newRegionId <= 24) {
      this._regionId = newRegionId;
    }
  }

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._province = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['regionId'] = _regionId;
    map['Name'] = _province;

    return map;
  }

  Province.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._province = map['Name'];
    this._regionId = map['regionId'];
  }

  Province.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._regionId = json['regionId'];
    this._province = json['Name'];
  }
}