import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:flutter_training/data/repository/weather_repository.dart';
import 'package:flutter_training/data/use_case/fetch_weather_use_case.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/temperature/ui_state.dart';
import 'package:flutter_training/views/components/weather_forecast_panel/weather_image_panel/ui_state.dart';
import 'package:flutter_training/views/constants/strings.dart';
import 'package:flutter_training/views/ui_state/weather_view_ui_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_weather_use_case_test.mocks.dart';

class Listener<T> extends Mock {
  void call(T? previous, T value);
}

@GenerateMocks([WeatherRepository])
void main() {
  const defaultRequest = WeatherRequest();
  final client = MockWeatherRepository();

  group(
    'call method of FetchWeatherUseCase',
    () {
      test(
        '''
        On success of fetchWeather,
        update status other than WeatherViewUiState
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
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

          final container = ProviderContainer(
            overrides: [
              fetchWeatherUseCaseProvider.overrideWith(
                (ref) => FetchWeatherUseCase(
                  ref: ref,
                  repository: client,
                  request: defaultRequest,
                ),
              )
            ],
          );
          final weatherViewUiStateListener = Listener<WeatherViewUiState>();
          container.listen<WeatherViewUiState>(
            weatherViewUiStateProvider,
            weatherViewUiStateListener,
            fireImmediately: true,
          );

          final maxTemperatureUiStateListener = Listener<TemperatureUiState>();
          container.listen<TemperatureUiState>(
            maxTemperatureUiStateProvider,
            maxTemperatureUiStateListener,
            fireImmediately: true,
          );

          final minTemperatureUiStateListener = Listener<TemperatureUiState>();
          container.listen<TemperatureUiState>(
            minTemperatureUiStateProvider,
            minTemperatureUiStateListener,
            fireImmediately: true,
          );

          final weatherImagePanelUiStateListener =
              Listener<WeatherImagePanelUiState>();
          container.listen<WeatherImagePanelUiState>(
            weatherImagePanelStateProvider,
            weatherImagePanelUiStateListener,
            fireImmediately: true,
          );

          // WeatherViewUiState.initial() is the default value
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.initial(),
          );

          // TemperatureUiState.initial() is the default value
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );

          // TemperatureUiState.initial() is the default value
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );

          //  WeatherImagePanelUiState.initial() is the default value
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );

          // call the process of FetchWeatherUseCase
          container.read(fetchWeatherUseCaseProvider).call();

          // the weatherViewUiStateListener is called immediately
          // with WeatherViewUiState.initial(), the default value
          verify(
            weatherViewUiStateListener(
              null,
              const WeatherViewUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(weatherViewUiStateListener);

          // maxTemperatureUiStateProvider should be reflected
          // in the fetch fetch process of fetchWeatherUseCase
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.data(25),
          );
          verifyInOrder(
            [
              maxTemperatureUiStateListener(
                null,
                const TemperatureUiState.initial(),
              ),
              maxTemperatureUiStateListener(
                const TemperatureUiState.initial(),
                const TemperatureUiState.data(25),
              ),
            ],
          );
          verifyNoMoreInteractions(maxTemperatureUiStateListener);

          // minTemperatureUiStateProvider should be reflected
          // in the fetch fetch process of fetchWeatherUseCase
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.data(25),
          );
          verifyInOrder(
            [
              minTemperatureUiStateListener(
                null,
                const TemperatureUiState.initial(),
              ),
              minTemperatureUiStateListener(
                const TemperatureUiState.initial(),
                const TemperatureUiState.data(7),
              ),
            ],
          );
          verifyNoMoreInteractions(minTemperatureUiStateListener);

          // weatherImagePanelStateProvider should be reflected
          // in the fetch fetch process of fetchWeatherUseCase
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.data(WeatherCondition.cloudy),
          );
          verifyInOrder(
            [
              weatherImagePanelUiStateListener(
                null,
                const WeatherImagePanelUiState.initial(),
              ),
              weatherImagePanelUiStateListener(
                const WeatherImagePanelUiState.initial(),
                const WeatherImagePanelUiState.data(WeatherCondition.cloudy),
              ),
            ],
          );
          verifyNoMoreInteractions(weatherImagePanelUiStateListener);
        },
      );

      test(
        '''
        When an exception occurs in fetchWeather,
        update only WeatherViewUiState to Error.
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenReturn(
            const AppApiResult.failure(
              message: Strings.unknownError,
            ),
          );
          final container = ProviderContainer(
            overrides: [
              fetchWeatherUseCaseProvider.overrideWith(
                (ref) => FetchWeatherUseCase(
                  ref: ref,
                  repository: client,
                  request: defaultRequest,
                ),
              )
            ],
          );

          final weatherViewUiStateListener = Listener<WeatherViewUiState>();
          container.listen<WeatherViewUiState>(
            weatherViewUiStateProvider,
            weatherViewUiStateListener,
            fireImmediately: true,
          );

          final maxTemperatureUiStateListener = Listener<TemperatureUiState>();
          container.listen<TemperatureUiState>(
            maxTemperatureUiStateProvider,
            maxTemperatureUiStateListener,
            fireImmediately: true,
          );

          final minTemperatureUiStateListener = Listener<TemperatureUiState>();
          container.listen<TemperatureUiState>(
            minTemperatureUiStateProvider,
            minTemperatureUiStateListener,
            fireImmediately: true,
          );

          final weatherImagePanelUiStateListener =
              Listener<WeatherImagePanelUiState>();
          container.listen<WeatherImagePanelUiState>(
            weatherImagePanelStateProvider,
            weatherImagePanelUiStateListener,
            fireImmediately: true,
          );

          // WeatherViewUiState.initial() is the default value
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.initial(),
          );

          // TemperatureUiState.initial() is the default value
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );

          // TemperatureUiState.initial() is the default value
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );

          //  WeatherImagePanelUiState.initial() is the default value
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );

          // the weatherViewUiStateListener is called immediately
          // with WeatherViewUiState.initial(), the default value
          verify(
            weatherViewUiStateListener(
              null,
              const WeatherViewUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(weatherViewUiStateListener);

          // call the process of FetchWeatherUseCase
          container.read(fetchWeatherUseCaseProvider).call();

          // the weatherImagePanelUiStateListener is called immediately
          // with WeatherImagePanelUiState.error(Strings.invalidParameterError)
          verify(
            weatherViewUiStateListener(
              const WeatherViewUiState.initial(),
              const WeatherViewUiState.error(
                Strings.unknownError,
              ),
            ),
          ).called(1);
          verifyNoMoreInteractions(weatherViewUiStateListener);

          // the maxTemperatureUiStateListener is called immediately
          // with TemperatureUiState.initial(), the default value
          verify(
            maxTemperatureUiStateListener(
              null,
              const TemperatureUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(maxTemperatureUiStateListener);

          // the maxTemperatureUiStateListener is called immediately
          // with TemperatureUiState.initial(), the default value
          verify(
            minTemperatureUiStateListener(
              null,
              const TemperatureUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(minTemperatureUiStateListener);

          // the weatherImagePanelUiStateListener is called immediately
          // with WeatherImagePanelUiState.initial(), the default value
          verify(
            weatherImagePanelUiStateListener(
              null,
              const WeatherImagePanelUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(weatherImagePanelUiStateListener);
        },
      );

      test(
        '''
        When parameter is invalid,
        update only WeatherViewUiState to Error.
        ''',
        () {
          when(
            client.getWeather(request: defaultRequest),
          ).thenReturn(
            const AppApiResult.failure(
              message: Strings.invalidParameterError,
            ),
          );
          final container = ProviderContainer(
            overrides: [
              fetchWeatherUseCaseProvider.overrideWith(
                (ref) => FetchWeatherUseCase(
                  ref: ref,
                  repository: client,
                  request: defaultRequest,
                ),
              )
            ],
          );

          final weatherViewUiStateListener = Listener<WeatherViewUiState>();
          container.listen<WeatherViewUiState>(
            weatherViewUiStateProvider,
            weatherViewUiStateListener,
            fireImmediately: true,
          );

          final maxTemperatureUiStateListener = Listener<TemperatureUiState>();
          container.listen<TemperatureUiState>(
            maxTemperatureUiStateProvider,
            maxTemperatureUiStateListener,
            fireImmediately: true,
          );

          final minTemperatureUiStateListener = Listener<TemperatureUiState>();
          container.listen<TemperatureUiState>(
            minTemperatureUiStateProvider,
            minTemperatureUiStateListener,
            fireImmediately: true,
          );

          final weatherImagePanelUiStateListener =
              Listener<WeatherImagePanelUiState>();
          container.listen<WeatherImagePanelUiState>(
            weatherImagePanelStateProvider,
            weatherImagePanelUiStateListener,
            fireImmediately: true,
          );

          // WeatherViewUiState.initial() is the default value
          expect(
            container.read(weatherViewUiStateProvider),
            const WeatherViewUiState.initial(),
          );

          // TemperatureUiState.initial() is the default value
          expect(
            container.read(maxTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );

          // TemperatureUiState.initial() is the default value
          expect(
            container.read(minTemperatureUiStateProvider),
            const TemperatureUiState.initial(),
          );

          //  WeatherImagePanelUiState.initial() is the default value
          expect(
            container.read(weatherImagePanelStateProvider),
            const WeatherImagePanelUiState.initial(),
          );

          // the weatherViewUiStateListener is called immediately
          // with WeatherViewUiState.initial(), the default value
          verify(
            weatherViewUiStateListener(
              null,
              const WeatherViewUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(weatherViewUiStateListener);

          // call the process of FetchWeatherUseCase
          container.read(fetchWeatherUseCaseProvider).call();

          // the weatherImagePanelUiStateListener is called immediately
          // with WeatherImagePanelUiState.error(Strings.invalidParameterError)
          verify(
            weatherViewUiStateListener(
              const WeatherViewUiState.initial(),
              const WeatherViewUiState.error(
                Strings.invalidParameterError,
              ),
            ),
          ).called(1);
          verifyNoMoreInteractions(weatherViewUiStateListener);

          // the maxTemperatureUiStateListener is called immediately
          // with TemperatureUiState.initial(), the default value
          verify(
            maxTemperatureUiStateListener(
              null,
              const TemperatureUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(maxTemperatureUiStateListener);

          // the maxTemperatureUiStateListener is called immediately
          // with TemperatureUiState.initial(), the default value
          verify(
            minTemperatureUiStateListener(
              null,
              const TemperatureUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(minTemperatureUiStateListener);

          // the weatherImagePanelUiStateListener is called immediately
          // with WeatherImagePanelUiState.initial(), the default value
          verify(
            weatherImagePanelUiStateListener(
              null,
              const WeatherImagePanelUiState.initial(),
            ),
          ).called(1);
          verifyNoMoreInteractions(weatherImagePanelUiStateListener);
        },
      );
    },
  );
  test(
    '''
    If the same value as the previous value is obtained,
    don't update providers
    ''',
    () {
      when(
        client.getWeather(request: defaultRequest),
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

      final container = ProviderContainer(
        overrides: [
          fetchWeatherUseCaseProvider.overrideWith(
            (ref) => FetchWeatherUseCase(
              ref: ref,
              repository: client,
              request: defaultRequest,
            ),
          ),
          maxTemperatureUiStateProvider.overrideWith(
            (_) => const TemperatureUiState.data(25),
          ),
          minTemperatureUiStateProvider.overrideWith(
            (_) => const TemperatureUiState.data(7),
          ),
          weatherImagePanelStateProvider.overrideWith(
            (_) => const WeatherImagePanelUiState.data(
              WeatherCondition.cloudy,
            ),
          )
        ],
      );
      final weatherViewUiStateListener = Listener<WeatherViewUiState>();
      container.listen<WeatherViewUiState>(
        weatherViewUiStateProvider,
        weatherViewUiStateListener,
        fireImmediately: true,
      );

      final maxTemperatureUiStateListener = Listener<TemperatureUiState>();
      container.listen<TemperatureUiState>(
        maxTemperatureUiStateProvider,
        maxTemperatureUiStateListener,
        fireImmediately: true,
      );

      final minTemperatureUiStateListener = Listener<TemperatureUiState>();
      container.listen<TemperatureUiState>(
        minTemperatureUiStateProvider,
        minTemperatureUiStateListener,
        fireImmediately: true,
      );

      final weatherImagePanelUiStateListener =
          Listener<WeatherImagePanelUiState>();
      container.listen<WeatherImagePanelUiState>(
        weatherImagePanelStateProvider,
        weatherImagePanelUiStateListener,
        fireImmediately: true,
      );
      container.read(fetchWeatherUseCaseProvider).call();

      // WeatherViewUiState.initial() is the default value
      expect(
        container.read(weatherViewUiStateProvider),
        const WeatherViewUiState.initial(),
      );
      verify(
        weatherViewUiStateListener(
          null,
          const WeatherViewUiState.initial(),
        ),
      );
      verifyNoMoreInteractions(weatherViewUiStateListener);

      // maxTemperatureUiStateProvider should not be update
      expect(
        container.read(maxTemperatureUiStateProvider),
        const TemperatureUiState.data(25),
      );
      verifyInOrder(
        [
          maxTemperatureUiStateListener(
            null,
            const TemperatureUiState.data(25),
          ),
        ],
      );
      verifyNoMoreInteractions(maxTemperatureUiStateListener);

      // minTemperatureUiStateProvider should not be update
      expect(
        container.read(minTemperatureUiStateProvider),
        const TemperatureUiState.data(7),
      );
      verifyInOrder(
        [
          minTemperatureUiStateListener(
            null,
            const TemperatureUiState.data(7),
          ),
        ],
      );
      verifyNoMoreInteractions(minTemperatureUiStateListener);

      // weatherImagePanelStateProvider should not be update
      expect(
        container.read(weatherImagePanelStateProvider),
        const WeatherImagePanelUiState.data(WeatherCondition.cloudy),
      );
      verifyInOrder(
        [
          weatherImagePanelUiStateListener(
            null,
            const WeatherImagePanelUiState.data(WeatherCondition.cloudy),
          ),
        ],
      );
      verifyNoMoreInteractions(weatherImagePanelUiStateListener);
    },
  );
}
