import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:flutter_training/data/models/weather/weather.dart';
import '../../../../../extension/extension.dart';

extension WeatherFixture on Weather {
  static WeatherFixtureFactory factory() => WeatherFixtureFactory();
}

class WeatherFixtureFactory extends JsonFixtureFactory<Weather> {
  @override
  FixtureDefinition<Weather> definition() => define(
        (faker) {
          final weatherCondition =
              WeatherCondition.values[faker.randomGenerator.integer(
            WeatherCondition.values.length,
          )];
          final maxTemperature = faker.randomGenerator.integer(40, min: 10);
          final minTemperature =
              faker.randomGenerator.integer(maxTemperature, min: -40);
          final date = faker.date
              .dateTimeBetween(
                DateTime(2022),
                DateTime(2023),
              )
              .convertAppApiDateTimeToString();

          return Weather(
            weatherCondition: weatherCondition,
            maxTemperature: faker.randomGenerator.integer(100, min: 10),
            minTemperature: minTemperature,
            date: DateTime.parse(date),
          );
        },
      );

  @override
  JsonFixtureDefinition<Weather> jsonDefinition() => defineJson(
        (weather) => {
          'weather_condition': weather.weatherCondition.name,
          'max_temperature': weather.maxTemperature,
          'min_temperature': weather.minTemperature,
          'date': weather.date.convertAppApiDateTimeToString(),
        },
      );
}
