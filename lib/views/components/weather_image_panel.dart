import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/state/weather/models/weather_result.dart';

class WeatherImagePanel extends StatelessWidget {
  const WeatherImagePanel({
    super.key,
    required this.weatherCondition,
  });

  final WeatherCondition? weatherCondition;

  SvgPicture _weatherToImage(String weatherCondition) {
    return SvgPicture.asset('assets/images/$weatherCondition.svg');
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: weatherCondition != null
          ? _weatherToImage(weatherCondition!.name)
          : const Placeholder(),
    );
  }
}
