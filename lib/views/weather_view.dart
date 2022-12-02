import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/use_case/fetch_weather_use_case.dart';
import 'package:flutter_training/views/components/dialogs/alert_dialog_model.dart';
import 'package:flutter_training/views/components/dialogs/error_dialog.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/components.dart';
import 'package:flutter_training/views/ui_state/weather_view_ui_state.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<WeatherViewUiState>(
      weatherViewUiStateProvider,
      (previous, uiState) {
        uiState.maybeWhen(
          error: (message) {
            ErrorDialog(
              title: message,
              onWillPop: () {
                ref.read(weatherViewUiStateProvider.notifier).update(
                      (state) => const WeatherViewUiState.initial(),
                    );
              },
            ).present(context);
          },
          orElse: () {},
        );
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const FractionallySizedBox(
              widthFactor: 0.5,
              child: WeatherForecastPanel(),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
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
                                    .read(fetchWeatherUseCaseProvider)
                                    .call();
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
