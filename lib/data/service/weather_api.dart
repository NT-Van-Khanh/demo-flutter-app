import 'dart:convert';

import 'package:b1_first_flutter_app/data/model/weather/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static Future<Weather> featchWeather(String querry ) async{
    try {
      final response = await http.get(Uri.parse('https://api.weatherapi.com/v1/current.json?q=$querry&lang=vn&key=6e315b8d662e47e8b2165112250804'));
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
      rethrow; // để FutureBuilder vẫn nhận được error
    }
  }
}