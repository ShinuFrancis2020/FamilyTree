import 'package:family_tree_app/helper/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static setToken(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static setUserId(var uId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uId', uId);
  }

  static getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uId');
  }

  static clearAll() async {
    final sharedPreferences = await Helper.locaStorageInst();
    for (String key in sharedPreferences.getKeys()) {
      sharedPreferences.remove(key);
    }
  }

  // static setLevel(var level) async {
  //    final sharedPreferences = await Helper.locaStorageInst();
  //   sharedPreferences.setString(LoginScreen.LOGIN_PAGE, level);
  // }

  // static getLevel() async {
  //  final sharedPreferences = await Helper.locaStorageInst();
  //   return sharedPreferences.getString(LoginScreen.LOGIN_PAGE);
  // }
}
