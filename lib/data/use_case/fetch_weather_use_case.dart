import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/temperature/ui_state.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/weather_image_panel/ui_state.dart';
import 'package:flutter_training/views/ui_state/weather_view_ui_state.dart';

final fetchWeatherUseCaseProvider = Provider<FetchWeatherUseCase>((ref) {
  return FetchWeatherUseCase(ref);
});

class FetchWeatherUseCase {
  FetchWeatherUseCase(Ref ref)
      : _repository = ref.read(weatherRepositoryProvider),
        _ref = ref,
        super();

  final WeatherRepository _repository;

  final Ref _ref;

  void fetchWeather() {
    _repository.fetch().when(
      success: (weather) {
        _ref.read(weatherViewUiStateProvider.notifier).update(
              (state) => WeatherViewUiState.data(weather),
            );
        _ref.read(weatherImagePanelProvider.notifier).update(
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
