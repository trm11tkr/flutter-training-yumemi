import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/state/weather/providers/provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_state.freezed.dart';

@freezed
class TemperatureUiState with _$TemperatureUiState {
  const factory TemperatureUiState.initial() = Initial;
  const factory TemperatureUiState.data(int temperature) = Data;
}

// 最低気温を管理するプロバイダー
final minTemperatureUiStateProvider =
    StateProvider.autoDispose<TemperatureUiState>(
  (ref) {
    final minTemperature = ref.watch(
      weatherStateProvider.select((weather) => weather?.minTemperature),
    );
    if (minTemperature == null) {
      return const TemperatureUiState.initial();
    } else {
      return TemperatureUiState.data(minTemperature);
    }
  },
);

// 最高気温を管理するプロバイダー
final maxTemperatureUiStateProvider =
    StateProvider.autoDispose<TemperatureUiState>(
  (ref) {
    final maxTemperature = ref.watch(
      weatherStateProvider.select((weather) => weather?.maxTemperature),
    );
    if (maxTemperature == null) {
      return const TemperatureUiState.initial();
    } else {
      return TemperatureUiState.data(maxTemperature);
    }
  },
);
