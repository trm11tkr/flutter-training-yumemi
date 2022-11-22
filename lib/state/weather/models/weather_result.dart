import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_result.freezed.dart';
part 'weather_result.g.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
}

@freezed
class WeatherResult with _$WeatherResult {
  const factory WeatherResult({
    required WeatherCondition weatherCondition,
    required int maxTemperature,
    required int minTemperature,
    required DateTime date,
  }) = _WeatherResult;

  factory WeatherResult.fromJson(Map<String, dynamic> json) =>
      _$WeatherResultFromJson(json);
}
