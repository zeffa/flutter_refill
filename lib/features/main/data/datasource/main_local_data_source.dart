import 'package:shared_preferences/shared_preferences.dart';
import 'package:uji/core/utils/constants.dart';

abstract class MainLocalDataSource {
  Future<bool> getUserLoginStatus();
}

class MainLocalDataSourceImpl implements MainLocalDataSource {
  final SharedPreferences sharedPreferences;

  MainLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> getUserLoginStatus() {
    final jsonStr = sharedPreferences.getString(LOGIN_RESPONSE_PREFERENCE);
    return Future.value(jsonStr != null);
  }
}
