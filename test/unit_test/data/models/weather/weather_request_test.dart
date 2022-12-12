import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';

void main() {
  group(
    'toJson of WeatherRequest',
    () {
      test(
        'custom WeatherRequest',
        () {
          final weatherRequest = WeatherRequest(
            area: 'kyoto',
            date: DateTime(2023, 1, 1, 1),
          );

          final act = weatherRequest.toJson();
          final expected = {'area': 'kyoto', 'date': '2023-01-01T01:00:00.000'};

          expect(act, expected);
        },
      );
    },
  );
}
