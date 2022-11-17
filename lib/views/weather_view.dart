import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_training/state/weather/models/weather_request.dart';
import 'package:flutter_training/state/weather/models/weather_result.dart';
import 'package:flutter_training/utils/logger.dart';
import 'package:flutter_training/views/components/dialogs/alert_dialog_model.dart';
import 'package:flutter_training/views/components/dialogs/error_dialog.dart';
import 'package:flutter_training/views/components/weather_image_panel.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_view.freezed.dart';

@freezed
class FetchWeatherResult with _$FetchWeatherResult {
  const factory FetchWeatherResult(WeatherResult weather) = Data;
  const factory FetchWeatherResult.error(String message) = ErrorDetails;
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final _weatherClient = YumemiWeather();
  final _weatherRequest = const WeatherRequest();

  String? _currentWeather;
  String _maxTemperature = '** ℃';
  String _minTemperature = '** ℃';

  FetchWeatherResult _fetchWeather(
    YumemiWeather client,
    WeatherRequest request,
  ) {
    try {
      final weatherJson = client.fetchWeather(
        jsonEncode(
          request.toJson(),
        ),
      );

      final weather = WeatherResult.fromJson(
        jsonDecode(weatherJson) as Map<String, dynamic>,
      );
      return FetchWeatherResult(weather);
    } on YumemiWeatherError catch (error) {
      logger.shout(error);
      switch (error) {
        case YumemiWeatherError.invalidParameter:
          return const FetchWeatherResult.error(Strings.invalidParameterError);

        case YumemiWeatherError.unknown:
          return const FetchWeatherResult.error(Strings.unknownError);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              width: deviceWidth / 2,
              child: Column(
                children: [
                  WeatherImagePanel(currentWeather: _currentWeather),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _minTemperature,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Colors.blue,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            _maxTemperature,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    width: deviceWidth / 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: const Text('Close'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                _fetchWeather(
                                  _weatherClient,
                                  _weatherRequest,
                                ).when(
                                  (weather) {
                                    setState(
                                      () {
                                        _currentWeather =
                                            weather.weatherCondition;
                                        _maxTemperature =
                                            '${weather.maxTemperature}℃';
                                        _minTemperature =
                                            '${weather.minTemperature}℃';
                                      },
                                    );
                                  },
                                  error: (message) {
                                    ErrorDialog(
                                      title: message,
                                    ).present(context);
                                  },
                                );
                              },
                              child: const Text('Reload'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
