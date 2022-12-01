import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError implements Exception {
  const factory AppError.invalidParameter({required String message}) = _Invalid;
  const factory AppError.unknown({required String message}) = _Unknown;
  const factory AppError.other({required String message}) = _Others;
}
