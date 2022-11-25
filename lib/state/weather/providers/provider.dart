import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/state/weather/models/weather_result.dart';

// 現在の天気情報を管理するプロバイダー
final weatherRepositoryProvider = StateProvider.autoDispose<WeatherResult?>(
  (_) => null,
);
