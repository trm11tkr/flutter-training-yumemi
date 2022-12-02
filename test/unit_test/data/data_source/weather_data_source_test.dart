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
        'fetchWeather が成功すると Weather を返す',
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

          expect(
            dataSource.getWeather(request: defaultRequest),
            isA<Weather>(),
          );
        },
      );

      test(
        'fetchWeatherが 例外を発生させると YumemiWeatherError.unknown を返し、AppErrorに変換する',
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
          const expected = AppException.unknown(
            message: Strings.unknownError,
          );

          try {
            act = dataSource.getWeather(request: defaultRequest);
          } on AppException catch (error) {
            act = error;
          }

          expect(
            act,
            expected,
          );
        },
      );

      test(
        'パラメータが無効な場合、 YumemiWeatherError.invalidParameter を返し、AppErrorに変換する',
        () {
          final dataSource = WeatherDataSource(YumemiWeather());
          const invalidedRequest = WeatherRequest(date: 'invalid Parameter');
          Object act;
          const expected = AppException.invalidParameter(
            message: Strings.invalidParameterError,
          );

          try {
            act = dataSource.getWeather(request: invalidedRequest);
          } on AppException catch (error) {
            act = error;
          }

          expect(
            act,
            expected,
          );
        },
      );
    },
  );
}
