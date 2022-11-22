import 'package:flutter/foundation.dart' show immutable;

@immutable
class Weather {
  const Weather({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weatherCondition: json['weather_condition'] as String,
      maxTemperature: json['max_temperature'] as int,
      minTemperature: json['min_temperature'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  final String weatherCondition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
