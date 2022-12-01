import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/temperature/ui_state.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/weather_image_panel/ui_state.dart';
import 'package:flutter_training/views/ui_state/weather_view_ui_state.dart';

final fetchWeatherUseCaseProvider = Provider<FetchWeatherUseCase>((ref) {
  final repository = ref.watch(weatherRepositoryProvider);
  final request = ref.watch(weatherRequestStateProvider);

  return FetchWeatherUseCase._(
    ref: ref,
    repository: repository,
    request: request,
  );
});

class FetchWeatherUseCase {
  FetchWeatherUseCase._({
    required Ref ref,
    required WeatherRepository repository,
    required WeatherRequest request,
  })  : _ref = ref,
        _repository = repository,
        _request = request;

  final WeatherRepository _repository;

  final WeatherRequest _request;

  final Ref _ref;

  void fetchWeather() {
    _repository
        .getWeather(
      request: _request,
    )
        .when(
      success: (weather) {
        _ref.read(weatherImagePanelStateProvider.notifier).update(
              (state) => WeatherImagePanelUiState.data(
                weather.weatherCondition,
              ),
            );
        _ref.read(minTemperatureUiStateProvider.notifier).update(
              (state) => TemperatureUiState.data(
                weather.minTemperature,
              ),
            );
        _ref.read(maxTemperatureUiStateProvider.notifier).update(
              (state) => TemperatureUiState.data(
                weather.maxTemperature,
              ),
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
