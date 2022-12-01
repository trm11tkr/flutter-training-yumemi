import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_source/weather_data_source.dart';
import 'package:flutter_training/data/models/result.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) {
    final dataSource = ref.watch(weatherDataSourceProvider);

    return WeatherRepository._(dataSource);
  },
);

class WeatherRepository {
  WeatherRepository._(this._dataSource);

  final WeatherDataSource _dataSource;

  Result<Weather> getWeather({required WeatherRequest request}) {
    return Result.guard(
      () => _dataSource.getWeather(request: request),
    );
  }
}
