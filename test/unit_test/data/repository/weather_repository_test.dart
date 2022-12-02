import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/app_exception.dart';
import 'package:flutter_training/data/data_source/weather_data_source.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  const defaultRequest = WeatherRequest();
  final json = defaultRequest.toJson();
  final jsonString = jsonEncode(json);
  group(
    'getWeather of WeatherRepository',
    () {
      test(
        'fetchWeather が成功すると AppApiResult<Weather> を返す',
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

          final actual =
              WeatherRepository(dataSource).getWeather(request: defaultRequest);
          final expected = isA<AppApiResult<Weather>>();

          expect(
            actual,
            expected,
          );
        },
      );

      test(
        '''
        fetchWeather が例外を発生させると AppApiResult.failure(message:Strings.unknown)を返す
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

          Object actual;
          try {
            actual = WeatherRepository(dataSource)
                .getWeather(request: defaultRequest);
          } on AppException catch (error) {
            actual = error;
          }

          const expected = AppApiResult<Weather>.failure(
            message: Strings.unknownError,
          );

          expect(
            actual,
            expected,
          );
        },
      );

      test(
        '''
        パラメータが無効な場合、 AppApiResult.failure(message:Strings.invalidParameterError)を返す
        ''',
        () {
          final dataSource = WeatherDataSource(YumemiWeather());
          const invalidedRequest = WeatherRequest(date: 'invalid Parameter');

          Object actual;
          try {
            actual = actual = WeatherRepository(dataSource)
                .getWeather(request: invalidedRequest);
          } on AppException catch (error) {
            actual = error;
          }

          const expected = AppApiResult<Weather>.failure(
            message: Strings.invalidParameterError,
          );

          expect(
            actual,
            expected,
          );
        },
      );
    },
  );
}
