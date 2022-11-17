import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherImagePanel extends StatelessWidget {
  const WeatherImagePanel({
    super.key,
    required this.currentWeather,
  });

  final String? currentWeather;

  SvgPicture _weatherToImage(String weather) {
    return SvgPicture.asset('assets/images/$weather.svg');
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: currentWeather != null
          ? _weatherToImage(currentWeather!)
          : const Placeholder(),
    );
  }
}
