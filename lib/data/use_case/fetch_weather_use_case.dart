import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/temperature/ui_state.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/weather_image_panel/ui_state.dart';
import 'package:flutter_training/views/ui_state/weather_view_ui_state.dart';
import 'package:meta/meta.dart';

final fetchWeatherUseCaseProvider = Provider<FetchWeatherUseCase>((ref) {
  final repository = ref.watch(weatherRepositoryProvider);
  final request = ref.watch(weatherRequestStateProvider);

  return FetchWeatherUseCase(
    ref: ref,
    repository: repository,
    request: request,
  );
});

class FetchWeatherUseCase {
  @visibleForTesting
  FetchWeatherUseCase({
    required Ref ref,
    required WeatherRepository repository,
    required WeatherRequest request,
  })  : _ref = ref,
        _repository = repository,
        _request = request;

  final Ref _ref;
  final WeatherRepository _repository;
  final WeatherRequest _request;

  void call() {
    final result = _repository.getWeather(
      request: _request,
    );
    result.when(
      success: (weather) {
        _ref.read(weatherImagePanelStateProvider.notifier).update(
          (state) {
            final currentWeatherCondition =
                state.mapOrNull(data: (data) => data.condition);
            if (currentWeatherCondition == weather.weatherCondition) {
              return state;
            } else {
              return WeatherImagePanelUiState.data(
                weather.weatherCondition,
              );
            }
          },
        );
        _ref.read(maxTemperatureUiStateProvider.notifier).update(
          (state) {
            final currentMaxTemperature =
                state.mapOrNull(data: (data) => data.temperature);
            if (currentMaxTemperature == weather.maxTemperature) {
              return state;
            } else {
              return TemperatureUiState.data(weather.maxTemperature);
            }
          },
        );

        _ref.read(minTemperatureUiStateProvider.notifier).update(
          (state) {
            final currentMinTemperature =
                state.mapOrNull(data: (data) => data.temperature);
            if (currentMinTemperature == weather.minTemperature) {
              return state;
            } else {
              return TemperatureUiState.data(weather.minTemperature);
            }
          },
        );
      },
      failure: (error) {
        _ref.read(weatherViewUiStateProvider.notifier).update(
              (state) => WeatherViewUiState.error(error),
            );
      },
    );
  }
}
