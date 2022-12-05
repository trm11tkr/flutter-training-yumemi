import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_view_ui_state.freezed.dart';

@freezed
class WeatherViewUiState with _$WeatherViewUiState {
  const factory WeatherViewUiState.initial() = _Initial;
  const factory WeatherViewUiState.error(String message) = _Errors;
}

final weatherViewUiStateProvider =
    StateProvider.autoDispose<WeatherViewUiState>((ref) {
  return const WeatherViewUiState.initial();
});
