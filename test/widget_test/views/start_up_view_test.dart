import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/app.dart';
import 'package:flutter_training/views/start_up_view.dart';
import 'package:flutter_training/views/weather_view.dart';

import '../../test_util/test_agent.dart';

void main() {
  testWidgets(
    'StartUpView transition to WeatherView',
    (tester) async {
      await setUpOfDeviceSize();
      await tester.runAsync(
        () async {
          await tester.pumpWidget(
            const ProviderScope(
              child: MaterialApp(
                home: App(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.byType(StartUpView), findsOneWidget);
          expect(find.byType(WeatherView), findsNothing);

          await Future<void>.delayed(const Duration(milliseconds: 500));
          await tester.pumpAndSettle();
          expect(find.byType(StartUpView), findsNothing);
          expect(find.byType(WeatherView), findsOneWidget);
        },
      );
    },
  );
}
