import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/weather_image_panel/ui_state.dart';

class WeatherImagePanel extends ConsumerWidget {
  const WeatherImagePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(weatherImagePanelStateProvider);
    return AspectRatio(
      aspectRatio: 1,
      child: uiState.when(
        initial: Placeholder.new,
        data: (condition) => SvgPicture.asset(
          'assets/images/${condition.name}.svg',
        ),
      ),
    );
  }
}
