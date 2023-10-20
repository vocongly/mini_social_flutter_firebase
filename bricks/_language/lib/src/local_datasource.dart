import 'package:shared_preferences/shared_preferences.dart';

const String _languageCode = "languageCode";

abstract class LocalDatasourceInterface {
  saveLanguageCode(String? languageCode);

  Future<String?> getLanguageCode();

  removeLanguageCode();
}

class LocalDatasource implements LocalDatasourceInterface {
  @override
  saveLanguageCode(String? languageCode) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (languageCode == null) {
      await removeLanguageCode();
    } else {
      await instance.setString(_languageCode, languageCode);
    }
  }

  @override
  Future<String?> getLanguageCode() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(_languageCode);
  }

  @override
  removeLanguageCode() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove(_languageCode);
  }
}
