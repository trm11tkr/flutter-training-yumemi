import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/app.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/data/use_case/fetch_weather_use_case.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:flutter_training/views/start_up_view.dart';
import 'package:flutter_training/views/weather_view.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mock_weather_repository.mocks.dart';
import '../../test_util/test_agent.dart';

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

ProviderScope _setUpWithFetchWeatherUseCaseProvider(
  WeatherRepository repository,
  WeatherRequest request,
) {
  return ProviderScope(
    overrides: [
      fetchWeatherUseCaseProvider.overrideWith(
        (ref) => FetchWeatherUseCase(
          ref: ref,
          repository: repository,
          request: request,
        ),
      )
    ],
    child: const MaterialApp(
      home: WeatherView(),
    ),
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
    'Testing of parts not related to Api communication',
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
        '''
        After tapping the close button, 
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

              _expectSvgPicture('assets/images/sunny.svg', findsOneWidget);
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
  group(
    'success cases of api response',
    () {
      testWidgets(
        'You should see svg picture of sunny.',
        (tester) async {
          await setUpOfDeviceSize();
          await tester.pumpWidget(
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsOneWidget,
          );

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsNothing,
          );
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsOneWidget,
          );

          // To tap outside the range of the dialog widget,
          // specify the edge of the screen in Offset.
          await tester.tapAt(
            const Offset(5, 5),
          );
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsNothing,
          );
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsOneWidget,
          );

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsNothing,
          );
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
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsOneWidget,
          );

          // To tap outside the range of the dialog widget,
          // specify the edge of the screen in Offset.
          await tester.tapAt(
            const Offset(5, 5),
          );
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsNothing,
          );
        },
      );
    },
  );

  group(
    '''
    Test for correct operation after closing the dialog.
    ''',
    () {
      testWidgets(
        '''
        After the dialog with message of Strings.unknownError 
        is closed and new weather data is fetched,
        The new weather data should be reflected on the screen.
        ''',
        (tester) async {
          await setUpOfDeviceSize();
          await tester.pumpWidget(
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsOneWidget,
          );

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsNothing,
          );

          expect(find.byType(Placeholder), findsOneWidget);
          expect(find.text('**℃'), findsNWidgets(2));

          when(
            repository.getWeather(request: defaultRequest),
          ).thenReturn(
            AppApiResult.success(
              data: defaultWeather,
            ),
          );
          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Placeholder), findsNothing);
          _expectSvgPicture('assets/images/sunny.svg', findsOneWidget);

          expect(find.text('25℃'), findsOneWidget);
          expect(find.text('7℃'), findsOneWidget);
          expect(find.text('**℃'), findsNothing);
        },
      );

      testWidgets(
        '''
        After the dialog with message of Strings.invalidParameterError 
        is closed and new weather data is fetched,
        The new weather data should be reflected on the screen.
        ''',
        (tester) async {
          await setUpOfDeviceSize();
          await tester.pumpWidget(
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsOneWidget,
          );

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsNothing,
          );

          expect(find.byType(Placeholder), findsOneWidget);
          expect(find.text('**℃'), findsNWidgets(2));

          when(
            repository.getWeather(request: defaultRequest),
          ).thenReturn(
            AppApiResult.success(
              data: defaultWeather,
            ),
          );
          await tester.tap(find.text('Reload'));
          await tester.pump();

          expect(find.byType(Placeholder), findsNothing);
          _expectSvgPicture('assets/images/sunny.svg', findsOneWidget);

          expect(find.text('25℃'), findsOneWidget);
          expect(find.text('7℃'), findsOneWidget);
          expect(find.text('**℃'), findsNothing);
        },
      );

      testWidgets(
        '''
        After the dialog with message of Strings.invalidParameterError is closed and
        repository return AppApiResult.failure with Strings.unknownError, 
        Dialog with message of Strings.unknownError should be visible. 
        ''',
        (tester) async {
          await setUpOfDeviceSize();
          await tester.pumpWidget(
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsOneWidget,
          );

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsNothing,
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

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        '''
        After the dialog with message of Strings.unknownError is closed and
        repository return AppApiResult.failure with Strings.invalidParameterError, 
        Dialog with message of Strings.invalidParameterError should be visible. 
        ''',
        (tester) async {
          await setUpOfDeviceSize();
          await tester.pumpWidget(
            _setUpWithFetchWeatherUseCaseProvider(repository, defaultRequest),
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

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsOneWidget,
          );

          await tester.tap(find.text('OK'));
          await tester.pump();

          expect(
            find.widgetWithText(AlertDialog, Strings.unknownError),
            findsNothing,
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

          expect(
            find.widgetWithText(AlertDialog, Strings.invalidParameterError),
            findsOneWidget,
          );
        },
      );
    },
  );
}
