import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/views/weather_view.dart';

import '../../test_util/test_agent.dart';

void main() {
  group('WeatherView', () {
    testWidgets('first build', (tester) async {
      await setUpOfDeviceSize();
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: WeatherView(),
          ),
        ),
      );
      expect(find.byType(WeatherView), findsOneWidget);
      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.text('Close'), findsOneWidget);
      expect(find.text('Reload'), findsOneWidget);
      expect(find.text('**℃'), findsNWidgets(2));
    });
  });
}
