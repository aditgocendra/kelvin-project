import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  Future createCache(String username, String role) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', username);
    pref.setString('role', role);
  }

  Future readCache() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final username = pref.getString('username');
    final role = pref.getString('role');

    return [
      username,
      role,
    ];
  }

  Future removeCache() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('username');
  }
}
