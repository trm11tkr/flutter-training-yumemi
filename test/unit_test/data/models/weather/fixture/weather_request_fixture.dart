import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:flutter_training/data/models/weather/weather_request.dart';

extension WeatherRequestFixture on WeatherRequest {
  static WeatherRequestFixtureFactory factory() =>
      WeatherRequestFixtureFactory();
}

class WeatherRequestFixtureFactory extends JsonFixtureFactory<WeatherRequest> {
  @override
  FixtureDefinition<WeatherRequest> definition() => define(
        (faker) {
          final date = DateTime.now();

          return WeatherRequest(
            area: faker.address.city(),
            date: date,
          );
        },
      );

  @override
  JsonFixtureDefinition<WeatherRequest> jsonDefinition() => defineJson(
        (weather) => {
          'area': weather.area,
          'date': weather.date.toIso8601String(),
        },
      );
}
