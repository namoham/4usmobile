class DelayLevel {

  int _id;
  String _name;
  String _codeColor;

  DelayLevel(this._name, this._codeColor);

  DelayLevel.withId(
      this._id,
      this._name,
      this._codeColor);

  int get id => _id;

  String get name => _name;

  String get colorCode => _codeColor;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }
  set colorCode(String newColor) {
    if (newColor.length <= 255) {
      this._codeColor = newColor;
    }
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['colorCode'] = _codeColor;

    return map;
  }

  DelayLevel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._codeColor = map['colorCode'];
  }

  DelayLevel.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._name = json['name'];
    this._codeColor = json['colorCode'];
  }

}