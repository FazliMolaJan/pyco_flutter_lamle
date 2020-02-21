import 'dart:convert';

import 'package:demo/models/parent_user_model.dart';
import 'package:demo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPrefService _instance = new SharedPrefService.internal();
  SharedPrefService.internal();
  factory SharedPrefService() => _instance;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //TOKEN
  Future<String> getAuthToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(Constants.bCacheAuthKey) ?? '';
  }

  Future<bool> saveAuthToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(Constants.bCacheAuthKey, token);
  }

  /// ----------------------------------------------------------
  //LIST USER
  /// ----------------------------------------------------------
  Future<List<ParentUserModel>> getListUser() async {
    final SharedPreferences prefs = await _prefs;
    var data = prefs.get(Constants.bOffLineUser);
    var list = List<ParentUserModel>();
    if (data != null) {
      var map = jsonDecode(data);
      list = (map as List)
          .map((i) => new ParentUserModel.fromJson(i))
          .toList();
    }
    return list;
  }

  /// ----------------------------------------------------------
  Future<bool> saveListUser(List<ParentUserModel> list) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(Constants.bOffLineUser, json.encode(list));
  }
}
