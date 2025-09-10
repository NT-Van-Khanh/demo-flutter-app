import 'package:b1_first_flutter_app/data/enum/app_theme_mode.dart';
import 'package:b1_first_flutter_app/data/enum/language.dart';
import 'package:b1_first_flutter_app/data/local/language_prefs.dart';
import 'package:b1_first_flutter_app/data/local/theme_prefs.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
class MyAppState extends ChangeNotifier {
  AppThemeMode _appThemeMode = AppThemeMode.LIGHT_MODE;
  Locale _locale = const Locale('vi');

  GlobalKey? historyListKey;
  var current = WordPair.random();

  var histories = <WordPair>[];
  var favorites = <WordPair>[];
  
  Locale get locale => _locale;
  AppThemeMode get appThemeMode => _appThemeMode;


  void getNext() {
    histories.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite([WordPair? pair]){
    pair = pair ?? current;
    if(favorites.contains(pair)){
      favorites.remove(pair);
    }else{
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  void setThemeMode(bool isDarkMode){
    _appThemeMode = isDarkMode ? AppThemeMode.DARK_MODE : AppThemeMode.LIGHT_MODE;
    ThemePrefs().saveTheme(_appThemeMode);
    notifyListeners();
  }

  void setLocale(Language language) {
    _locale = Locale(language.value);
    LanguagePrefs().saveLanguage(language);
    notifyListeners();
  }

  Future<void> loadPrefs() async {
    _appThemeMode = await ThemePrefs().getTheme();
    _locale = Locale(await LanguagePrefs().getLanguage());
    notifyListeners();
  }
}
