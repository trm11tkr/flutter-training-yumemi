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

import '../../../mocks/mock_weather_repository.mocks.dart';

class Listener<T> extends Mock {
  void call(T? previous, T value);
}

@GenerateMocks([WeatherRepository])
void main() {
  final defaultRequest = WeatherRequest(
    date: DateTime.now(),
  );
  final repository = MockWeatherRepository();

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

          final container = ProviderContainer(
            overrides: [
              fetchWeatherUseCaseProvider.overrideWith(
                (ref) => FetchWeatherUseCase(
                  ref: ref,
                  repository: repository,
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

          // the TemperatureUiState is called immediately
          // with TemperatureUiState.initial(), the default value
          // After that, maxTemperatureUiStateProvider is updated only once.
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

          // the TemperatureUiState is called immediately
          // with TemperatureUiState.initial(), the default value
          // After that, minTemperatureUiStateProvider is updated only once.
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

          // the TemperatureUiState is called immediately
          // with TemperatureUiState.initial(), the default value
          // After that, weatherImagePanelStateProvider is updated only once.
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
            repository.getWeather(request: defaultRequest),
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
                  repository: repository,
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

          // call the process of FetchWeatherUseCase
          container.read(fetchWeatherUseCaseProvider).call();

          // the WeatherViewUiState is called immediately
          // with WeatherViewUiState.initial(), the default value
          // After that, weatherViewUiStateProvider is updated only once.
          verifyInOrder(
            [
              weatherViewUiStateListener(
                null,
                const WeatherViewUiState.initial(),
              ),
              weatherViewUiStateListener(
                const WeatherViewUiState.initial(),
                const WeatherViewUiState.error(
                  Strings.unknownError,
                ),
              ),
            ],
          );
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
            repository.getWeather(request: defaultRequest),
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
                  repository: repository,
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

          // call the process of FetchWeatherUseCase
          container.read(fetchWeatherUseCaseProvider).call();

          // the WeatherViewUiState is called immediately
          // with WeatherViewUiState.initial(), the default value
          // After that, weatherViewUiStateProvider is updated only once.
          verifyInOrder(
            [
              weatherViewUiStateListener(
                null,
                const WeatherViewUiState.initial(),
              ),
              weatherViewUiStateListener(
                const WeatherViewUiState.initial(),
                const WeatherViewUiState.error(
                  Strings.invalidParameterError,
                ),
              ),
            ],
          );
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

      final container = ProviderContainer(
        overrides: [
          fetchWeatherUseCaseProvider.overrideWith(
            (ref) => FetchWeatherUseCase(
              ref: ref,
              repository: repository,
              request: defaultRequest,
            ),
          ),
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

      // call the process of FetchWeatherUseCase
      container.read(fetchWeatherUseCaseProvider).call();

      // call the process of FetchWeatherUseCase again
      container.read(fetchWeatherUseCaseProvider).call();

      // the TemperatureUiState is called immediately
      // with TemperatureUiState.initial(), the default value
      // After that, maxTemperatureUiStateProvider is updated only once.
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

      // the TemperatureUiState is called immediately
      // with TemperatureUiState.initial(), the default value
      // After that, minTemperatureUiStateProvider is updated only once.
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

      // the TemperatureUiState is called immediately
      // with TemperatureUiState.initial(), the default value
      // After that, weatherImagePanelStateProvider is updated only once.
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
}
