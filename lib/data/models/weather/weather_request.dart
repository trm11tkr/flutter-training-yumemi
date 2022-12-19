import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_request.freezed.dart';
part 'weather_request.g.dart';

final weatherRequestStateProvider = StateProvider<WeatherRequest>(
  (_) {
    return WeatherRequest(
      date: DateTime.now(),
    );
  },
);

@freezed
class WeatherRequest with _$WeatherRequest {
  const factory WeatherRequest({
    @Default('tokyo') String area,
    required DateTime date,
  }) = _WeatherRequest;

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);
}
