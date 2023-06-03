class FamilyResources {

  int _id;
  String _familyresources;

  FamilyResources(this._familyresources);

  FamilyResources.withId(
      this._id,
      this._familyresources);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _familyresources;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._familyresources = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _familyresources;

    return map;
  }

  FamilyResources.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._familyresources = map['Name'];
  }

  FamilyResources.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._familyresources = json['Name'];
    }
}