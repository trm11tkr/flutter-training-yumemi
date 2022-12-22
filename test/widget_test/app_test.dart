import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/app.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/use_case/fetch_weather_use_case.dart';
import 'package:flutter_training/views/start_up_view.dart';
import 'package:flutter_training/views/weather_view.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_weather_repository.mocks.dart';
import '../test_util/test_util.dart';

void main() {
  final defaultRequest = WeatherRequest(
    date: DateTime.now(),
  );
  final defaultWeather = Weather(
    weatherCondition: WeatherCondition.sunny,
    maxTemperature: 25,
    minTemperature: 7,
    date: DateTime.parse('2020-04-01T12:00:00+09:00'),
  );
  final repository = MockWeatherRepository();

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

      testWidgets(
        '''
        After tapping the close button in WeatherView, 
        you should be taken to the StartUpView.
        ''',
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

              expect(find.byType(StartUpView), findsOneWidget);
              expect(find.byType(WeatherView), findsNothing);

              await Future<void>.delayed(const Duration(milliseconds: 500));
              await tester.pumpAndSettle();
              expect(find.byType(StartUpView), findsNothing);
              expect(find.byType(WeatherView), findsOneWidget);

              await tester.tap(find.text('Close'));

              await tester.pumpAndSettle();

              expect(find.byType(StartUpView), findsOneWidget);
              expect(find.byType(WeatherView), findsNothing);
            },
          );
        },
      );

      testWidgets(
        '''
        Tap the close button on the WeatherView 
        that shows the Weather returned from the repository, 
        and you should see the WeatherView in its initial state 
        after transitioning to the StartUpView
        ''',
        (tester) async {
          await setUpOfDeviceSize();
          await tester.runAsync(
            () async {
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
                  // When the Close button is tapped,
                  // Navigator.of(context).pop() is called.
                  // So at first, specify "App" in "child"
                  // and go through StartUpView.
                  child: const MaterialApp(
                    home: App(),
                  ),
                ),
              );

              when(
                repository.getWeather(request: defaultRequest),
              ).thenReturn(
                AppApiResult.success(
                  data: defaultWeather,
                ),
              );

              expect(find.byType(StartUpView), findsOneWidget);
              expect(find.byType(WeatherView), findsNothing);

              await Future<void>.delayed(const Duration(milliseconds: 500));
              await tester.pumpAndSettle();
              expect(find.byType(StartUpView), findsNothing);
              expect(find.byType(WeatherView), findsOneWidget);

              await tester.tap(find.text('Reload'));
              await tester.pump();

              expectSvgPicture('assets/images/sunny.svg', findsOneWidget);
              expect(find.text('25℃'), findsOneWidget);
              expect(find.text('7℃'), findsOneWidget);

              await tester.tap(find.text('Close'));
              await tester.pumpAndSettle();

              expect(find.byType(StartUpView), findsOneWidget);
              expect(find.byType(WeatherView), findsNothing);
              await Future<void>.delayed(const Duration(milliseconds: 500));
              await tester.pumpAndSettle();

              expect(find.byType(StartUpView), findsNothing);
              expect(find.byType(WeatherView), findsOneWidget);
              expect(find.byType(Placeholder), findsOneWidget);
              expect(find.text('**℃'), findsNWidgets(2));
            },
          );
        },
      );
    },
  );
}
