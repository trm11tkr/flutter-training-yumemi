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

import 'weather_repository_test.mocks.dart';

@GenerateMocks([WeatherDataSource])
void main() {
  const defaultRequest = WeatherRequest();
  final client = MockWeatherDataSource();

  group(
    'getWeather of WeatherRepository',
    () {
      test(
        '''
           On success of getWeather:
           return AppApiResult<Weather>.
           ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenAnswer(
            (_) => Weather(
              weatherCondition: WeatherCondition.cloudy,
              maxTemperature: 25,
              minTemperature: 7,
              date: DateTime.now(),
            ),
          );

          final act = WeatherRepository(client).getWeather(
            request: defaultRequest,
          );
          final expected = isA<AppApiResult<Weather>>();

          expect(act, expected);
        },
      );

      test(
        '''
        When an exception occurs in fetchWeather:
        return AppApiResult<Weather>.failure(message: Strings.unknownError).
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenAnswer(
            (_) => throw const AppException.unknown(
              message: Strings.unknownError,
            ),
          );

          final act = WeatherRepository(client).getWeather(
            request: defaultRequest,
          );
          const expected = AppApiResult<Weather>.failure(
            message: Strings.unknownError,
          );

          expect(act, expected);
        },
      );

      test(
        '''
        When parameter is invalid,
        return AppApiResult.failure(message:Strings.invalidParameterError).
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenAnswer(
            (_) => throw const AppException.invalidParameter(
              message: Strings.invalidParameterError,
            ),
          );

          final act =
              WeatherRepository(client).getWeather(request: defaultRequest);
          const expected = AppApiResult<Weather>.failure(
            message: Strings.invalidParameterError,
          );

          expect(act, expected);
        },
      );
    },
  );
}
