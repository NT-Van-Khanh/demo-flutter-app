import 'package:dio/dio.dart';
import '../model/weather/weather.dart';
import '../service/weather_api_v2.dart';

class WeatherRepository {
  final WeatherApi _weatherApi;

  WeatherRepository(Dio dio)
      : _weatherApi = WeatherApi(dio);

  Future<Weather> getWeather(String query) async {
    try {
      return await _weatherApi.fetchWeather(
        query,
        "vn",
        "key",
      );
    } catch (e, stack) {
      print("Error when fetching weather: $e");
      print(stack);
      rethrow;
    }
  }
}
