import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_source/weather_data_source.dart';
import 'package:flutter_training/data/models/app_api_result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';
import 'package:meta/meta.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) {
    final dataSource = ref.watch(weatherDataSourceProvider);

    return WeatherRepository(dataSource);
  },
);

class WeatherRepository {
  @visibleForTesting
  WeatherRepository(this._dataSource);

  final WeatherDataSource _dataSource;

  AppApiResult<Weather> getWeather({required WeatherRequest request}) {
    return AppApiResult.guard(
      () => _dataSource.getWeather(request: request),
    );
  }
}
