// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'weather_view_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeatherViewUiState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(WeatherResult weather) data,
    required TResult Function(YumemiWeatherError error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(WeatherResult weather)? data,
    TResult? Function(YumemiWeatherError error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(WeatherResult weather)? data,
    TResult Function(YumemiWeatherError error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Initial value) $default, {
    required TResult Function(Data value) data,
    required TResult Function(YumemiError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Initial value)? $default, {
    TResult? Function(Data value)? data,
    TResult? Function(YumemiError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(Data value)? data,
    TResult Function(YumemiError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherViewUiStateCopyWith<$Res> {
  factory $WeatherViewUiStateCopyWith(
          WeatherViewUiState value, $Res Function(WeatherViewUiState) then) =
      _$WeatherViewUiStateCopyWithImpl<$Res, WeatherViewUiState>;
}

/// @nodoc
class _$WeatherViewUiStateCopyWithImpl<$Res, $Val extends WeatherViewUiState>
    implements $WeatherViewUiStateCopyWith<$Res> {
  _$WeatherViewUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res>
    extends _$WeatherViewUiStateCopyWithImpl<$Res, _$Initial>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'WeatherViewUiState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(WeatherResult weather) data,
    required TResult Function(YumemiWeatherError error) error,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(WeatherResult weather)? data,
    TResult? Function(YumemiWeatherError error)? error,
  }) {
    return $default?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(WeatherResult weather)? data,
    TResult Function(YumemiWeatherError error)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Initial value) $default, {
    required TResult Function(Data value) data,
    required TResult Function(YumemiError value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Initial value)? $default, {
    TResult? Function(Data value)? data,
    TResult? Function(YumemiError value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(Data value)? data,
    TResult Function(YumemiError value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Initial implements WeatherViewUiState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class _$$DataCopyWith<$Res> {
  factory _$$DataCopyWith(_$Data value, $Res Function(_$Data) then) =
      __$$DataCopyWithImpl<$Res>;
  @useResult
  $Res call({WeatherResult weather});

  $WeatherResultCopyWith<$Res> get weather;
}

/// @nodoc
class __$$DataCopyWithImpl<$Res>
    extends _$WeatherViewUiStateCopyWithImpl<$Res, _$Data>
    implements _$$DataCopyWith<$Res> {
  __$$DataCopyWithImpl(_$Data _value, $Res Function(_$Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weather = null,
  }) {
    return _then(_$Data(
      null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as WeatherResult,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $WeatherResultCopyWith<$Res> get weather {
    return $WeatherResultCopyWith<$Res>(_value.weather, (value) {
      return _then(_value.copyWith(weather: value));
    });
  }
}

/// @nodoc

class _$Data implements Data {
  const _$Data(this.weather);

  @override
  final WeatherResult weather;

  @override
  String toString() {
    return 'WeatherViewUiState.data(weather: $weather)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Data &&
            (identical(other.weather, weather) || other.weather == weather));
  }

  @override
  int get hashCode => Object.hash(runtimeType, weather);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataCopyWith<_$Data> get copyWith =>
      __$$DataCopyWithImpl<_$Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(WeatherResult weather) data,
    required TResult Function(YumemiWeatherError error) error,
  }) {
    return data(weather);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(WeatherResult weather)? data,
    TResult? Function(YumemiWeatherError error)? error,
  }) {
    return data?.call(weather);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(WeatherResult weather)? data,
    TResult Function(YumemiWeatherError error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(weather);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Initial value) $default, {
    required TResult Function(Data value) data,
    required TResult Function(YumemiError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Initial value)? $default, {
    TResult? Function(Data value)? data,
    TResult? Function(YumemiError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(Data value)? data,
    TResult Function(YumemiError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class Data implements WeatherViewUiState {
  const factory Data(final WeatherResult weather) = _$Data;

  WeatherResult get weather;
  @JsonKey(ignore: true)
  _$$DataCopyWith<_$Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$YumemiErrorCopyWith<$Res> {
  factory _$$YumemiErrorCopyWith(
          _$YumemiError value, $Res Function(_$YumemiError) then) =
      __$$YumemiErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({YumemiWeatherError error});
}

/// @nodoc
class __$$YumemiErrorCopyWithImpl<$Res>
    extends _$WeatherViewUiStateCopyWithImpl<$Res, _$YumemiError>
    implements _$$YumemiErrorCopyWith<$Res> {
  __$$YumemiErrorCopyWithImpl(
      _$YumemiError _value, $Res Function(_$YumemiError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$YumemiError(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as YumemiWeatherError,
    ));
  }
}

/// @nodoc

class _$YumemiError implements YumemiError {
  const _$YumemiError(this.error);

  @override
  final YumemiWeatherError error;

  @override
  String toString() {
    return 'WeatherViewUiState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YumemiError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YumemiErrorCopyWith<_$YumemiError> get copyWith =>
      __$$YumemiErrorCopyWithImpl<_$YumemiError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function(WeatherResult weather) data,
    required TResult Function(YumemiWeatherError error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function(WeatherResult weather)? data,
    TResult? Function(YumemiWeatherError error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function(WeatherResult weather)? data,
    TResult Function(YumemiWeatherError error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(Initial value) $default, {
    required TResult Function(Data value) data,
    required TResult Function(YumemiError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(Initial value)? $default, {
    TResult? Function(Data value)? data,
    TResult? Function(YumemiError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(Initial value)? $default, {
    TResult Function(Data value)? data,
    TResult Function(YumemiError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class YumemiError implements WeatherViewUiState {
  const factory YumemiError(final YumemiWeatherError error) = _$YumemiError;

  YumemiWeatherError get error;
  @JsonKey(ignore: true)
  _$$YumemiErrorCopyWith<_$YumemiError> get copyWith =>
      throw _privateConstructorUsedError;
}
