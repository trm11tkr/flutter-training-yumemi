import 'package:flutter_training/data/app_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const Result._();
  const factory Result.success({required T data}) = _Success<T>;
  const factory Result.failure({required String message}) = _Failure<T>;

  static Result<T> guard<T>(T Function() body) {
    try {
      return Result.success(
        data: body(),
      );
    } on AppError catch (error) {
      return Result.failure(
        message: error.message,
      );
    }
  }
}
