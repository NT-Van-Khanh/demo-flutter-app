
import 'package:json_annotation/json_annotation.dart';
part 'condition.g.dart';

@JsonSerializable(createToJson: false)
class Condition {

  @JsonKey(name: 'text')
  final String text;

  @JsonKey(name: 'icon')
  final String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json)=> _$ConditionFromJson(json);
}