import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_training/data/models/weather/weather.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

@freezed
class WeatherImagePanelUiState with _$WeatherImagePanelUiState {
  const factory WeatherImagePanelUiState.initial() = _Initial;
  const factory WeatherImagePanelUiState.data(WeatherCondition condition) =
      _Data;
}

// 天気予報のパネルを管理するプロバイダー
final weatherImagePanelStateProvider =
    StateProvider.autoDispose<WeatherImagePanelUiState>(
  (ref) => const WeatherImagePanelUiState.initial(),
);
