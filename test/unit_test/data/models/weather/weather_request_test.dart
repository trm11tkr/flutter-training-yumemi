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

          final act = weatherRequest.toJson();
          final expected = {
            'area': 'tokyo',
            'date': '2020-04-01T12:00:00+09:00'
          };

          expect(act, expected);
        },
      );

      test(
        'custom WeatherRequest',
        () {
          const weatherRequest = WeatherRequest(
            area: 'kyoto',
            date: '2023-12-01T12:00:00+02:00',
          );

          final act = weatherRequest.toJson();
          final expected = {
            'area': 'kyoto',
            'date': '2023-12-01T12:00:00+02:00'
          };

          expect(act, expected);
        },
      );
    },
  );
}
