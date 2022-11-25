import 'package:flutter_training/state/weather/models/weather_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_view_ui_state.freezed.dart';

@freezed
class WeatherViewUiState with _$WeatherViewUiState {
  const factory WeatherViewUiState() = Initial;
  const factory WeatherViewUiState.data(WeatherResult weather) = Data;
  const factory WeatherViewUiState.error(YumemiWeatherError error) =
      YumemiError;
}
