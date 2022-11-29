import 'package:flutter_training/views/constants/strings.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

enum AppErrorType {
  invalidedParameter,
  unknown,
  simple,
}

class YumemiWeatherApiError implements Exception {
  const YumemiWeatherApiError({
    required this.errorType,
  });
  final YumemiWeatherError errorType;
}

class AppError {
  AppError(Exception? error) {
    if (error is YumemiWeatherApiError) {
      switch (error.errorType) {
        case YumemiWeatherError.invalidParameter:
          message = Strings.invalidParameterError;
          errorType = AppErrorType.invalidedParameter;
          break;
        case YumemiWeatherError.unknown:
          message = Strings.unknownError;
          errorType = AppErrorType.unknown;
          break;
      }
    } else {
      message = Strings.simpleError;
      errorType = AppErrorType.simple;
    }
  }
  late String message;
  late AppErrorType errorType;
}
