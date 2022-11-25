import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/views/components/temperature/ui_state.dart';

class TemperatureLabel extends ConsumerWidget {
  const TemperatureLabel({
    super.key,
    required this.provider,
    required this.color,
  });

  final AutoDisposeStateProvider<TemperatureUiState> provider;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temperature = ref.watch(provider);

    return Text(
      temperature.when(
        initial: () => '**℃',
        data: (temperature) => '$temperature℃',
      ),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: color,
          ),
    );
  }
}
