import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }
  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences? _preferences;
  static LocaleManager get instance => _instance;
  static Future preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  // Todo: setStringList

  Future<void> setBoolValue(SharedKeys key, bool value) async {
    await _preferences!.setBool(key.toString(), value);
  }

  bool getBoolValue(SharedKeys key) => _preferences!.getBool(key.toString()) ?? false;
}
