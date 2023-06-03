class Parameters {

  int _id;
  String _key;
  String _value;

  Parameters(this._key, this._value);

  Parameters.withId(
      this._id,
      this._key,
      this._value);

  int get id => _id;

  String get key => _key;

  String get value => _value;

  set key(String newKey) {
    if (newKey.length <= 255) {
      this._key = newKey;
    }
  }

  set value(String newValue) {
    if (newValue.length <= 255) {
      this._value = newValue;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['key'] = _key;
    map['value'] = _value;

    return map;
  }

  Parameters.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._key = map['key'];
    this._value = map['value'];
  }

  Parameters.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._key = json['key'];
    this._value = json['value'];
  }
}