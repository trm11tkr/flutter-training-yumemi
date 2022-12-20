import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/use_case/fetch_weather_use_case.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:flutter_training/views/weather_view.dart';
import 'package:mockito/mockito.dart';

import '../../test_util/test_agent.dart';
import '../../unit_test/data/use_case/fetch_weather_use_case_test.mocks.dart';

void _expectSvgPicture(String expectedAssetName, Matcher matcher) {
  expect(
    find.byWidgetPredicate(
      (widget) {
        if (widget is SvgPicture) {
          final exactAssetPicture = widget.pictureProvider;
          if (exactAssetPicture is ExactAssetPicture) {
            return exactAssetPicture.assetName == expectedAssetName;
          }
        }
        return false;
      },
    ),
    matcher,
  );
}

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
  group(
    'success cases of api response',
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
        'You should see svg picture of sunny.',
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
              // Default WeatherCondition is WeatherCondition.sunny
              data: defaultWeather,
            ),
          );
          expect(find.byType(Placeholder), findsOneWidget);

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Placeholder), findsNothing);
          _expectSvgPicture('assets/images/sunny.svg', findsOneWidget);
        },
      );

      testWidgets(
        'You should see svg picture of cloudy.',
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
              data: defaultWeather.copyWith(
                weatherCondition: WeatherCondition.cloudy,
              ),
            ),
          );
          expect(find.byType(Placeholder), findsOneWidget);

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Placeholder), findsNothing);
          _expectSvgPicture('assets/images/cloudy.svg', findsOneWidget);
        },
      );

      testWidgets(
        'You should see svg picture of rainy.',
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
              data: defaultWeather.copyWith(
                weatherCondition: WeatherCondition.rainy,
              ),
            ),
          );
          expect(find.byType(Placeholder), findsOneWidget);

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Placeholder), findsNothing);
          _expectSvgPicture('assets/images/rainy.svg', findsOneWidget);
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
              // Default maxTemperature is 25
              data: defaultWeather,
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
              data: defaultWeather.copyWith(
                maxTemperature: 30,
              ),
            ),
          );
          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.text('25℃'), findsNothing);
          expect(find.text('30℃'), findsOneWidget);
        },
      );

      testWidgets(
        'You should see a min temperature.',
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
              // Default minTemperature is 7
              data: defaultWeather,
            ),
          );
          expect(find.byType(TextButton), findsNWidgets(2));
          expect(find.text('**℃'), findsNWidgets(2));

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.text('7℃'), findsOneWidget);

          when(
            repository.getWeather(request: defaultRequest),
          ).thenReturn(
            AppApiResult.success(
              data: defaultWeather.copyWith(
                minTemperature: -5,
              ),
            ),
          );
          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.text('7℃'), findsNothing);
          expect(find.text('-5℃'), findsOneWidget);
        },
      );
    },
  );
  group(
    '''
    failure cases of api response.
    ''',
    () {
      testWidgets(
        '''
        Dialog and message should be visible 
        when repository return AppApiResult.failure with Strings.unknownError.
        The dialog is closed by pressing the ok button.
        ''',
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
            const AppApiResult.failure(
              message: Strings.unknownError,
            ),
          );

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Dialog), findsOneWidget);
          expect(find.text(Strings.unknownError), findsOneWidget);

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(find.byType(Dialog), findsNothing);
          expect(find.text(Strings.unknownError), findsNothing);
        },
      );

      testWidgets(
        '''
        Dialog and message should be visible 
        when repository return AppApiResult.failure with Strings.unknownError.
        That dialog is also closed by pressing outside the dialog's range.
        ''',
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
            const AppApiResult.failure(
              message: Strings.unknownError,
            ),
          );

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Dialog), findsOneWidget);
          expect(find.text(Strings.unknownError), findsOneWidget);

          await tester.tapAt(
            const Offset(5, 5),
          );
          await tester.pump();

          expect(find.byType(Dialog), findsNothing);
          expect(find.text(Strings.unknownError), findsNothing);
        },
      );

      testWidgets(
        '''
        Dialog and message should be visible 
        when repository return AppApiResult.failure with Strings.invalidParameterError.
        The dialog is closed by pressing the ok button.
        ''',
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
            const AppApiResult.failure(
              message: Strings.invalidParameterError,
            ),
          );

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Dialog), findsOneWidget);
          expect(find.text(Strings.invalidParameterError), findsOneWidget);

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(find.byType(Dialog), findsNothing);
          expect(find.text(Strings.invalidParameterError), findsNothing);
        },
      );

      testWidgets(
        '''
        Dialog and message should be visible 
        when repository return AppApiResult.failure with Strings.invalidParameterError.
        That dialog is also closed by pressing outside the dialog's range.
        ''',
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
            const AppApiResult.failure(
              message: Strings.invalidParameterError,
            ),
          );

          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Dialog), findsOneWidget);
          expect(find.text(Strings.invalidParameterError), findsOneWidget);

          await tester.tapAt(
            const Offset(5, 5),
          );
          await tester.pump();

          expect(find.byType(Dialog), findsNothing);
          expect(find.text(Strings.invalidParameterError), findsNothing);
        },
      );
    },
  );
}
