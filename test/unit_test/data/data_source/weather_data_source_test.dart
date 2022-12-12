// ignore_for_file: prefer_function_declarations_over_variables

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
  final defaultRequest = WeatherRequest(
    date: DateTime.now(),
  );
  final client = MockYumemiWeather();
  final dataSource = WeatherDataSource(client);
  group(
    'getWeather',
    () {
      test(
        '''
           On success of fetchWeather:
           return Type of Weather
           ''',
        () {
          when(
            client.fetchWeather(any),
          ).thenReturn(
            '''
            {
              "weather_condition":"cloudy",
              "max_temperature":25,"min_temperature":7,
              "date":"2020-04-01T12:00:00+09:00"
            }
            ''',
          );
          final act = dataSource.getWeather(request: defaultRequest);
          final expected = isA<Weather>();

          expect(
            act,
            expected,
          );
        },
      );

      test(
        '''
        When an exception occurs in fetchWeather:
        throw AppException.unknownError.
        ''',
        () {
          when(
            client.fetchWeather(any),
          ).thenThrow(
            YumemiWeatherError.unknown,
          );
          final act = () {
            dataSource.getWeather(request: defaultRequest);
          };

          final expected = throwsA(
            const AppException.unknown(
              message: Strings.unknownError,
            ),
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
        throw AppException.invalidParameter.
        ''',
        () {
          when(
            client.fetchWeather(any),
          ).thenThrow(
            YumemiWeatherError.invalidParameter,
          );

          final act = () {
            dataSource.getWeather(request: defaultRequest);
          };

          final expected = throwsA(
            const AppException.invalidParameter(
              message: Strings.invalidParameterError,
            ),
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
