// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      lastUpdated: DateTime.parse(json['last_updated'] as String),
      tempC: (json['temp_c'] as num).toDouble(),
      tempF: (json['temp_f'] as num).toDouble(),
      cloudy: (json['cloud'] as num).toInt(),
      condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
      humidity: (json['humidity'] as num).toInt(),
      precipitation: (json['precip_mm'] as num).toDouble(),
      windDegree: (json['wind_degree'] as num).toInt(),
    );
