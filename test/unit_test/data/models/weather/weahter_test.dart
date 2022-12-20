// ignore_for_file: lines_longer_than_80_chars, prefer_function_declarations_over_variables

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/weather/weather.dart';

import 'fixture/weather_fixture.dart';

void main() {
  test(
    'success case: fromJson of Weather',
    () {
      final weathersWithJsonArray =
          WeatherFixture.factory().makeManyWithJsonArray(10);
      for (final weathersWithJson in weathersWithJsonArray) {
        final act = Weather.fromJson(weathersWithJson.json);
        final expected = weathersWithJson.object;
        expect(act, expected);
      }
    },
  );

  group(
    'failure cases: fromJson of Weather',
    () {
      test(
        'case: weather_condition does not exist in WeatherCondition',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'snow',
            'max_temperature': 30,
            'min_temperature': 2,
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'weather_condition must exist within WeatherCondition',
          );
        },
      );

      test(
        'case: max_temperature is type of Double',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': 24.0,
            'min_temperature': 2,
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'max_temperature must type of int',
          );
        },
      );

      test(
        'case: max_temperature is type of String',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': '20',
            'min_temperature': 2,
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'max_temperature must type of int',
          );
        },
      );

      test(
        'case: min_temperature is type of Double',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': 31,
            'min_temperature': 2.0,
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'min_temperature must type of int',
          );
        },
      );

      test(
        'case: min_temperature is type of String',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': 20,
            'min_temperature': '2',
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'min_temperature must type of int',
          );
        },
      );

      test(
        'case: date is type of int',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': 20,
            'min_temperature': 2,
            'date': 2020
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'date must type of String',
          );
        },
      );

      test(
        'case: date is type of int',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': 20,
            'min_temperature': 2,
            'date': '2020-04-0'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'date must be properly formatted',
          );
        },
      );

      test(
        'case: weather_condition is missing',
        () {
          final weatherJson = <String, dynamic>{
            'max_temperature': 20,
            'min_temperature': 2,
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'date is required.',
          );
        },
      );

      test(
        'case: max_temperature is missing',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'min_temperature': 2,
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'date is required.',
          );
        },
      );

      test(
        'case: min_temperature is missing',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': 20,
            'date': '2020-04-01T12:00:00+09:00'
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'date is required.',
          );
        },
      );

      test(
        'case: date is missing',
        () {
          final weatherJson = <String, dynamic>{
            'weather_condition': 'sunny',
            'max_temperature': 20,
            'min_temperature': 2
          };
          final act = () {
            Weather.fromJson(weatherJson);
          };
          const expected = throwsException;
          expect(
            act,
            expected,
            reason: 'date is required.',
          );
        },
      );
    },
  );
}
