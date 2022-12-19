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
  final defaultRequest = WeatherRequest(
    date: DateTime.now(),
  );
  final dataSource = MockWeatherDataSource();
  final repository =  WeatherRepository(dataSource);

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
            dataSource.getWeather(request: defaultRequest),
          ).thenReturn(
            Weather(
              weatherCondition: WeatherCondition.cloudy,
              maxTemperature: 25,
              minTemperature: 7,
              date: DateTime.now(),
            ),
          );

          final act = repository.getWeather(
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
            dataSource.getWeather(request: defaultRequest),
          ).thenThrow(
            const AppException.unknown(
              message: Strings.unknownError,
            ),
          );

          final act = repository.getWeather(
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
            dataSource.getWeather(request: defaultRequest),
          ).thenThrow(
            const AppException.invalidParameter(
              message: Strings.invalidParameterError,
            ),
          );

          final act =
              repository.getWeather(request: defaultRequest);
          const expected = AppApiResult<Weather>.failure(
            message: Strings.invalidParameterError,
          );

          expect(act, expected);
        },
      );
    },
  );
}
