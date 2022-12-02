import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';

void main() {
  group(
    'toJson of WeatherRequest',
    () {
      test(
        'default WeatherRequest',
        () {
          const weatherRequest = WeatherRequest();

          final weatherJson = weatherRequest.toJson();

          expect(weatherJson['area'], 'tokyo');
          expect(weatherJson['date'], '2020-04-01T12:00:00+09:00');
        },
      );

      test(
        'custom WeatherRequest',
        () {
          const weatherRequest = WeatherRequest(
            area: 'kyoto',
            date: '2023-12-01T12:00:00+02:00',
          );

          final weatherJson = weatherRequest.toJson();

          expect(weatherJson['area'], 'kyoto');
          expect(weatherJson['date'], '2023-12-01T12:00:00+02:00');
        },
      );
    },
  );
}
