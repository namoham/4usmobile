import 'dart:async';
import 'package:mobile4us_new_version/dao/app_helpers/user_helper.dart';
import 'package:mobile4us_new_version/models/user.dart';

class LoginRequest {
  UserHelper con = new UserHelper();

  Future<User> getLogin(String username, String password) {
    var result = con.getLogin(username,password);
    return result;
  }
}


