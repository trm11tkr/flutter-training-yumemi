import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/utils/logger.dart';
import 'package:flutter_training/views/weather_view.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({super.key});

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  final _weatherClient = YumemiWeather();

  SvgPicture? _currentWeather;

  @override
  void initState() {
    WidgetsBinding.instance.endOfFrame.then((_) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => const WeatherView(),
        ),
      );
    });
    super.initState();
  }

  String? _fetchWeather(YumemiWeather client) {
    try {
      final weather = client.fetchSimpleWeather();
      return weather;
    } on YumemiWeatherError catch (e) {
      logger.shout(e);
      return null;
    }
  }

  SvgPicture _weatherToImage(String weather) {
    return SvgPicture.asset('assets/images/$weather.svg');
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
                                final weather = _fetchWeather(_weatherClient);
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
