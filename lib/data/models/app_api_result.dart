import 'package:flutter_training/data/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_api_result.freezed.dart';

@freezed
class AppApiResult<T> with _$AppApiResult<T> {
  const AppApiResult._();
  const factory AppApiResult.success({required T data}) = _Success<T>;
  const factory AppApiResult.failure({required String message}) = _Failure<T>;

  static AppApiResult<T> guard<T>(T Function() body) {
    try {
      return AppApiResult.success(
        data: body(),
      );
    } on AppException catch (error) {
      return AppApiResult.failure(
        message: error.message,
      );
    }
  }
}
