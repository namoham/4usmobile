class StudyLevel {

  int _id;
  String _studyLevel;

  StudyLevel(this._studyLevel);

  StudyLevel.withId(
      this._id,
      this._studyLevel);

  int get id => _id;

  // ignore: non_constant_identifier_names
  String get Name => _studyLevel;

  // ignore: non_constant_identifier_names
  set Name(String newName) {
    if (newName.length <= 255) {
      this._studyLevel = newName;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['Name'] = _studyLevel;

    return map;
  }

  StudyLevel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._studyLevel = map['Name'];
  }

  StudyLevel.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._studyLevel = json['Name'];
  }
}