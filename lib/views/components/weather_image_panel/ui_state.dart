import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/state/weather/models/weather_result.dart';
import 'package:flutter_training/state/weather/providers/provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

@freezed
class WeatherImagePanelUiState with _$WeatherImagePanelUiState {
  const factory WeatherImagePanelUiState.initial() = Initial;
  const factory WeatherImagePanelUiState.data(WeatherCondition condition) =
      Data;
}

// 天気予報のパネルを管理するプロバイダー
final weatherImagePanelProvider =
    StateProvider.autoDispose<WeatherImagePanelUiState>(
  (ref) {
    final weatherCondition = ref.watch(
      weatherStateProvider.select((weather) => weather?.weatherCondition),
    );
    if (weatherCondition == null) {
      return const WeatherImagePanelUiState.initial();
    } else {
      return WeatherImagePanelUiState.data(weatherCondition);
    }
  },
);
