import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/use_case/fetch_weather_use_case.dart';
import 'package:flutter_training/views/weather_view.dart';
import 'package:mockito/mockito.dart';

import '../../test_util/test_agent.dart';
import '../../unit_test/data/use_case/fetch_weather_use_case_test.mocks.dart';

void main() {
  final defaultRequest = WeatherRequest(
    date: DateTime.now(),
  );
  final repository = MockWeatherRepository();
  group(
    'WeatherView',
    () {
      testWidgets(
        'first build',
        (tester) async {
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
        },
      );

      testWidgets(
        'You should see a max temperature.',
        (tester) async {
          await setUpOfDeviceSize();
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                fetchWeatherUseCaseProvider.overrideWith(
                  (ref) => FetchWeatherUseCase(
                    ref: ref,
                    repository: repository,
                    request: defaultRequest,
                  ),
                )
              ],
              child: const MaterialApp(
                home: WeatherView(),
              ),
            ),
          );
          when(
            repository.getWeather(request: defaultRequest),
          ).thenReturn(
            AppApiResult.success(
              data: Weather(
                weatherCondition: WeatherCondition.cloudy,
                maxTemperature: 25,
                minTemperature: 7,
                date: DateTime.parse('2020-04-01T12:00:00+09:00'),
              ),
            ),
          );
          expect(find.byType(TextButton), findsNWidgets(2));
          expect(find.text('**℃'), findsNWidgets(2));

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.text('25℃'), findsOneWidget);

          when(
            repository.getWeather(request: defaultRequest),
          ).thenReturn(
            AppApiResult.success(
              data: Weather(
                weatherCondition: WeatherCondition.cloudy,
                maxTemperature: 30,
                minTemperature: 7,
                date: DateTime.parse('2020-04-01T12:00:00+09:00'),
              ),
            ),
          );
          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.text('25℃'), findsNothing);
          expect(find.text('30℃'), findsOneWidget);
        },
      );
    },
  );
}
