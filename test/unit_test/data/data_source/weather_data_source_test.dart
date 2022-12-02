import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/app_exception.dart';
import 'package:flutter_training/data/data_source/weather_data_source.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_data_source_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  const defaultRequest = WeatherRequest();
  final json = defaultRequest.toJson();
  final jsonString = jsonEncode(json);
  group(
    'getWeather',
    () {
      test(
           '''
           On success of fetchWeather:
           return Type of Weather
           ''',
        () {
          final client = MockYumemiWeather();
          final dataSource = WeatherDataSource(client);

          when(
            client.fetchWeather(jsonString),
          ).thenAnswer(
            (_) => '''
                    {
                      "weather_condition":"cloudy",
                      "max_temperature":25,"min_temperature":7,
                      "date":"2020-04-01T12:00:00+09:00"
                    }
                   ''',
          );
          final actual = dataSource.getWeather(request: defaultRequest);
          final expected = isA<Weather>();

          expect(
            actual,
            expected,
          );
        },
      );

      test(
        '''
        When an exception occurs in fetchWeather:
        return AppException.unknownError.
        ''',
        () {
          final client = MockYumemiWeather();
          final dataSource = WeatherDataSource(client);

          when(
            client.fetchWeather(jsonString),
          ).thenAnswer(
            // ignore: only_throw_errors
            (_) => throw YumemiWeatherError.unknown,
          );

          Object act;
          try {
            act = dataSource.getWeather(request: defaultRequest);
          } on AppException catch (error) {
            act = error;
          }

          const expected = AppException.unknown(
            message: Strings.unknownError,
          );

          expect(
            act,
            expected,
          );
        },
      );

      test(
        '''
        When parameter is invalid,
        return AppException.invalidParameter.
        ''',
        () {
          final dataSource = WeatherDataSource(YumemiWeather());
          const invalidedRequest = WeatherRequest(date: 'invalid Parameter');

          Object act;
          try {
            act = dataSource.getWeather(request: invalidedRequest);
          } on AppException catch (error) {
            act = error;
          }

          const expected = AppException.invalidParameter(
            message: Strings.invalidParameterError,
          );

          expect(
            act,
            expected,
          );
        },
      );
    },
  );
}
