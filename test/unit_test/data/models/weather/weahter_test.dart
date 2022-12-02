import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/weather/weather.dart';

const weatherData = '''
{
  "weather_condition":"cloudy",
  "max_temperature":25,"min_temperature":7,
  "date":"2020-04-01T12:00:00+09:00"
}
''';
void main() {
  test(
    'fromJson of Weather',
    () {
      final json = jsonDecode(weatherData) as Map<String, dynamic>;
      final weather = Weather.fromJson(json);

      expect(weather.weatherCondition, WeatherCondition.cloudy);
      expect(weather.maxTemperature, 25);
      expect(weather.minTemperature, 7);
      expect(weather.date, DateTime.parse('2020-04-01T12:00:00+09:00'));
    },
  );
}
