import 'package:flutter/material.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/temperature/component.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/weather_image_panel/component.dart';

class WeatherForecastPanel extends StatelessWidget {
  const WeatherForecastPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const WeatherImagePanel(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: const [
              Expanded(
                child: MinTemperatureLabel(),
              ),
              Expanded(
                child: MaxTemperatureLabel(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
