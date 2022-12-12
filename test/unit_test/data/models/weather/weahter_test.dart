// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/weather/weather.dart';

import 'fixture/weather_fixture.dart';

void main() {
  test(
    'fromJson of Weather',
    () {
      final weathersWithJsonArray =
          WeatherFixtureFactory().makeManyWithJsonArray(10);
      for (final weathersWithJson in weathersWithJsonArray) {
        final act = Weather.fromJson(weathersWithJson.json);
        final expected = weathersWithJson.object;
        expect(act, expected);
      }
    },
  );
}
