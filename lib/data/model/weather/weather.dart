import 'package:b1_first_flutter_app/data/model/weather/current.dart';
import 'package:b1_first_flutter_app/data/model/weather/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(createToJson: false)
class Weather {
  @JsonKey(name: 'location', fromJson: Location.fromJson)
  final Location location;
  @JsonKey(name: 'current', fromJson: Current.fromJson)
  final Current current;
  
  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  const Weather({
    required this.location,
    required this.current,
  });
}

  // factory Weather.fromJson(Map<String, dynamic> json){
  //   return switch(json){
  //     {
  //       'location': Location location,
  //       'last_updated': DateTime lastUpdated,
  //       'temp_c': double tempC,
  //       'temp_f': double tempF,
  //       'cloudy': double cloudy,
  //       'condition.text': String conditionText,
  //       'condition.icon': String conditionIconLink,
  //       'humidity': double humidity,
  //       'precip_mm': double precipitation,
  //       'wind_degree': double windDegree,
  //     }=> Weather(
  //         location: location, 
  //         lastUpdated: lastUpdated, 
  //         tempC: tempC, 
  //         tempF: tempF, 
  //         cloudy: cloudy, 
  //         conditionText: conditionText, 
  //         conditionIconLink: conditionIconLink, 
  //         humidity: humidity, 
  //         precipitation: precipitation, 
  //         windDegree: windDegree),
  //         _ => throw const FormatException("Fail to convert JSON to Object")
  //   };
  // }
// }
