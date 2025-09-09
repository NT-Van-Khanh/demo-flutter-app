import 'package:b1_first_flutter_app/data/enum/language.dart';
import 'package:b1_first_flutter_app/data/enum/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePrefs {
  final _key = SharedPrefsKeys.LANGUAGE;
  
  Future<void> saveLanguage(Language language) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key.value, language.value);
  }
  
  Future<String> getLanguage() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key.value) ?? Language.VI.value;
  }
}