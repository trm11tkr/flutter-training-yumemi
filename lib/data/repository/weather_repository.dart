import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/data_source/weather_data_source.dart';
import 'package:flutter_training/data/models/result.dart';
import 'package:flutter_training/data/models/weather/weather_result.dart';


final weatherRepositoryProvider = Provider<WeatherRepository>(
  WeatherRepository.new,
);

class WeatherRepository {
  WeatherRepository(Ref ref)
      : _dataSource = ref.read(weatherDataSourceProvider);

  final WeatherDataSource _dataSource;

  Result<WeatherResult> fetch() {
    return Result.guard(
      _dataSource.fetch,
    );
  }
}
