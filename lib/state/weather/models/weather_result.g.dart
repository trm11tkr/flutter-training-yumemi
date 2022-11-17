// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherResult _$$_WeatherResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_WeatherResult',
      json,
      ($checkedConvert) {
        final val = _$_WeatherResult(
          weatherCondition:
              $checkedConvert('weather_condition', (v) => v as String),
          maxTemperature: $checkedConvert('max_temperature', (v) => v as int),
          minTemperature: $checkedConvert('min_temperature', (v) => v as int),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'weatherCondition': 'weather_condition',
        'maxTemperature': 'max_temperature',
        'minTemperature': 'min_temperature'
      },
    );

Map<String, dynamic> _$$_WeatherResultToJson(_$_WeatherResult instance) =>
    <String, dynamic>{
      'weather_condition': instance.weatherCondition,
      'max_temperature': instance.maxTemperature,
      'min_temperature': instance.minTemperature,
      'date': instance.date.toIso8601String(),
    };
