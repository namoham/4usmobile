class ApiResponse {
  // _data will hold any response converted into
  // its own object. For example user.
  Object _data;
  // _apiError will hold the error object
  Object _apiError;

  // ignore: unnecessary_getters_setters, non_constant_identifier_names
  Object get Data => _data;
  // ignore: unnecessary_getters_setters, non_constant_identifier_names
  set Data(Object data) => _data = data;

  // ignore: unnecessary_getters_setters, non_constant_identifier_names
  Object get ApiError => _apiError;
  // ignore: unnecessary_getters_setters, non_constant_identifier_names
  set ApiError(Object error) => _apiError = error;
}