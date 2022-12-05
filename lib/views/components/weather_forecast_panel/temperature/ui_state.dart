import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

@freezed
class TemperatureUiState with _$TemperatureUiState {
  const factory TemperatureUiState.initial() = _Initial;
  const factory TemperatureUiState.data(int temperature) = _Data;
}

// 最低気温を管理するプロバイダー
final minTemperatureUiStateProvider =
    StateProvider.autoDispose<TemperatureUiState>(
  (_) => const TemperatureUiState.initial(),
);

// 最高気温を管理するプロバイダー
final maxTemperatureUiStateProvider =
    StateProvider.autoDispose<TemperatureUiState>(
  (_) => const TemperatureUiState.initial(),
);
