// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppException {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidParameter,
    required TResult Function(String message) unknown,
    required TResult Function(String message) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidParameter,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidParameter,
    TResult Function(String message)? unknown,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Invalid value) invalidParameter,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Others value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Invalid value)? invalidParameter,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Others value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Invalid value)? invalidParameter,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Others value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppExceptionCopyWith<AppException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppExceptionCopyWith<$Res> {
  factory $AppExceptionCopyWith(
          AppException value, $Res Function(AppException) then) =
      _$AppExceptionCopyWithImpl<$Res, AppException>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AppExceptionCopyWithImpl<$Res, $Val extends AppException>
    implements $AppExceptionCopyWith<$Res> {
  _$AppExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InvalidCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory _$$_InvalidCopyWith(
          _$_Invalid value, $Res Function(_$_Invalid) then) =
      __$$_InvalidCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_InvalidCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$_Invalid>
    implements _$$_InvalidCopyWith<$Res> {
  __$$_InvalidCopyWithImpl(_$_Invalid _value, $Res Function(_$_Invalid) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_Invalid(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Invalid implements _Invalid {
  const _$_Invalid({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppException.invalidParameter(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Invalid &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InvalidCopyWith<_$_Invalid> get copyWith =>
      __$$_InvalidCopyWithImpl<_$_Invalid>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidParameter,
    required TResult Function(String message) unknown,
    required TResult Function(String message) other,
  }) {
    return invalidParameter(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidParameter,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? other,
  }) {
    return invalidParameter?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidParameter,
    TResult Function(String message)? unknown,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) {
    if (invalidParameter != null) {
      return invalidParameter(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Invalid value) invalidParameter,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Others value) other,
  }) {
    return invalidParameter(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Invalid value)? invalidParameter,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Others value)? other,
  }) {
    return invalidParameter?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Invalid value)? invalidParameter,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Others value)? other,
    required TResult orElse(),
  }) {
    if (invalidParameter != null) {
      return invalidParameter(this);
    }
    return orElse();
  }
}

abstract class _Invalid implements AppException {
  const factory _Invalid({required final String message}) = _$_Invalid;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_InvalidCopyWith<_$_Invalid> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UnknownCopyWith<$Res>
    implements $AppExceptionCopyWith<$Res> {
  factory _$$_UnknownCopyWith(
          _$_Unknown value, $Res Function(_$_Unknown) then) =
      __$$_UnknownCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_UnknownCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$_Unknown>
    implements _$$_UnknownCopyWith<$Res> {
  __$$_UnknownCopyWithImpl(_$_Unknown _value, $Res Function(_$_Unknown) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_Unknown(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Unknown implements _Unknown {
  const _$_Unknown({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppException.unknown(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Unknown &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnknownCopyWith<_$_Unknown> get copyWith =>
      __$$_UnknownCopyWithImpl<_$_Unknown>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidParameter,
    required TResult Function(String message) unknown,
    required TResult Function(String message) other,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidParameter,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? other,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidParameter,
    TResult Function(String message)? unknown,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Invalid value) invalidParameter,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Others value) other,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Invalid value)? invalidParameter,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Others value)? other,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Invalid value)? invalidParameter,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Others value)? other,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _Unknown implements AppException {
  const factory _Unknown({required final String message}) = _$_Unknown;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_UnknownCopyWith<_$_Unknown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_OthersCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory _$$_OthersCopyWith(_$_Others value, $Res Function(_$_Others) then) =
      __$$_OthersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_OthersCopyWithImpl<$Res>
    extends _$AppExceptionCopyWithImpl<$Res, _$_Others>
    implements _$$_OthersCopyWith<$Res> {
  __$$_OthersCopyWithImpl(_$_Others _value, $Res Function(_$_Others) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_Others(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Others implements _Others {
  const _$_Others({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppException.other(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Others &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OthersCopyWith<_$_Others> get copyWith =>
      __$$_OthersCopyWithImpl<_$_Others>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) invalidParameter,
    required TResult Function(String message) unknown,
    required TResult Function(String message) other,
  }) {
    return other(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? invalidParameter,
    TResult? Function(String message)? unknown,
    TResult? Function(String message)? other,
  }) {
    return other?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? invalidParameter,
    TResult Function(String message)? unknown,
    TResult Function(String message)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Invalid value) invalidParameter,
    required TResult Function(_Unknown value) unknown,
    required TResult Function(_Others value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Invalid value)? invalidParameter,
    TResult? Function(_Unknown value)? unknown,
    TResult? Function(_Others value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Invalid value)? invalidParameter,
    TResult Function(_Unknown value)? unknown,
    TResult Function(_Others value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class _Others implements AppException {
  const factory _Others({required final String message}) = _$_Others;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_OthersCopyWith<_$_Others> get copyWith =>
      throw _privateConstructorUsedError;
}
