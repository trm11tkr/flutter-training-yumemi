import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/temperature/ui_state.dart';

class _TemperatureLabel extends StatelessWidget {
  const _TemperatureLabel({
    required String temperature,
    required Color textColor,
  })  : _temperature = temperature,
        _textColor = textColor;

  final String _temperature;
  final Color _textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      _temperature,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: _textColor,
          ),
    );
  }
}

class MinTemperatureLabel extends ConsumerWidget {
  const MinTemperatureLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(minTemperatureUiStateProvider);
    final temperature = uiState.map(
      initial: (value) => '**℃',
      data: (value) => '${value.temperature}℃',
    );

    return _TemperatureLabel(
      temperature: temperature,
      textColor: Colors.blue,
    );
  }
}

class MaxTemperatureLabel extends ConsumerWidget {
  const MaxTemperatureLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(maxTemperatureUiStateProvider);
    final temperature = uiState.map(
      initial: (value) => '**℃',
      data: (value) => '${value.temperature}℃',
    );

    return _TemperatureLabel(
      temperature: temperature,
      textColor: Colors.red,
    );
  }
}
