import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/app_error.dart';
import 'package:flutter_training/data/models/weather/weather_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_view_ui_state.freezed.dart';

@freezed
class WeatherViewUiState with _$WeatherViewUiState {
  const factory WeatherViewUiState.initial() = Initial;
  const factory WeatherViewUiState.data(WeatherResult weather) = Data;
  const factory WeatherViewUiState.error(AppError error) = Errors;
}

final weatherViewUiStateProvider =
    StateProvider.autoDispose<WeatherViewUiState>((ref) {
  return const WeatherViewUiState.initial();
});
