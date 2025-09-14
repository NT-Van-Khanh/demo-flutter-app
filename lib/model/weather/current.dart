import 'package:b1_first_flutter_app/model/weather/condition.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current.g.dart';

@JsonSerializable(createToJson: false)
class Current {

    @JsonKey(name: 'last_updated')
  final DateTime lastUpdated;

  @JsonKey(name: 'temp_c')
  final double tempC;

  @JsonKey(name: 'temp_f')
  final double tempF;

  @JsonKey(name: 'cloud')
  final int cloudy;

  @JsonKey(name: 'condition')
  final Condition condition;

  @JsonKey(name: 'humidity')
  final int humidity;

  @JsonKey(name: 'precip_mm')
  final double precipitation;

  @JsonKey(name: 'wind_degree')
  final int windDegree;
   
  Current({
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.cloudy,
    required this.condition,
    required this.humidity,
    required this.precipitation,
    required this.windDegree,
  });

  factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);
}
  
