// YumemiWeather のクライアントを管理するプロバイダー
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/state/weather/models/weather_request.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final yumemiWeatherClientProvider = Provider<YumemiWeather>(
  (_) => YumemiWeather(),
);

// YumemiWeather リクエストパラメータを管理するプロバイダー
final weatherRequestProvider = StateProvider<WeatherRequest>(
  (_) => const WeatherRequest(),
);
