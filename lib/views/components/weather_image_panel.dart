import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/state/weather_view_ui_state/providers/provider.dart';

class WeatherImagePanel extends ConsumerWidget {
  const WeatherImagePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherImage = ref.watch(weatherImagePanelProvider);
    return AspectRatio(
      aspectRatio: 1,
      child: weatherImage,
    );
  }
}
