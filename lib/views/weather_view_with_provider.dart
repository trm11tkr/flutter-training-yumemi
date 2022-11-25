import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/state/weather/providers/provider.dart';
import 'package:flutter_training/state/weather_view_ui_state/models/weather_view_ui_state.dart';
import 'package:flutter_training/state/weather_view_ui_state/providers/provider.dart';
import 'package:flutter_training/views/components/dialogs/alert_dialog_model.dart';
import 'package:flutter_training/views/components/dialogs/error_dialog.dart';
import 'package:flutter_training/views/components/weather_image_panel.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final weatherResult = ref.watch(weatherRepositoryProvider);

    ref.listen<WeatherViewUiState>(
      weatherViewUiStateProvider,
      (previous, next) {
        next.when(
          () {},
          data: (weather) {
            ref.read(weatherRepositoryProvider.notifier).update(
                  (state) => weather,
                );
          },
          error: (error) {
            String message;
            switch (error) {
              case YumemiWeatherError.invalidParameter:
                message = Strings.invalidParameterError;
                break;
              case YumemiWeatherError.unknown:
                message = Strings.unknownError;
                break;
            }
            ErrorDialog(
              title: message,
            ).present(context);
          },
        );
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              width: deviceWidth / 2,
              child: Column(
                children: [
                  const WeatherImagePanel(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            weatherResult != null
                                ? weatherResult.displayTemperature(
                                    weatherResult.minTemperature,
                                  )
                                : '**℃',
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
                            weatherResult != null
                                ? weatherResult.displayTemperature(
                                    weatherResult.maxTemperature,
                                  )
                                : '**℃',
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
                                ref
                                    .read(weatherViewUiStateProvider.notifier)
                                    .fetchWeather();
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
