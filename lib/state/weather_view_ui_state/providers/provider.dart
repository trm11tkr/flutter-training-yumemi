import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/state/api/providers/provider.dart';
import 'package:flutter_training/state/weather/models/weather_request.dart';
import 'package:flutter_training/state/weather/models/weather_result.dart';
import 'package:flutter_training/state/weather_view_ui_state/models/weather_view_ui_state.dart';
import 'package:yumemi_weather/yumemi_weather.dart';



// WeatherViewの画面の状態を管理するプロバイダー
final weatherViewUiStateProvider =
    StateNotifierProvider<WeatherViewUiStateNotifier, WeatherViewUiState>(
  (ref) {
    final yumemiWeatherClient = ref.read(yumemiWeatherClientProvider);
    final weatherRequest = ref.watch(weatherRequestProvider);

    return WeatherViewUiStateNotifier(
      yumemiWeatherClient: yumemiWeatherClient,
      weatherRequest: weatherRequest,
    );
  },
);

class WeatherViewUiStateNotifier extends StateNotifier<WeatherViewUiState> {
  WeatherViewUiStateNotifier({
    required this.yumemiWeatherClient,
    required this.weatherRequest,
  }) : super(const WeatherViewUiState());

  final YumemiWeather yumemiWeatherClient;
  final WeatherRequest weatherRequest;

  void fetchWeather() {
    try {
      final weatherJson = yumemiWeatherClient.fetchWeather(
        jsonEncode(
          weatherRequest.toJson(),
        ),
      );

      final weather = WeatherResult.fromJson(
        jsonDecode(weatherJson) as Map<String, dynamic>,
      );

      state = WeatherViewUiState.data(weather);
    } on YumemiWeatherError catch (error) {
      state = WeatherViewUiState.error(error);
    }
  }
}
