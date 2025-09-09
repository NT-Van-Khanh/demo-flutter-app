import 'package:b1_first_flutter_app/data/enum/shared_prefs_keys.dart';
import 'package:b1_first_flutter_app/data/enum/app_theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefs {
  final String _key = SharedPrefsKeys.THEME_MODE.value;
  
  Future<void> saveTheme(AppThemeMode themeMode) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, themeMode.isDarkMode);
  }

  Future<AppThemeMode> getTheme() async{
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool(_key) ?? false;
    return isDark ? AppThemeMode.DARK_MODE : AppThemeMode.LIGHT_MODE;
  }
}