import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKeys { defaultVaultPath }

abstract interface class SharedConfig {
  Future<void> setDefaultVaultPath(String path);
  Future<void> removeDefaultVaultPath();
  Future<String?> defaultVaultPath();
}

class SharedConfigImpl implements SharedConfig {
  final SharedPreferencesAsync prefs;
  SharedConfigImpl(this.prefs);

  @override
  Future<void> setDefaultVaultPath(String path) async {
    return await prefs.setString(PreferenceKeys.defaultVaultPath.name, path);
  }

  @override
  Future<void> removeDefaultVaultPath() async {
    return await prefs.remove(PreferenceKeys.defaultVaultPath.name);
  }

  @override
  Future<String?> defaultVaultPath() async {
    return await prefs.getString(PreferenceKeys.defaultVaultPath.name);
  }
}
