import 'package:flutter/material.dart';
import 'package:flutter_training/views/components/dialogs/alert_dialog_model.dart';
import 'package:flutter_training/views/components/dialogs/error_dialog.dart';
import 'package:flutter_training/views/components/weather_image_panel.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final _weatherClient = YumemiWeather();

  String? _currentWeather;

  String? _fetchWeather(YumemiWeather client) {
    try {
      final weather = client.fetchThrowsWeather('kyoto');
      return weather;
    } on YumemiWeatherError {
      return null;
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
                            '** ℃',
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
                            '** ℃',
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
                                final weather = _fetchWeather(_weatherClient);
                                if (weather == null) {
                                  const ErrorDialog(
                                    title: Strings.simpleError,
                                  ).present(context);
                                } else {
                                  setState(() {
                                    _currentWeather = weather;
                                  });
                                }
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
