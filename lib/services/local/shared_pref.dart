import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  Future createCache(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', username);
  }

  Future readCache() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final username = pref.getString('username');

    return username;
  }

  Future removeCache() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('username');
    pref.remove('isLoggedIn');
  }
}
