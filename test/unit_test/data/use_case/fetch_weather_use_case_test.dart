import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/data/use_case/fetch_weather_use_case.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/temperature/ui_state.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/weather_image_panel/ui_state.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:flutter_training/views/ui_state/weather_view_ui_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_weather_use_case_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  const defaultRequest = WeatherRequest();
  final client = MockWeatherRepository();

  group(
    'call method of FetchWeatherUseCase',
    () {
      test(
        '''
        On success of fetchWeather,
        update status other than WeatherViewUiState
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenAnswer(
            (_) => AppApiResult.success(
              data: Weather(
                weatherCondition: WeatherCondition.cloudy,
                maxTemperature: 25,
                minTemperature: 7,
                date: DateTime.parse('2020-04-01T12:00:00+09:00'),
              ),
            ),
          );

          final container = ProviderContainer(
            overrides: [
              fetchWeatherUseCaseProvider.overrideWith(
                (ref) => FetchWeatherUseCase(
                  ref: ref,
                  repository: client,
                  request: defaultRequest,
                ),
              )
            ],
          );

          // init status
          final fetchWeatherUseCase =
              container.read(fetchWeatherUseCaseProvider);

          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.initial(),
          );
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );

          fetchWeatherUseCase.call();
          // called api and reflect each state
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.initial(),
          );
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.data(7),
          );
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.data(25),
          );
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.data(WeatherCondition.cloudy),
          );
        },
      );

      test(
        '''
        When an exception occurs in fetchWeather,
        update only WeatherViewUiState to Error.
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenAnswer(
            (_) => const AppApiResult.failure(
              message: Strings.unknownError,
            ),
          );
          final container = ProviderContainer(
            overrides: [
              fetchWeatherUseCaseProvider.overrideWith(
                (ref) => FetchWeatherUseCase(
                  ref: ref,
                  repository: client,
                  request: defaultRequest,
                ),
              )
            ],
          );

          final fetchWeatherUseCase =
              container.read(fetchWeatherUseCaseProvider);

          // init status
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.initial(),
          );
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );

          fetchWeatherUseCase.call();
          // called api and reflect each state
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.error(Strings.unknownError),
          );
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );
        },
      );

      test(
        '''
        When parameter is invalid,
        update only WeatherViewUiState to Error.
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenAnswer(
            (_) => const AppApiResult.failure(
              message: Strings.invalidParameterError,
            ),
          );
          final container = ProviderContainer(
            overrides: [
              fetchWeatherUseCaseProvider.overrideWith(
                (ref) => FetchWeatherUseCase(
                  ref: ref,
                  repository: client,
                  request: defaultRequest,
                ),
              )
            ],
          );

          // init status
          final fetchWeatherUseCase =
              container.read(fetchWeatherUseCaseProvider);

          // 初期状態
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.initial(),
          );
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );

          fetchWeatherUseCase.call();
          // called api and reflect each state
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.error(Strings.invalidParameterError),
          );
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );
        },
      );
    },
  );
}
