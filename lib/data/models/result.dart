import 'package:flutter_training/data/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();
  const factory Result.success({required T data}) = Success<T>;
  const factory Result.failure({required AppError error}) = Failure<T>;

  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(data: body());
    } on YumemiWeatherError catch (error) {
      return Result.failure(
        error: AppError(
          YumemiWeatherApiError(errorType: error),
        ),
      );
    } on Exception catch (error) {
      return Result.failure(
        error: AppError(error),
      );
    }
  }
}
