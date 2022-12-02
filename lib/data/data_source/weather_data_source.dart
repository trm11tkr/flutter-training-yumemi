import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/app_exception.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:meta/meta.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final weatherDataSourceProvider = Provider<WeatherDataSource>((_) {
  final client = YumemiWeather();
  return WeatherDataSource(
    client,
  );
});

class WeatherDataSource {
  @visibleForTesting
  const WeatherDataSource(
    this._client,
  );

  final YumemiWeather _client;

  Weather getWeather({
    required WeatherRequest request,
  }) {
    try {
      final weatherJson = _client.fetchWeather(
        jsonEncode(
          request.toJson(),
        ),
      );

      final weather = Weather.fromJson(
        jsonDecode(weatherJson) as Map<String, dynamic>,
      );
      return weather;
    } on YumemiWeatherError catch (error) {
      switch (error) {
        case YumemiWeatherError.invalidParameter:
          throw const AppException.invalidParameter(
            message: Strings.invalidParameterError,
          );
        case YumemiWeatherError.unknown:
          throw const AppException.unknown(
            message: Strings.unknownError,
          );
      }
    } on Exception catch (error, stackTrace) {
      throw AppException.other(
        message: error.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
