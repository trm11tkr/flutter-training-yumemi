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
      final act = Weather.fromJson(json);
      final expected = Weather(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 25,
        minTemperature: 7,
        date: DateTime.parse('2020-04-01T12:00:00+09:00'),
      );
      expect(act, expected);
    },
  );
}
