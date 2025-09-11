import 'package:b1_first_flutter_app/data/model/weather/weather.dart';
import 'package:flutter/material.dart';

class WeatherState extends ChangeNotifier{
  Weather? _currentWeather;    
  List<Weather> _weathers = <Weather>[];
  String _weatherQuery = "Ho Chi Minh";

  Weather? get currentWeather => _currentWeather;
  List<Weather> get weathers => _weathers;
  String get weatherQuery => _weatherQuery;

  void addSearchHistory(){
    if(currentWeather == null) return;
      _weathers.insert(0, _currentWeather!);
      if(_weathers.length>10) _weathers.removeLast();
      notifyListeners();
    }
  
  void setCurrentWeather(Weather weather) {
    _currentWeather = weather;
    notifyListeners();
  }

  void setWeatherQuery(String query){
    _weatherQuery = query;
    notifyListeners();
  }
}