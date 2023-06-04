class ApiError {
  String _error;

  ApiError({String error}) {
    this._error = error;
  }

  // ignore: unnecessary_getters_setters
  String get error => _error;
  // ignore: unnecessary_getters_setters
  set error(String error) => _error = error;

  ApiError.fromJson(Map<String, dynamic> json) {
    _error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this._error;
    return data;
  }
}