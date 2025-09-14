import 'package:b1_first_flutter_app/model/weather/weather.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../service/weather_api_v2.dart';

class WeatherRepository {
  final WeatherApi _weatherApi;
  final API_KEY = dotenv.env['WEATHER_API_KEY']!;

  WeatherRepository(Dio dio) : _weatherApi = WeatherApi(dio);

  Future<Weather> getWeather(String query) async {
    try {
      return await _weatherApi.fetchWeather(
        query,
        "vn",
        API_KEY,
      );
    } catch (e, stack) {
      print("Error when fetching weather: $e");
      print(stack);
      rethrow;
    }
  }
}
