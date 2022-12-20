import 'package:flutter_test/flutter_test.dart';

import 'fixture/weather_request_fixture.dart';

void main() {
  group(
    'success case: toJson of WeatherRequest',
    () {
      test(
        'success case: toJson of WeatherRequest',
        () {
          final weatherRequestsWithJsonArray =
              WeatherRequestFixture.factory().makeManyWithJsonArray(10);
          for (final weatherRequestWithJson in weatherRequestsWithJsonArray) {
            final act = weatherRequestWithJson.object.toJson();
            final expected = weatherRequestWithJson.json;
            expect(act, expected);
          }
        },
      );
    },
  );
}
