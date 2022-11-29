import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/models/weather/weather_result.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherDataSourceProvider = Provider<WeatherDataSource>((_) {
  final client = YumemiWeather();
  const request = WeatherRequest();
  return WeatherDataSource._(
    client: client,
    request: request,
  );
});

class WeatherDataSource {
  const WeatherDataSource._({
    required YumemiWeather client,
    required WeatherRequest request,
  })  : _client = client,
        _request = request;

  final YumemiWeather _client;
  final WeatherRequest _request;

  WeatherResult fetch() {
    final weatherJson = _client.fetchWeather(
      jsonEncode(
        _request.toJson(),
      ),
    );

    final weather = WeatherResult.fromJson(
      jsonDecode(weatherJson) as Map<String, dynamic>,
    );
    return weather;
  }
}
