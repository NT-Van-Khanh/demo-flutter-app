import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/weather/weather.dart';

part 'weather_api_v2.g.dart';

@RestApi(baseUrl: "https://api.weatherapi.com/v1")
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl, ParseErrorLogger? errorLogger,}) = _WeatherApi;

  @GET("/current.json")
  Future<Weather> fetchWeather(
    @Query("q") String query,
    @Query("lang") String lang,
    @Query("key") String apiKey,
  );
}
