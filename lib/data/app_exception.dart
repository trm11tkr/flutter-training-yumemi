import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException implements Exception {
  const factory AppException.invalidParameter({required String message}) =
      _Invalid;
  const factory AppException.unknown({required String message}) = _Unknown;
  const factory AppException.other({required String message}) = _Others;
}
