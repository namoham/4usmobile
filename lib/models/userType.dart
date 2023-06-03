class UserType {

  int _id;
  String _userType;

  UserType(this._userType);

  UserType.withId(
      this._id,
      this._userType);

  int get id => _id;

  String get Name => _userType;

  set Name(String newName) {
    if (newName.length <= 255) {
      this._userType = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _userType;

    return map;
  }

  UserType.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userType = map['Name'];
  }

  UserType.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._userType = json['Name'];
  }
}