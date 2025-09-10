import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:b1_first_flutter_app/data/model/weather/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String WEATHER_URL = 'https://api.weatherapi.com/v1/current.json';
  static final API_KEY = dotenv.env['WEATHER_API_KEY']!;

  static Future<Weather> fetchWeather(String query ) async{
    try {
      final response = await http.get(Uri.parse('$WEATHER_URL?q=$query&lang=vn&key=$API_KEY'));
      switch(response.statusCode){
        case 200:
          return Weather.fromJson(jsonDecode(response.body) as Map <String, dynamic>);
        case  _: 
          print('Status code: ${response.statusCode}');
          print('Body: ${response.body}');
          throw Exception('Failed to load weather');
      }
    } catch (e, stack) {
      print('Error when fetching weather: $e');
      print(stack);
      rethrow; // cho FutureBuilder vẫn nhận được error
    }
  }
}