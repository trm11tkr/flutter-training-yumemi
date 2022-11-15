import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  Widget? _currentWeather;

  String? _fetchWeather(YumemiWeather client) {
    try {
      final weather = client.fetchSimpleWeather();
      return weather;
    } on YumemiWeatherError catch (e) {
      print(e);
      return null;
    }
  }

  SvgPicture _weatherToImage(String weather) {
    return SvgPicture.asset('assets/images/$weather.svg');
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final weatherClient = YumemiWeather();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              width: deviceWidth / 2,
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: _currentWeather ?? const Placeholder(),
                  ),
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
                              onPressed: () {},
                              child: const Text('Close'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                final weather = _fetchWeather(weatherClient);
                                if (weather == null) {
                                  return;
                                } else {
                                  setState(() {
                                    _currentWeather = _weatherToImage(weather);
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
