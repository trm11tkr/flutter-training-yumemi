import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/data_source/weather_data_source.dart';
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
import 'package:yumemi_weather/yumemi_weather.dart';

import 'fetch_weather_use_case_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  const defaultRequest = WeatherRequest();
  final json = defaultRequest.toJson();
  final jsonString = jsonEncode(json);
  group('call of FetchWeatherUseCase', () {
    test('fetchWeather 成功時: WeatherViewUiState以外の状態を更新', () {
      final client = MockYumemiWeather();

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

      final dataStore = WeatherDataSource(client);
      final repository = WeatherRepository(dataStore);
      final container = ProviderContainer(
        overrides: [
          fetchWeatherUseCaseProvider.overrideWith(
            (ref) => FetchWeatherUseCase(
              ref: ref,
              repository: repository,
              request: defaultRequest,
            ),
          )
        ],
      );

      final fetchWeatherUseCase = container.read(fetchWeatherUseCaseProvider);

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
    });

    test('fetchWeather 失敗時: パラメータ無効時: WeatherViewUiStateのみエラーに更新', () {
      final client = MockYumemiWeather();

      when(
        client.fetchWeather(jsonString),
      ).thenAnswer(
        // ignore: only_throw_errors
        (_) => throw YumemiWeatherError.unknown,
      );

      final dataStore = WeatherDataSource(client);
      final repository = WeatherRepository(dataStore);
      final container = ProviderContainer(
        overrides: [
          fetchWeatherUseCaseProvider.overrideWith(
            (ref) => FetchWeatherUseCase(
              ref: ref,
              repository: repository,
              request: defaultRequest,
            ),
          )
        ],
      );

      final fetchWeatherUseCase = container.read(fetchWeatherUseCaseProvider);

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
    });

    test('パラメータ無効時: WeatherViewUiStateのみエラーに更新', () {
      final dataStore = WeatherDataSource(YumemiWeather());
      final repository = WeatherRepository(dataStore);
      const request = WeatherRequest(date: 'invalid Parameter');
      final container = ProviderContainer(
        overrides: [
          fetchWeatherUseCaseProvider.overrideWith(
            (ref) => FetchWeatherUseCase(
              ref: ref,
              repository: repository,
              request: request,
            ),
          )
        ],
      );

      final fetchWeatherUseCase = container.read(fetchWeatherUseCaseProvider);

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

      // 画面・天気状態を更新
      fetchWeatherUseCase.call();
      expect(
        container.read(weatherViewUiStateProvider),
        const WeatherViewUiState.error(Strings.invalidParameterError),
      );
      // エラー発生時は天気状態は更新されない
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
    });
  });
}
